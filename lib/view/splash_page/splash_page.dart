import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFD563E5),
        body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/img/pic1.png"),
            SizedBox(
              height: 20,
            ),
            Text("Plan Your Expenses",style: TextStyle(color: Colors.white,fontSize:
            20,fontWeight:FontWeight.bold
            ),),
            SizedBox(
              height: 10,
            ),
            Text("Track your travel expenses and reach your \n savings goals faster by planning it all with \n "
                "Pocket Tracker",style: TextStyle(color:Colors.white,fontSize: 16),)

          ],
        ),
      ),
    );
  }
}

