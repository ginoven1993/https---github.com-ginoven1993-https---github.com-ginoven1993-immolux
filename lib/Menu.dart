import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:immolux_imobilier/Modeles/modelappart.dart';
import 'package:immolux_imobilier/Modeles/modelimmeuble.dart';
import 'package:immolux_imobilier/Modeles/modelterrain.dart';
import 'package:immolux_imobilier/Modeles/modeluser.dart';
import 'package:immolux_imobilier/dashboard/listappart.dart';
import 'package:immolux_imobilier/dashboard/listimmeuble.dart';
import 'package:immolux_imobilier/dashboard/listterrain.dart';
import 'package:immolux_imobilier/menu_accueil/client.dart';
import 'package:immolux_imobilier/gesImmeuble/createImmeuble.dart';
import 'package:immolux_imobilier/gesImmeuble/listImmeuble.dart';
import 'package:immolux_imobilier/dashboard/listuser.dart';
import 'package:immolux_imobilier/slide.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}
class _MenuState extends State<Menu> {

  Widget _buildSingleContainer({String image,int count, String name, BuildContext context}) {
    return  Card(
      elevation: 4.5,
      clipBehavior: Clip.antiAlias,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(12),
       ),
                    child: Container(
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Container(
                               width: 50,
                               height: 65,
                               decoration: BoxDecoration(
                                 image: DecorationImage(
                                   image: AssetImage(image))
                               ),
                             ),
                             SizedBox(width: 10),
                             Text(name,
                           style: TextStyle(
                             fontSize: 20,
                             color: Colors.black,
                           fontWeight: FontWeight.bold),
                           ),
                          ],
                         ),
                         Text(
                           count.toString(),
                         style: TextStyle(
                           fontSize: 40,
                           color: Colors.black87,
                         fontWeight: FontWeight.bold),
                         ),
                        
                       ],
                     ),
                    ),
                  );
  }
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          unselectedLabelColor: Colors.black,
          tabs: [
            Tab(
              child: Text('Dashboard',
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
                fontFamily: "Poppins",
                ),
              ),
            ),

            Tab(
              child: Text('Menu',
              style: TextStyle(
                  fontSize: 17,
                color: Colors.white,
                fontFamily: "Poppins",
                ),
              ),
            ),

            Tab(
              child: Text('Statistiques',
              style: TextStyle(
                  fontSize: 16,
                color: Colors.white,
                fontFamily: "Poppins",
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blue[800],
        elevation: 4.1,
        title: const Text(
          'Home',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: "Poppins"),
        ),
        centerTitle: true,
      ), 
      body: Container(
        child: TabBarView(
          children: [
            //TabBar DashBoard
            Container(
               padding: EdgeInsets.symmetric(horizontal: 5,vertical: 95),
               child: GridView.count(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 2,
                children: [
                  InkWell(
                    onTap: () {Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => ListClient(),
                        ),
                     );
                    },
                    child: _buildSingleContainer(
                    context: context,
                    count: totalcount.length,
                    image: 'assets/images/profile.png',
                    name: "Users",
                    ),
                  ),
                  
                  InkWell(
                     onTap: () {Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => OptionTerrain(),
                        ),
                      );
                     },
                     child: _buildSingleContainer(
                      context: context,
                      count: totalterrain.length,
                     image: 'assets/images/maison.png',
                      name: "Terrains",
                       ),
                   ),
                  InkWell(
                     onTap: () {Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => OptionAppart(),
                        ),
                      );},
                     child: _buildSingleContainer(
                      context: context,
                      count: totalappart.length,
                      image: 'assets/images/appart.png',
                      name: "Apparts",
                                     ),
                   ),
                  InkWell(
                     onTap: () {Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => OptionImmeuble(),
                        ),
                      );},
                     child: _buildSingleContainer(
                      context: context,
                      count: totalimmeuble.length,
                     image: 'assets/images/immeuble.png', 
                      name: "Immeubles",
                                     ),
                   ),
                ],
              ),
            ),

            //TabBar Menu
             Container(
               padding: EdgeInsets.symmetric(horizontal: 20,vertical: 35),
               child: Column(
                children: [
                  InkWell(
                      onTap: () {
                          Navigator.push(context, 
                            MaterialPageRoute(builder: (context) => OptionClient(),
                          ),
                        );
                      },
                    child: Card( 
                      elevation: 1.5,
                            clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11),
                            ),
                        child: Stack(
                           alignment: Alignment.center,
                            children: [
                              Image(
                                  image: AssetImage('assets/images/clie.jpg'),
                                  fit: BoxFit.cover,),
                              Text('Clients',style: TextStyle(color: Colors.black,fontSize: 38,fontFamily: "Poppins",fontWeight: FontWeight.bold),),    
                            ],
                        ),
                      ),
                ),
                   SizedBox(height: 20),
                  InkWell(
                      onTap: () {
                          Navigator.push(context, 
                            MaterialPageRoute(builder: (context) => OptionClient(),
                          ),
                        );
                      },
                    child: Card( 
                      elevation: 4.5,
                            clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                        child: Stack(
                           alignment: Alignment.center,
                            children: [
                              Image(
                                  image: AssetImage('assets/images/prop.jpg'),
                                  fit: BoxFit.cover,),
                              Text('Propriétaires',style: TextStyle(color: Colors.black,fontSize: 28,fontFamily: "Poppins",fontWeight: FontWeight.bold),),    
                            ],
                        ),
                      ),
                ),
                SizedBox(height: 15,),  
                 InkWell(
                      onTap: () {
                          Navigator.push(context, 
                            MaterialPageRoute(builder: (context) => OptionClient(),
                          ),
                        );
                      },
                    child: Card(
                      elevation: 4.5,
                            clipBehavior: Clip.antiAlias, 
                      shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                        child: Stack(
                           alignment: Alignment.center,
                            children: [
                              Image(
                                  image: AssetImage('assets/images/agent.jpg'),
                                  fit: BoxFit.cover,),
                              Text('Démarcheurs',style: TextStyle(color: Colors.black,fontSize: 28,fontFamily: "Poppins",fontWeight: FontWeight.bold),),    
                            ],
                        ),
                      ),
                ),
                  ],
                ),
            ),

            //tabbar OptionClient
           Container(
              height: 350,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: Column(
                  children: [
                   Card(
                        elevation: 1.0,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                                InkWell(
                                        onTap: () {
                                            Navigator.push(context, 
                                              MaterialPageRoute(builder: (context) => Slide(),
                                            ),
                                          );
                                        },
                                        child: Text("New Slide",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 28,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold),
                                          ),
                                ),      
                             ],
                            ),
                          ],
                        ),
                      ),
                   ), 
                  ],
                ),
            ),
         ),
        ],
      ),
      ),
    ),  
    );
  }
}
