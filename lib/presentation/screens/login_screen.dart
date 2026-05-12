import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/auth/auth_state.dart';
import '../../data/repositories/auth_repository.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Google', icon: Icon(Icons.login)),
            Tab(text: 'Phone', icon: Icon(Icons.phone)),
          ],
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return TabBarView(
            controller: _tabController,
            children: [
              _buildGoogleLogin(),
              _buildPhoneLogin(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildGoogleLogin() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.restaurant_menu, size: 100, color: Colors.green),
          const SizedBox(height: 48),
          ElevatedButton.icon(
            onPressed: () {
              context.read<AuthBloc>().add(AuthGoogleSignInRequested());
            },
            icon: Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/c/c1/Google_\"G\"_Logo.svg',
              height: 24,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.login),
            ),
            label: const Text('Sign in with Google'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              elevation: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneLogin() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _phoneController,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              hintText: '+1 1234567890',
              prefixIcon: Icon(Icons.phone_outlined),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _verifyPhone,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Send OTP'),
          ),
        ],
      ),
    );
  }

  void _verifyPhone() async {
    final phoneNumber = _phoneController.text.trim();
    if (phoneNumber.isEmpty) return;

    final repository = RepositoryProvider.of<AuthRepository>(context);
    await repository.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      onCodeSent: (verificationId, resendToken) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OtpScreen(verificationId: verificationId),
          ),
        );
      },
      onVerificationFailed: (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Verification failed')),
        );
      },
    );
  }
}
