import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class ListClient extends StatefulWidget {

  @override
  _ListClientState createState() => _ListClientState();
}

class _ListClientState extends State<ListClient> {

 showAlert(BuildContext context, title, content, Widget deleteButton) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel".toString()),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [cancelButton, deleteButton],
            ));
  }

 

 final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 5.1,
        title: const Text(
          'Liste des Utilisateurs',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: "Poppins"),
        ),
        centerTitle: true,
      ),
   
   body: StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
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
                                            width: 120,
                                            decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                        image: AssetImage('assets/images/pro.jpg'),
                                                        fit: BoxFit.fill)
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
                                                data['nom'],
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(height: 8),
                                              Opacity(
                                                opacity: 0.64,
                                                child: Text(
                                                  data['prenom'],
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Opacity(
                                                opacity: 0.64,
                                                child: Text(
                                                  data['phone'],
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
                                          data['role'],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                    ),
                               ],
                            ),          
                         ), 
                         actions: <Widget>[
                                  IconSlideAction(
                                    caption: 'supprimer',
                                    color: Colors.red,
                                    icon: Icons.delete,
                                    onTap: () => {
                                      showAlert(
                                          context,
                                          'Avertissement',
                                          'Cet action de suppression est irréversible. Etes vous sûr de vouloir supprimer ce Utilisateur?',
                                          FlatButton(
                                            child: Text("Supprimer"),
                                            onPressed: () async {
                                              await FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(data['id'])
                                                  .delete();
                                              Navigator.pop(context);
                                            },
                                          ))
                                    },
                                  )
                                ],               
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
