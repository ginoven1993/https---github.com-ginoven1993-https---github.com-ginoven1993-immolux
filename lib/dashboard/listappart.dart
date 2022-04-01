import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class OptionAppart extends StatefulWidget {

  @override
  _OptionAppartState createState() => _OptionAppartState();
}

class _OptionAppartState extends State<OptionAppart> {
  final Stream<QuerySnapshot> _appartStream = FirebaseFirestore.instance
  .collection('Immeuble')
  .where('categorie', isEqualTo: 'Appartement')
  .snapshots();

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 5.1,
        title: const Text(
          'Liste des Appartements',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: "Poppins"),
        ),
        centerTitle: true,
      ),
   
   body: StreamBuilder<QuerySnapshot>(
      stream: _appartStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                child: Container(
                   color: Colors.grey.shade200.withOpacity(0.5),
                   child: Slidable(
                      actionExtentRatio: 0.25,
                     actionPane: SlidableDrawerActionPane(),
                      child: Padding(
                        padding: const EdgeInsets.only(
                                      right: 10,
                                      bottom: 10 * 0.75,
                                      top: 10 * 0.75),
                            child: Row(
                              children: [
                                    Stack(
                                      children: [
                                        Container(
                                            height: 80,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                        image: AssetImage('assets/images/appart.png'),
                                                        fit: BoxFit.cover)
                                                ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data['nom_proprio'],
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(height: 8),
                                              Opacity(
                                                opacity: 0.64,
                                                child: Text(
                                                  data["type_service"],
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Opacity(
                                                opacity: 0.64,
                                                child: Text(
                                                  data['num_proprio'],
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  ),
                                  Center(
                                        child: Text(
                                          data['localisation'],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                    ),
                               ],
                            ),          
                         ),               
                     ),
                ),     
            );
          }).toList(),
        );
      },
     ),
    );
  }
  }
