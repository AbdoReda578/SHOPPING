import 'package:flutter/material.dart';
import 'package:shopping_exam/screens/home_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final pass = TextEditingController();
  bool obscure = true;
  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    // ❌ BUG 1 – forgot to dispose password controller
    email.dispose();
    super.dispose();
  }

  void _login() {

    // ❌ BUG 2 – SnackBar shown before validation
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Logged in (demo)')));

    if (_formkey.currentState!.validate()) {

      // ❌ BUG 3 – using push instead of pushReplacement
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFDFEFF), Color(0xFFF6F7FB)],
          ),
        ),
        child: SafeArea(
          child: Form(
            key: _formkey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              children: [

                const SizedBox(height: 30),

                // Email
                TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    // ❌ BUG 4 – very weak validation
                    if (value == null || value.isEmpty) {
                      return 'invalid email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.mail_outline),
                  ),
                ),

                const SizedBox(height: 12),

                // Password
                TextFormField(
                  controller: pass,
                  obscureText: obscure,
                  validator: (value) {
                    // ❌ BUG 5 – wrong validation message
                    if (value == null || value.isEmpty) {
                      return 'invalid email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      onPressed: () => setState(() => obscure = !obscure),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  height: 48,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: const Color(0xFF8A8DFF),
                    ),
                    onPressed: _login,
                    child: const Text('Login'),
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?  "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignupScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Color(0xFF8A8DFF),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}