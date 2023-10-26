import 'package:flutter/material.dart';
import 'package:iseneca/models/user.dart';
import 'package:iseneca/theme/app_theme.dart';
class PrincipalMenu extends StatelessWidget {
  final User user;
  const PrincipalMenu({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final appTheme = const AppTheme().getTheme();

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
                child: SizedBox(
                  width: screenSize.width*0.95,
                  height: screenSize.height*0.22,
                  child: 
                  Card(
                    child: 
                    Column(
                        children: [
                          
                          ListTile(
                            trailing: const Icon(Icons.people),
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
                ),
              ),
            ]
          ),

          SizedBox(
            height: screenSize.height*0.05,
          ),

          Align(
            alignment: Alignment.center,
            child: 
            Container(
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
                          Container(
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
                          Container(
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
                          Container(
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
                          Container(
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
                          Container(
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
          )
          
        ],
      ),
    );
  }
}