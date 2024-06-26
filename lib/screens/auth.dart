//import 'package:getting_started/constants/button.dart';
//import 'package:getting_started/constants/colors.dart';
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:getting_started/screens/blue_scan_anime.dart';
import 'package:getting_started/screens/firstpg.dart';
import 'package:getting_started/screens/bluetoothcontrol.dart';
import 'package:swipeable_button_flutter/swipablewidget.dart';
import 'package:swipeable_button_flutter/swipebutton.dart';
import 'package:page_transition/page_transition.dart';
import 'package:getting_started/screens/home.dart';
import 'package:getting_started/controllers/bluetooth_controller.dart';

// class AuthScreen extends StatelessWidget {
//   const AuthScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//           child: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 50.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Testing gigs",
//                 style: TextStyle(
//                     fontSize: 45,
//                     fontWeight: FontWeight.bold,
//                     color: primaryColor),
//               ),
//               Text(
//                 "Connect with the devices",
//                 style: TextStyle(color: Colors.grey),
//               ),
//               Expanded(
//                 child: Image(
//                   image: AssetImage("images/wavetec.png"),
//                 ),
//               ),
//               Button(
//                   label: "START",
//                   press: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => Firstpg()));
//                   }),
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }

// class AuthScreen extends StatelessWidget {
//   const AuthScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background image
//           Positioned.fill(
//             child: Image.asset(
//               "images/bk1.png",
//               fit: BoxFit.cover,
//             ),
//           ),
//           SafeArea(
//             child: Center(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 50.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Spacer(),
//                     //Image.asset("images/wavenobg.jpg", width: 150),
//                     SizedBox(height: 20),
//                     Text(
//                       "Test gigs",
//                       style: TextStyle(
//                         fontSize: 40,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     Spacer(),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => Firstpg()),
//                         );
//                       },
//                       child: Text("NEXT"),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blueAccent,
//                         textStyle: TextStyle(color: Colors.white, fontSize: 16),
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                         //textStyle: TextStyle(fontSize: 16),
//                       ),
//                     ),
//                     Spacer(),
//                     //Image.asset("images/LogoSy.jpg", width: 150),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//*************************8 */

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isFinished = false;

// class AuthScreen extends StatelessWidget {
//   const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/bgnoicon.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Image.asset(
                      "images/removebg.png",
                      width: 300,
                      //alignment:,
                      //height: 200,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Test gigs",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //MaterialPageRoute(builder: (context) => Firstpg()),
                        //MaterialPageRoute(builder: (context) => BlueControlpg()),

                        //);
                        Get.to(() => BlueControlpg());
                      },
                      child: Text("NEXT"),
                      style: ElevatedButton.styleFrom(
                        //backgroundColor: Colors.blueAccent,
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        //textStyle: TextStyle(fontSize: 16),
                      ),
                    ),
                    Spacer(),
                    //Image.asset("images/LogoSy.jpg", width: 150),

                    //********************* */
                    SwipeButton(
                      text: "Slide",
                      onSwipeCallback: () async {
                        await Navigator.push(
                          context,
                          PageTransition(
                            child: const Homepg(),
                            type: PageTransitionType.fade,
                          ),
                        );
                        print("navigated");
                      },
                    ),

                    // SwipeableButtonView(
                    //   buttonText: 'Slide to start',
                    //   buttontextStyle:
                    //       const TextStyle(fontSize: 25, color: Colors.white),
                    //   buttonWidget: const Icon(Icons.arrow_forward_ios_rounded,
                    //       color: Colors.grey),
                    //   activeColor: const Color(0xFF009C41),
                    //   onWaitingProcess: () {
                    //     Future.delayed(const Duration(milliseconds: 200), () {
                    //       setState(() {
                    //         isFinished = true;
                    //       });
                    //     });
                    //   },
                    //   isFinished: isFinished,
                    //   onFinish: () async {
                    //     await Navigator.push(
                    //         context,
                    //         PageTransition(
                    //             type: PageTransitionType.fade,
                    //             child: const Homepg()));

                    //     setState(() => isFinished = false);
                    //   },
                    // ),
                    //************************** */
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
