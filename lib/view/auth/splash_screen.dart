// import 'package:balloon/generated/assets.dart';
// import 'package:balloon/main.dart';
// import 'package:balloon/res/app_colors.dart';
// import 'package:balloon/utils/routes/routes_name.dart';
// import 'package:balloon/view_model/services/splash_services.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
//
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   SplashServices splashServices = SplashServices();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       // Navigator.pushNamed(context, RoutesName.loginScreen);
//       final splashServices =
//       Provider.of<SplashServices>(context, listen: false);
//       // splashServices.checkAuthentication(context);
//     });
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: height,
//         width: width,
//         decoration: BoxDecoration(
//           color: Color(0xff0091e0)
//         ),
//         child:Column(
//           children: [
//             SizedBox(height: height*0.05,),
//             Image(image: AssetImage(Assets.imagesLogo)),
//             SizedBox(height: height*0.05,),
//             Lottie.asset(Assets.lottiBalloon,fit: BoxFit.fill,),
//             // Text("Your Luck Starts Now!",style: TextStyle(color: AppColor.white,fontSize: 20,fontWeight: FontWeight.w600),),
//             // Center(
//             //   child: CircularProgressIndicator(
//             //     color: AppColor.white,
//             //   ),
//             // )
//           ],
//         ),
//
//       ),
//     );
//   }
// }
import 'package:balloon/generated/assets.dart';
import 'package:balloon/main.dart';
import 'package:balloon/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:balloon/view_model/services/splash_services.dart';
// import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    // Optionally, you can add some delay here before moving to the next screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final splashServices =
      Provider.of<SplashServices>(context, listen: false);
      splashServices.checkAuthentication(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(

        color: AppColor.blue
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              // image: AssetImage(Assets.imagesLogo),
              image: AssetImage(Assets.imagesLogo),
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            // Add logo with animation for scaling and smooth transition
            // AnimatedOpacity(
            //   opacity: 1.0,
            //   duration: Duration(seconds: 1),
            //   child: AnimatedScale(
            //     scale: 1.2,
            //     duration: Duration(seconds: 1),
            //     child: Image(
            //       image: AssetImage(Assets.imagesLogo),
            //       height: MediaQuery.of(context).size.height * 0.2,
            //     ),
            //   ),
            // ),
            SizedBox(height: 20),
            // Add the animation of the balloon with scaling and bounce effect
            Lottie.asset(
              Assets.lottiBalloon,
              height: MediaQuery.of(context).size.height * 0.4,
              repeat: true,
            ),
            SizedBox(height: 20),
            // Add app title with improved typography
            Text(
              "Balloon Game",  // Replace with your app's name
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: "SitkaSmall",
              ),
            ),
            SizedBox(height: 10),
            // Add a tagline to give users more info about the app
            Text(
              "Let your dreams float",
              style:TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontFamily: "SitkaSmall",
              ),
            ),
            SizedBox(height: 20),
            // Add Linear Progress Indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                backgroundColor: Colors.white24,
              ),
            ),
            SizedBox(height: 20),
            // Optionally, you can add a small "Loading..." text under the progress bar
            Text(
              "Loading...",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontFamily: "SitkaSmall",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
