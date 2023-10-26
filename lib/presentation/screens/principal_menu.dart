import 'package:flutter/material.dart';
import 'package:iseneca/models/user.dart';
import 'package:iseneca/theme/app_theme.dart';
class PrincipalMenu extends StatelessWidget {
  final User user;
  const PrincipalMenu({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final appTheme = AppTheme().getTheme();

    return Scaffold(
      appBar: AppBar(
        title: Text("iSéneca",style: TextStyle(fontSize: 50,color: appTheme.secondaryHeaderColor),),
        backgroundColor:appTheme.primaryColor,
      ),
      body: Stack(
        children:[ 
          Container(color: appTheme.primaryColor,width: screenSize.width,height:screenSize.height*0.1 ,),

          Positioned(
            child: Container(
              width: screenSize.width*0.8,
              height: screenSize.height*0.2,
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Column(
                children: [
                  Text("${user.userName}"),
                  Text("${user.center}"),
                ],
              ),
            ),
          ),
        ]
      ),
    );
  }
}