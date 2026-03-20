import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'MusicHomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: "Poppins",
        primaryColor: const Color(0xFF1DB954),
      ),
      home: const AuthPage(),
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with TickerProviderStateMixin {
  bool showLogin = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _phoneController = TextEditingController();

  late AnimationController _vinylController, _visualizerController, _gradientController, _logoPulseController;
  late Animation<double> _logoScale;
  late Animation<Alignment> _topAlignment, _bottomAlignment;

  @override
  void initState() {
    super.initState();
    _vinylController = AnimationController(vsync: this, duration: const Duration(seconds: 15))..repeat();
    _visualizerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500))..repeat(reverse: true);
    _gradientController = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat(reverse: true);
    _logoPulseController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);

    _logoScale = Tween<double>(begin: 1.0, end: 1.15).animate(CurvedAnimation(parent: _logoPulseController, curve: Curves.easeInOut));

    _topAlignment = TweenSequence<Alignment>([
      TweenSequenceItem(tween: AlignmentTween(begin: Alignment.topLeft, end: Alignment.topRight), weight: 1),
      TweenSequenceItem(tween: AlignmentTween(begin: Alignment.topRight, end: Alignment.bottomRight), weight: 1),
    ]).animate(_gradientController);

    _bottomAlignment = TweenSequence<Alignment>([
      TweenSequenceItem(tween: AlignmentTween(begin: Alignment.bottomRight, end: Alignment.bottomLeft), weight: 1),
      TweenSequenceItem(tween: AlignmentTween(begin: Alignment.bottomLeft, end: Alignment.topLeft), weight: 1),
    ]).animate(_gradientController);
  }

  void _togglePage() {
    setState(() {
      showLogin = !showLogin;
      _emailController.clear();
      _passwordController.clear();
      _confirmPassController.clear();
    });
  }

  // --- INTEGRATED FIREBASE AUTH LOGIC ---
  Future<void> _handleEmailAuth() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showError("Fields cannot be empty");
      return;
    }

    try {
      if (showLogin) {
        // Handle Firebase Login
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        _goToHome();
      } else {
        // Handle Firebase Registration
        if (_passwordController.text != _confirmPassController.text) {
          _showError("Passwords do not match");
          return;
        }
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration Successful! Now Login."), backgroundColor: Colors.green),
        );
        _togglePage(); // Move to login after successful signup
      }
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? "Authentication failed");
    }
  }



  // --- SOCIAL LOGIN LOGIC ---
  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
      _goToHome();
    } catch (e) { _showError("Google Access Denied"); }
  }

  Future<void> _signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final credential = FacebookAuthProvider.credential(result.accessToken!.tokenString);
        await _auth.signInWithCredential(credential);
        _goToHome();
      }
    } catch (e) { _showError("Facebook Access Denied"); }
  }

  // --- UI BUILDING ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          _buildAnimatedBackground(),

          // DYNAMIC BACKGROUND ANIMATIONS (Vinyl or Visualizer)
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 1000),
              child: showLogin ? _buildEnhancedVinyl() : _buildEnhancedVisualizer(),
            ),
          ),

          _buildGlassOverlay(),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  _buildAnimatedLogo(), // Animated pulsing logo
                  const SizedBox(height: 15),
                  Text(showLogin ? "Welcome Back" : "Join the Beat",
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: -1)),
                  const SizedBox(height: 50),
                  showLogin ? _buildLoginFields() : _buildSignupFields(),
                  const SizedBox(height: 40),
                  _buildBrandedSocialAuth(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedLogo() {
    return AnimatedBuilder(
      animation: _logoPulseController,
      builder: (context, child) {
        return ScaleTransition(
          scale: _logoScale,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(0.5),
              boxShadow: [
                BoxShadow(
                  color: (showLogin ? Colors.purpleAccent : const Color(0xFF1DB954))
                      .withOpacity(0.5 * _logoPulseController.value),
                  blurRadius: 25 * _logoPulseController.value,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Icon(
              Icons.music_note_rounded,
              color: showLogin ? Colors.purpleAccent : const Color(0xFF1DB954),
              size: 60,
            ),
          ),
        );
      },
    );
  }

  Widget _buildBrandedSocialAuth() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _brandIcon('https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-suite-everything-you-need-know-about-google-newest-0.png', _signInWithGoogle),
        const SizedBox(width: 30),
        _brandIcon('https://www.freepnglogos.com/uploads/facebook-logo-design-1.png', _signInWithFacebook),
        const SizedBox(width: 30),
        _brandIcon('https://cdn-icons-png.flaticon.com/512/3178/3178158.png', _showPhoneLogin),
      ],
    );
  }

  Widget _brandIcon(String url, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 55, width: 55, padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
        child: Image.network(url, fit: BoxFit.contain),
      ),
    );
  }

  Widget _buildLoginFields() => Column(children: [
    _modernField(_emailController, "Email address", Icons.email_outlined),
    const SizedBox(height: 15),
    _modernField(_passwordController, "Password", Icons.lock_outline, isPass: true),
    const SizedBox(height: 30),
    _primaryButton("LOG IN", Colors.purpleAccent, _handleEmailAuth),
    TextButton(onPressed: _togglePage, child: const Text("New here? Create account", style: TextStyle(color: Colors.white70)))
  ]);

  Widget _buildSignupFields() => Column(children: [
    _modernField(_emailController, "Email", Icons.alternate_email),
    const SizedBox(height: 15),
    _modernField(_passwordController, "Password", Icons.lock_outline, isPass: true),
    const SizedBox(height: 15),
    _modernField(_confirmPassController, "Confirm Password", Icons.check_circle_outline, isPass: true),
    const SizedBox(height: 30),
    _primaryButton("GET STARTED", const Color(0xFF1DB954), _handleEmailAuth),
    TextButton(onPressed: _togglePage, child: const Text("Already a member? Login", style: TextStyle(color: Colors.white70)))
  ]);

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _gradientController,
      builder: (context, child) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: _topAlignment.value, end: _bottomAlignment.value,
            colors: showLogin
                ? [const Color(0xFF0F0C29), const Color(0xFF302B63), const Color(0xFF24243E)]
                : [const Color(0xFF000000), const Color(0xFF1DB954).withOpacity(0.4)],
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedVinyl() => Center(
      key: const ValueKey("v"),
      child: RotationTransition(
          turns: _vinylController,
          child: Opacity(
              opacity: 0.1,
              child: Image.network('https://cdn-icons-png.flaticon.com/512/2635/2635398.png', width: 650)
          )
      )
  );

  Widget _buildEnhancedVisualizer() => Align(
      alignment: Alignment.bottomCenter,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(25, (i) => AnimatedBuilder(
              animation: _visualizerController,
              builder: (context, child) => Container(
                  width: 8,
                  height: (Random(i).nextDouble() * 250 + 50) * _visualizerController.value,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF1DB954), Colors.transparent])
                  )
              )
          ))
      )
  );

  Widget _buildGlassOverlay() => Positioned.fill(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12), child: Container(color: Colors.black.withOpacity(0.3))));

  // Reusable Widgets
  Widget _modernField(TextEditingController controller, String hint, IconData icon, {bool isPass = false}) {
    return Container(
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.08), borderRadius: BorderRadius.circular(15)),
      child: TextField(
        controller: controller, obscureText: isPass,
        decoration: InputDecoration(prefixIcon: Icon(icon, color: Colors.white54), hintText: hint, border: InputBorder.none, contentPadding: const EdgeInsets.all(20)),
      ),
    );
  }

  Widget _primaryButton(String text, Color color, VoidCallback onTap) {
    return Container(
      width: double.infinity, height: 60,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), boxShadow: [BoxShadow(color: color.withOpacity(0.4), blurRadius: 15)]),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(backgroundColor: color, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
        child: Text(text, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900)),
      ),
    );
  }

  // Auth Helpers
  void _goToHome() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MusicHomePage()));
  void _showError(String msg) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.redAccent));

  @override
  void dispose() {
    _vinylController.dispose(); _visualizerController.dispose(); _gradientController.dispose(); _logoPulseController.dispose();
    _emailController.dispose(); _passwordController.dispose(); _confirmPassController.dispose(); _phoneController.dispose();
    super.dispose();
  }

  void _showPhoneLogin() { /* Phone Logic from previous iteration */ }
  void _showOtpDialog(String vId) { /* OTP Logic from previous iteration */ }
  Widget _buildPhoneAuthSheet() { return Container(); } // Placeholder for brevity
}