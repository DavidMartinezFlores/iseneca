import 'package:flutter/material.dart';
import 'package:iseneca/theme/app_theme.dart';
class LogginScreen extends StatelessWidget {
  const LogginScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final appTheme = const AppTheme().getTheme();
    final screenSize = MediaQuery.of(context).size;

    final userTextController = TextEditingController();
    final passwordTextController = TextEditingController();

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
      
                  _InputLogginUser(userTextController: userTextController,text: 'Usuario'),
      
                  SizedBox(height: screenSize.height*0.04,),
      
                  _InputLogginPassword(userTextController: passwordTextController,text: 'Contraseña'),
      
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
                    
                    }, 
                    child: Text("Entrar",style: TextStyle(color: appTheme.primaryColor,fontWeight: FontWeight.bold),)
                  ),
      
                  SizedBox(height: screenSize.height*0.05,),
      
                  _UnderLineButton(text: 'No recuerdo mi contraseña'),
                  
                  SizedBox(height: screenSize.height*0.08,),
                  
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
}

class _UnderLineButton extends StatelessWidget {
  final ThemeData appTheme = const AppTheme().getTheme();
  final String text;
  _UnderLineButton({ required this.text});

  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
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
    required this.userTextController, required this.text,
  });

  final TextEditingController userTextController;

  @override
  Widget build(BuildContext context) {
    final appTheme = const AppTheme().getTheme();
    var focus = FocusNode();
    return TextFormField(
      focusNode: focus,
      onTapOutside: (event) {
        focus=FocusNode();
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
    required this.userTextController, required this.text,
  });

  final TextEditingController userTextController;

  @override
  Widget build(BuildContext context) {
    final appTheme = const AppTheme().getTheme();
    var focus = FocusNode();
    return TextFormField(
      focusNode: focus,
      onTapOutside: (event) {
        focus=FocusNode();
      },
      style: TextStyle(color: appTheme.secondaryHeaderColor,fontWeight: FontWeight.bold),
      controller: userTextController,
      decoration: InputDecoration(
        filled: true,
        fillColor:Colors.white.withOpacity(0.1),
        suffixIcon: Icon(Icons.remove_red_eye,color: appTheme.secondaryHeaderColor,),
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