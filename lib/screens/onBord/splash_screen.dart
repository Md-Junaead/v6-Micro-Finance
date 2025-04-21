// import 'package:flutter/material.dart';
// import 'package:v1_micro_finance/configs/routes/routes_name.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _navigateToHome();
//   }

//   void _navigateToHome() async {
//     await Future.delayed(Duration(seconds: 3), () {
//       Navigator.pushReplacementNamed(context, RoutesName.startedScreen);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // Removed backgroundColor, we don't need it anymore
//       body: Center(
//         child: Image.asset(
//           'assets/splash/splash_screen.gif',
//           width: double.infinity,
//           height: double.infinity,
//           fit: BoxFit.cover, // Makes the GIF full-screen and responsive
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1_micro_finance/configs/routes/routes_name.dart';
import 'package:v1_micro_finance/screens/signin/auth_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // Access the AuthViewModel instance without listening to changes
    final authProvider = Provider.of<AuthViewModel>(context, listen: false);

    // Wait for both the initialization (token check and user info fetch)
    // and a minimum 3-second delay to ensure the splash screen is visible
    await Future.wait([
      authProvider
          .init(), // Asynchronous call to check token and fetch user info
      Future.delayed(const Duration(seconds: 3)), // Minimum display time
    ]);

    // Navigate based on whether a user is logged in
    if (authProvider.user != null) {
      // User is logged in, go to the main app screen
      Navigator.pushReplacementNamed(context, 'BottomNavBar');
    } else {
      // No user logged in, go to the login screen
      Navigator.pushReplacementNamed(context, RoutesName.loginScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/splash/splash_screen.gif',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover, // Makes the GIF full-screen and responsive
        ),
      ),
    );
  }
}
