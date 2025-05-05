import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth-provider.dart';
import '../utils/app_colors.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
     body: Stack(
       children: [
         ClipPath(
           clipper: BottomSlideClipper(),
           child: Container(
             height: 400,
             width: double.infinity,
             decoration: BoxDecoration(
                 gradient: LinearGradient(colors: MyColors.primaryGradientColor)
             ),
           ),
         ),
         Center(
           child: Container(
             margin: EdgeInsets.only(top: 30),
             height: 500,
             width: 300,
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(15),
               boxShadow: [
                 BoxShadow(
                   color: Colors.black.withOpacity(0.2),
                   offset: Offset(0, 10),
                   blurRadius: 10,
                   spreadRadius: -4
                 )
               ]
             ),
             child: Column(
               children: [

               ],
             ),
           ),
         ),
       ],
     ),
    );
  }
}

class BottomSlideClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 80); // Start lower on the left (deeper curve)

    // Curve towards the bottom right
    path.quadraticBezierTo(
      size.width * 0.5, size.height , // control point
      size.width, size.height - 20, // end point (less curve on right)
    );

    path.lineTo(size.width, 0); // Top-right
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

