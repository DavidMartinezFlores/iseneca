import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:iseneca/models/user_local.dart';
import 'package:iseneca/services/firebase_service.dart';
import 'package:iseneca/theme/app_theme.dart';
class PrincipalMenu extends StatelessWidget {
  final UserLocal user;
  const PrincipalMenu({super.key, required this.user});
// bool exist = false;
//                           for(Map<dynamic,dynamic> userMapTemp in userProvider.userMap)
//                           {
                        
//                             if(userGoogle.email==userMapTemp["email"])
//                             {
//                               exist=true;
//                               break;
//                             }
                            
//                           }
//                           if(exist)
//                           {
//                             var user = UserLocal(userName: userGoogle.displayName!, userPassword: "userPassword", center: userGoogle.email!, profile: "profile", fullName: userGoogle.displayName!);
//                             // ignore: use_build_context_synchronously
//                             Navigator.push(context, MaterialPageRoute(builder: (context) => PrincipalMenu(user: user)));
//                           }
//                           else
//                           {
//                              // ignore: use_build_context_synchronously
//                              showDialog(
//                               barrierDismissible: false,
//                               context: context,
//                               builder: (context) => 
//                               AlertDialog(
//                                 actions: [
//                                   Column(
//                                     children: [
//                                       const Text("! CUIDADO !",style: TextStyle(color: Colors.red,fontSize: 30),),
//                                       Text("Usuario NO PERMITIDO (${userGoogle.email})",style:const TextStyle(color: Colors.red)),
//                                       TextButton(onPressed: () {
//                                         service.signOutFromGoogle();
//                                         Navigator.pop(context);
                                        
//                                       }, child: const Text("Reintentar",style: TextStyle(decoration: TextDecoration.underline),)),
//                                     ],
//                                   ),
//                                 ],

//                               )
//                             );
//                           }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final appTheme = const AppTheme().getTheme();

    return FutureBuilder(
      future: fillEmails(), 
      builder: (context, snapshot) {
        if(snapshot.data!=null)
        {
          bool exist = false;
          for(Map<dynamic,dynamic> userMapTemp in jsonDecode(snapshot.data.toString()))
          {
        
            if(user.center==userMapTemp["email"])
            {
              exist=true;
              break;
            }
            
          }
          if(exist)
          {
            // ignore: use_build_context_synchronously
            Navigator.push(context, MaterialPageRoute(builder: (context) => PrincipalMenu(user: user)));
          }
          else
          {
            FirebaseService service = FirebaseService();
              // ignore: use_build_context_synchronously
              showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => 
              AlertDialog(
                actions: [
                  Column(
                    children: [
                      const Text("! CUIDADO !",style: TextStyle(color: Colors.red,fontSize: 30),),
                      Text("Usuario NO PERMITIDO (${user.center})",style:const TextStyle(color: Colors.red)),
                      TextButton(onPressed: () {
                        service.signOutFromGoogle();
                        Navigator.pop(context);
                        
                      }, child: const Text("Reintentar",style: TextStyle(decoration: TextDecoration.underline),)),
                    ],
                  ),
                ],

              )
            );
          }
          return MenuScreen(appTheme: appTheme, screenSize: screenSize, user: user);
        }
        else
        {
          return CircularProgressIndicator();
        }
      },);
    
    //
    
  }
  Future<dynamic>fillEmails()  {
    Dio dio = Dio();
    var response = dio.get('https://script.google.com/macros/s/AKfycbza-4_cGrNwZtsk1JmIvTDq5KBiZZLj-U5aV1h6E6Zxfd56LiAG2XPLEFOuD4K6bmKT-Q/exec?spreadsheetId=1Qt5sghI2oMo-_ODI1pdDBlFkoiE5orcc0fqIvI6P470&sheet=usuarios');
    
    return response;
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({
    super.key,
    required this.appTheme,
    required this.screenSize,
    required this.user,
  });

  final ThemeData appTheme;
  final Size screenSize;
  final UserLocal user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedItemColor: appTheme.primaryColor,
        unselectedItemColor: Colors.grey,
        
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_filled,color: Colors.grey),
            label: 'Inicio',
            activeIcon: Icon(Icons.home_filled,color: appTheme.primaryColor),
          ),
           BottomNavigationBarItem(
            icon: const Icon(Icons.access_time_rounded,color: Colors.grey),
            label: 'Agenda',
            activeIcon: Icon(Icons.access_time_rounded,color: appTheme.primaryColor),
          ),
           BottomNavigationBarItem(
            icon: const Icon(Icons.chat_bubble_outline,color: Colors.grey),
            label: 'Comunicaciones',
            activeIcon: Icon(Icons.chat_bubble_outline,color: appTheme.primaryColor),
          ),
           BottomNavigationBarItem(
            icon: const Icon(Icons.menu,color: Colors.grey),
            label: 'Menu',
            activeIcon: Icon(Icons.menu,color: appTheme.primaryColor),
          ),
        ],
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenSize.height*0.1),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Center(child: Text("iSéneca",style: TextStyle(fontSize:60,color: appTheme.secondaryHeaderColor,fontWeight: FontWeight.bold),)),
          backgroundColor:appTheme.primaryColor,
          
        ),
      ),
      body: Column(
        children: [
          Stack(
            children:[ 

              Container(
              color: appTheme.primaryColor,
              width: screenSize.width,
              height:screenSize.height*0.1 ,),
              
              Align(
                alignment: Alignment.center,
                child: 
                PersonalizedCard(screenSize: screenSize, user: user, appTheme: appTheme),
              ),
            ]
          ),

          SizedBox(
            height: screenSize.height*0.05,
          ),
          
          PersonalizedTable(screenSize: screenSize)
        ],
      ),
    );
  }
}

class PersonalizedCard extends StatelessWidget {
  const PersonalizedCard({
    super.key,
    required this.screenSize,
    required this.user,
    required this.appTheme,
  });

  final Size screenSize;
  final UserLocal user;
  final ThemeData appTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenSize.width*0.95,
      height: screenSize.height*0.22,
      child: 
      Card(
        child: 
        Column(
            children: [
              
              ListTile(
                trailing: IconButton(icon: const Icon(Icons.exit_to_app),onPressed: () {
                  FirebaseService().signOutFromGoogle();
                  Navigator.pop(context);
                },),
                title: Text(user.fullName,style: const TextStyle(fontWeight:FontWeight.bold)),
                subtitle: Text("${user.center} \n${user.profile}",style: TextStyle(color: appTheme.primaryColor,fontSize: 15),),
              ),
              SizedBox(
                height: screenSize.height*0.005,
              ),

              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 44, 147, 207),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12))
                  )
                  ,
                  child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FilledButton.icon(
                          style: const ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(),
                              ),
                            backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 44, 147, 207)),
                          ),
                          onPressed: () {
                          
                        }, icon: const Icon(Icons.alarm),
                        label: const Text("Avisos")
                        ),

                        VerticalDivider(color: appTheme.secondaryHeaderColor),

                        FilledButton.icon(
                          style: const ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(),
                              ),
                            backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 44, 147, 207)),
                          ),
                          onPressed: () {
                          
                        }, icon: const Icon(Icons.book),
                        label: const Text("Avisos")
                        ),
                      ],
                    ),
                 ),
              )

            ],
          )
      ),
    );
  }
}

class PersonalizedTable extends StatelessWidget {
  const PersonalizedTable({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: 
      SizedBox(
        width: screenSize.width*0.95,
        child: 
        Column(
          children: [
            Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border( right: BorderSide(color: Colors.grey.withOpacity(0.3)),bottom: BorderSide(color: Colors.grey.withOpacity(0.3))),
                ),
                width: screenSize.width*0.3,
                height: screenSize.height*0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenSize.width*0.15,
                      child: Image.asset('assets/images/sombrero.png')
                    ),
                    const Text("Alumnado del centro",textAlign: TextAlign.center,)
                  ],
                ),
              ),
    
              Container(
                decoration: BoxDecoration(
                  border: Border( right: BorderSide(color: Colors.grey.withOpacity(0.3)),bottom: BorderSide(color: Colors.grey.withOpacity(0.3))),
                ),
                width: screenSize.width*0.3,
                height: screenSize.height*0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenSize.width*0.15,
                      child: Image.asset('assets/images/profesor.png')
                    ),
                    const Text("Personal del centro",textAlign: TextAlign.center,)
                  ],
                ),
              ),
    
              Container(
                decoration: BoxDecoration(
                  border: Border( bottom: BorderSide(color: Colors.grey.withOpacity(0.3))),
                ),
                width: screenSize.width*0.32,
                height: screenSize.height*0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenSize.width*0.15,
                      child: Image.asset('assets/images/covid.png')
                    ),
                    const Text("Información Covid",textAlign: TextAlign.center,)
                  ],
                ),
              ),
            ],
          ),
    
    
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border( right: BorderSide(color: Colors.grey.withOpacity(0.3))),
                ),
                width: screenSize.width*0.3,
                height: screenSize.height*0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenSize.width*0.1,
                      child: Image.asset('assets/images/campana.png')
                    ),
                    const Text("Tablón de anuncios",textAlign: TextAlign.center,)
                  ],
                ),
              ),
    
              Container(
                decoration: BoxDecoration(
                  border: Border( right: BorderSide(color: Colors.grey.withOpacity(0.3))),
                ),
                width: screenSize.width*0.3,
                height: screenSize.height*0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenSize.width*0.15,
                      child: Image.asset('assets/images/calendario.png')
                    ),
                    const Text("Calendario escolar",textAlign: TextAlign.center,)
                  ],
                ),
              ),
            ],
          ),
       
          ],
        ),
      ),
    );
  }
}