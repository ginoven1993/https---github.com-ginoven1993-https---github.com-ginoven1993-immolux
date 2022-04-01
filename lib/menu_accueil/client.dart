import 'package:flutter/material.dart';
import 'package:immolux_imobilier/gesImmeuble/createImmeuble.dart';
import 'package:immolux_imobilier/gesImmeuble/listImmeuble.dart';
class OptionClient extends StatefulWidget {

  @override
  _OptionClientState createState() => _OptionClientState();
}

class _OptionClientState extends State<OptionClient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 5.1,
        title: const Text(
          'Immolux_Immobilier',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: "Poppins"),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
             Container(
               padding: EdgeInsets.symmetric(horizontal: 10,vertical: 190),
               child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                         context,
                            MaterialPageRoute(
                                builder: (context) {
                           return CreateImmeuble();
                              },
                            ),
                        );
                    },
                    child: Card(
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
                                                  Image(
                                                    image: AssetImage('assets/images/add.jpg'),
                                                    fit: BoxFit.cover,
                                                    width: 30),
                                                  SizedBox(width: 20,height: 60),
                                                  Text("Ajout Produit",
                                                       style: TextStyle(
                                                         fontSize: 22,
                                                         color: Colors.black,
                                                         fontFamily: "Poppins",
                                                         fontWeight: FontWeight.bold),
                                                   ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          ),
                                        ),
                  ),
                   InkWell(
                     onTap: () {
                              Navigator.pushReplacement(
                         context,
                            MaterialPageRoute(
                                builder: (context) {
                           return HomeImmeuble();
                              },
                            ),
                        );
                     },
                     child: Card(
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
                                                Image(
                                                    image: AssetImage('assets/images/list.png'),
                                                    fit: BoxFit.cover,
                                                    width: 30),
                                                SizedBox(width: 20,height: 60),
                                                Text("Voir Produit",
                                              style: TextStyle(
                                                fontSize: 22,
                                                color: Colors.black,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.bold),
                                              ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        ),
                                      ),
                   ),
                ],
                ),
            ),
          ],
          ),
      ),
      
    );
  }
}