// ignore_for_file: unrelated_type_equality_checks

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iseneca/conf/providers/users_provider.dart';
import 'package:iseneca/models/user_local.dart';
import 'package:iseneca/presentation/screens/principal_menu.dart';
import 'package:iseneca/services/firebase_service.dart';
import 'package:iseneca/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class LogginScreen extends StatelessWidget {
  const LogginScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    
    final appTheme = const AppTheme().getTheme();
    final screenSize = MediaQuery.of(context).size;

    final userTextController = TextEditingController();
    final passwordTextController = TextEditingController();

    final userProvider = context.watch<UserProvider>();
  
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            height: screenSize.height,
            color: appTheme.primaryColor,child: 
            Center(
            child: SizedBox(
              height: screenSize.height,
              width: screenSize.width*0.9,
              child: Column(
                children: [
                  SizedBox(height: screenSize.height*0.1,),
                  
                  Center(
                    child: Text("iSéneca",style: TextStyle(color: appTheme.secondaryHeaderColor,fontSize: 70,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),)
                  ),
                  SizedBox(height: screenSize.height*0.05,),
      
                  _InputLogginUser(userTextController: userTextController,passwordTextController:passwordTextController,text: 'Usuario'),
      
                  SizedBox(height: screenSize.height*0.04,),
      
                  _InputLogginPassword(userTextController: userTextController,passwordTextController:passwordTextController,text: 'Contraseña'),
      
                  SizedBox(height: screenSize.height*0.04,),
      
                  FilledButton(
                    style: 
                      ButtonStyle(
                        minimumSize: MaterialStatePropertyAll(Size.fromHeight(screenSize.height*0.1)),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(appTheme.secondaryHeaderColor)
                      ),
                    onPressed: () {
                      dynamic user = checkUser(userTextController.value.text, passwordTextController.value.text, userProvider.userList);
                      
                      if(user!=null)
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PrincipalMenu(user: user)));
                      }else{
                        alertDialog(context);
                      }
                    }, 
                    child: Text("Entrar",style: TextStyle(color: appTheme.primaryColor,fontWeight: FontWeight.bold),)
                  ),
                   FilledButton(
                    style: 
                      ButtonStyle(
                        minimumSize: MaterialStatePropertyAll(Size.fromHeight(screenSize.height*0.05)),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(appTheme.secondaryHeaderColor)
                      ),
                    onPressed: () async {
                      FirebaseService service = new FirebaseService();
                      try {
                      await service.signInwithGoogle();
                        User? userGoogle = FirebaseAuth.instance.currentUser;
                        if(userGoogle!=null)
                        {
                          bool exist = false;
                          for(Map<dynamic,dynamic> userMapTemp in userProvider.userMap)
                          {
                        
                            if(userGoogle.email==userMapTemp["email"])
                            {
                              exist=true;
                              break;
                            }
                            
                          }
                          if(exist)
                          {
                            var user = UserLocal(userName: userGoogle.displayName!, userPassword: "userPassword", center: userGoogle.email!, profile: "profile", fullName: userGoogle.displayName!);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PrincipalMenu(user: user)));
                          }
                          else
                          {
                            
                            return showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => 
                              AlertDialog(
                                actions: [
                                  Column(
                                    children: [
                                      const Text("! CUIDADO !",style: TextStyle(color: Colors.red,fontSize: 30),),
                                      Text("Usuario NO PERMITIDO (${userGoogle.email})",style:const TextStyle(color: Colors.red)),
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

                        }
                        } catch(e){
                        if(e is FirebaseAuthException){
                          print("LEGEO ERRONEO");
                        }
          }
                    }, 
                    child: Text("Entrar Con Google",style: TextStyle(color: appTheme.primaryColor,fontWeight: FontWeight.bold),)
                  ),
      
                  SizedBox(height: screenSize.height*0.05,),
      
                  _UnderLineButton(text: 'No recuerdo mi contraseña'),
                  
                  SizedBox(height: screenSize.height*0.03,),
                  
                  ListTile(
                    leading: Image.asset("assets/images/juntaLogo.png"),
                    title: Text("Junta de Andalucia",style: TextStyle(color: appTheme.secondaryHeaderColor,fontWeight:FontWeight.bold)),
                    subtitle: Text("Consejeria de educación y deporte",style: TextStyle(color: appTheme.secondaryHeaderColor,fontWeight:FontWeight.bold,fontSize: 13))
                  ),

                  SizedBox(height: screenSize.height*0.04,),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text("v11.3.0",style: TextStyle(color: appTheme.secondaryHeaderColor,fontWeight:FontWeight.bold,fontSize: 15)))
                ],
              ),
            ),
          ),
        )
      ),
    );
  }

  Future<dynamic> alertDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => 
        AlertDialog(
          actions: [
            Column(
              children: [
                const Text("! CUIDADO !",style: TextStyle(color: Colors.red,fontSize: 30),),
                const Text("Usuario o contraseña incorrectos",style:TextStyle(color: Colors.red)),
                TextButton(onPressed: () {
                  Navigator.pop(context);
                }, child: const Text("Reintentar",style: TextStyle(decoration: TextDecoration.underline),)),
              ],
            ),
          ],

        )
      );
  }

  dynamic checkUser(String userName,String userPasswrod,List<UserLocal> userList)
  {
    for(UserLocal user in userList)
    {
      if(user.userName==userName.trim() && user.userPassword==userPasswrod.trim())
      {
        return user;
      }
    }
    return null;
  }
}

class _UnderLineButton extends StatelessWidget {
  final ThemeData appTheme = const AppTheme().getTheme();
  final String text;
  _UnderLineButton({ required this.text});

  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => 
          AlertDialog(
            actions: [
              Column(
                children: [
                  const Text("! RECUPERACION!",style: TextStyle(color: Colors.red,fontSize: 20),),
                  const Text("Actualmente no es posible recuperar la password",style:TextStyle(color: Colors.red),textAlign: TextAlign.center,),
                  TextButton(onPressed: () {
                    Navigator.pop(context);
                  }, child: const Text("Reintentar",style: TextStyle(decoration: TextDecoration.underline),)),
                ],
              ),
            ],

          )
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width*0.5,
        height: MediaQuery.of(context).size.height*0.04,
        decoration: BoxDecoration(border: Border(bottom:BorderSide(color: appTheme.secondaryHeaderColor) )),
        child: Text(text,style: TextStyle(color: appTheme.secondaryHeaderColor,fontWeight:FontWeight.bold))
      ),
    );
  }
}

class _InputLogginUser extends StatelessWidget {
  final String text;
  const _InputLogginUser({
    required this.passwordTextController, required this.text, required this.userTextController,
  });
  
  final TextEditingController passwordTextController;
  final TextEditingController userTextController;


  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final appTheme = const AppTheme().getTheme();

    var focus = FocusNode();
    return TextFormField(
      focusNode: focus,
      onTapOutside: (event) {
        
      },
      onFieldSubmitted: (value) {
        bool isLogged = false;
        for(UserLocal user in userProvider.userList)
        {
          if(user.userName==userTextController.value.text.trim() && user.userPassword==passwordTextController.value.text.trim())
          {
            isLogged=true;
            Navigator.push(context, MaterialPageRoute(builder: (context) => PrincipalMenu(user: user)));
          }
        }
        if(!isLogged)
        {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => 
            AlertDialog(
              actions: [
                Column(
                  children: [
                    const Text("! CUIDADO !",style: TextStyle(color: Colors.red,fontSize: 30),),
                    const Text("Usuario o contraseña incorrectos",style:TextStyle(color: Colors.red)),
                    TextButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: const Text("Reintentar",style: TextStyle(decoration: TextDecoration.underline),)),
                  ],
                ),
              ],
            )
          );
        }
        
      },
      style: TextStyle(color: appTheme.secondaryHeaderColor,fontWeight: FontWeight.bold),
      controller: userTextController,
      decoration: InputDecoration(
        filled: true,
        fillColor:Colors.white.withOpacity(0.1),
        hintText: text,
        hintStyle: TextStyle(color: appTheme.secondaryHeaderColor,fontWeight: FontWeight.bold),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: appTheme.secondaryHeaderColor)
        ),
      ),
      
    );
  }
}

class _InputLogginPassword extends StatelessWidget {
  final String text;
  const _InputLogginPassword({
    required this.userTextController, required this.text, required this.passwordTextController,
  });


  final TextEditingController passwordTextController;
  final TextEditingController userTextController;

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final appTheme = const AppTheme().getTheme();
    var focus = FocusNode();
    return TextFormField(
      focusNode: focus,
      onTapOutside: (event) {
        
      },
      onFieldSubmitted: (value) {
        bool isLogged = false;
        for(UserLocal user in userProvider.userList)
        {
          if(user.userName==userTextController.value.text.trim() && user.userPassword==passwordTextController.value.text.trim())
          {
            isLogged=true;
            Navigator.push(context, MaterialPageRoute(builder: (context) => PrincipalMenu(user: user)));
          }
        }
        if(!isLogged)
        {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => 
            AlertDialog(
              actions: [
                Column(
                  children: [
                    const Text("! CUIDADO !",style: TextStyle(color: Colors.red,fontSize: 30),),
                    const Text("Usuario o contraseña incorrectos",style:TextStyle(color: Colors.red)),
                    TextButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: const Text("Reintentar",style: TextStyle(decoration: TextDecoration.underline),)),
                  ],
                ),
              ],
            )
          );
        }
      },
      style: TextStyle(color: appTheme.secondaryHeaderColor,fontWeight: FontWeight.bold),
      controller: passwordTextController,
      decoration: InputDecoration(
        filled: true,
        fillColor:Colors.white.withOpacity(0.1),
        suffixIcon: IconButton(onPressed: () {
          
        }, icon: Icon(Icons.remove_red_eye,color: appTheme.secondaryHeaderColor,)),
        hintText: text,
        hintStyle: TextStyle(color: appTheme.secondaryHeaderColor,fontWeight: FontWeight.bold),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: appTheme.secondaryHeaderColor)
        ),
      ),
      
    );
  }
}