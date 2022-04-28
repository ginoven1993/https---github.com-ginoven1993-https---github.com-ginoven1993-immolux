import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:immolux_imobilier/Modeles/modelappart.dart';

import '../Modeles/modelimmeuble.dart';
import 'createImmeuble.dart';
import 'vueimmeuble.dart';
class OptionAppart extends StatefulWidget {

  @override
  _OptionAppartState createState() => _OptionAppartState();
}

class _OptionAppartState extends State<OptionAppart> {
  int state=0;

  TextEditingController searchController=new TextEditingController();
  
  String searchWord='';
 
  String removeDiacritics(String str) {

  var withDia = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
  var withoutDia = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz'; 
  

  for (int i = 0; i < withDia.length; i++) {      
    str = str.replaceAll(withDia[i], withoutDia[i]);
  }
 
return str;

}
  

 
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
   
   body:  Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
               Container(
              height: 59.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 0.0, bottom: 15)),
                  Expanded(
                      child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.symmetric(horizontal: 3)),
                      InkWell(
                          onTap: () {
                            setState(() {
                              state = 0;
                            });
                            print(state);
                          },
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4.0, left: 6.0),
                                child: Container(
                                    height: 29.5,
                                    decoration: BoxDecoration(
                                      color: state == 0
                                          ? Colors.blue[800]
                                          : Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 4.5,
                                          spreadRadius: 1.0,
                                        )
                                      ],
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Center(
                                        child: Text(
                                          "Tous",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: state == 0
                                                  ? Colors.white
                                                  : Colors.blue[800],
                                              fontFamily: "Sans"),
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          )),
                      InkWell(
                          onTap: () {
                            setState(() {
                              state = 1;
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4.0, left: 6.0),
                                child: Container(
                                    height: 29.5,
                                    decoration: BoxDecoration(
                                      color: state == 1
                                          ? Colors.blue[800]
                                          : Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 4.5,
                                          spreadRadius: 1.0,
                                        )
                                      ],
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Center(
                                        child: Text(
                                          "Location",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: state == 1
                                                  ? Colors.white
                                                  : Colors.blue[800],
                                              fontFamily: "Sans"),
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          )),
                      InkWell(
                          onTap: () {
                            setState(() {
                              state = 2;
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4.0, left: 6.0),
                                child: Container(
                                    height: 29.5,
                                    decoration: BoxDecoration(
                                      color: state == 2
                                          ? Colors.blue[800]
                                          : Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 4.5,
                                          spreadRadius: 1.0,
                                        )
                                      ],
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Center(
                                        child: Text(
                                          "Ventes",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: state == 2
                                                  ? Colors.white
                                                  : Colors.blue[800],
                                              fontFamily: "Sans"),
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          )),
                      InkWell(
                          onTap: () {
                            setState(() {
                              state = 3;
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4.0, left: 6.0),
                                child: Container(
                                  height: 29.5,
                                  width: 90.0,
                                  decoration: BoxDecoration(
                                    color: state == 3
                                        ? Colors.blue[800]
                                        : Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4.5,
                                        spreadRadius: 1.0,
                                      )
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Bail",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: state == 3
                                              ? Colors.white
                                              : Colors.blue[800],
                                          fontFamily: "Sans"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      InkWell(
                          onTap: () {
                            setState(() {
                              state = 4;
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4.0, left: 6.0),
                                child: Container(
                                  height: 29.5,
                                  width: 90.0,
                                  decoration: BoxDecoration(
                                    color: state == 4
                                        ? Colors.blue[800]
                                        : Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4.5,
                                        spreadRadius: 1.0,
                                      )
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Admin",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: state == 4
                                              ? Colors.white
                                              : Colors.blue[800],
                                          fontFamily: "Sans"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                     ],
                  ))
                ],
              ),
            ),
            
                         Padding(
    padding: const EdgeInsets.only(top: 5.0, right: 20.0, left: 20.0,bottom:15),
    child: Container(
      height: 50.0,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10.0,
                spreadRadius: 0.0)
          ]),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 10.0),
          child: TextFormField(
              onChanged:(value){
              setState(() {
                  searchWord=value;
              });
            },
              controller: searchController,
              decoration: InputDecoration(
                border: InputBorder.none,
                  icon: Icon(
                    Icons.search,
                    color: Color(0xFF6991C7),
                    size: 28.0,
                  ),
                  hintText: "Rechercher un produit",
                  hintStyle: TextStyle(
                      color: Colors.black54,
                      fontFamily: "Gotik",
                      fontWeight: FontWeight.w400)),
            ),
          
        ),
      ),
    ),
  ),
              
              StreamBuilder(
    stream: 
    
     FirebaseFirestore.instance.collection('Immeuble')
     
    
    .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
      if(!snapshot.hasData){
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      if(snapshot.data.docs.length==0){
        return Padding(padding:EdgeInsets.only(top:0),child:Center(
          child: Text('aucun-element'.toString()),
        ));
      }
       List user=state==1?  snapshot.data.docs.where((element) =>
        element.get('type_service')=='En Vente' ).toList():
        state==2?  snapshot.data.docs.where((element) =>
        element.get('type_service')=='Location' ).toList():
        state==3?  snapshot.data.docs.where((element) =>
        element.get('type_service')=='Baill' ).toList():
      
        snapshot.data.docs.where((element) =>
        element.get('type_service')=='' ).toList();

      List prodc=user.where((element) =>
       removeDiacritics(element.get('nom_proprio').toString()).toUpperCase().contains(removeDiacritics(searchWord.toString()).toUpperCase())||
        removeDiacritics(element.get('num_proprio').toString()).toUpperCase().contains(removeDiacritics(searchWord.toString()).toUpperCase())
               ).toList(); 
      return     Stack(
       children: [
         Container(
           height: MediaQuery.of(context).size.height-223,
           child:ListView(
        primary: false,
        shrinkWrap: true,
        children: prodc.map((doc) {
          return Column(
                    children: [

                       Slidable(
  actionPane: SlidableDrawerActionPane(),
  actionExtentRatio: 0.25,
  child: Padding(
                        padding: const EdgeInsets.only(
                            right: 10,
                            bottom: 20 * 0.75,top:20 * 0.75),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: 35,
                                  child: CircleAvatar(
                                    radius: 34,
                                    backgroundColor: Colors.white,
                                    backgroundImage: CachedNetworkImageProvider(doc['image'][0]),  
                                    
                                  ),
                                )
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      doc['nom_proprio']/* +' '+doc['prenom'] */,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(height: 8),
                                    Opacity(
                                      opacity: 0.64,
                                      child: Text(
                                        'télephone'.toString()+doc['num_proprio'].toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    
                                  ],
                                ),
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
                                                  .doc(doc['id'])
                                                  .delete();
                                              Navigator.pop(context);
                                            },
                                          ))
                                    },
                                  )
                                ],  

   secondaryActions: <Widget>[
    IconSlideAction(
      caption: 'Voir',
      color: Colors.black45,
      icon: Icons.read_more,
      onTap: () => {   Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ViewImmeuble(
                                            imeub: ModelImmeuble(
                                              id: doc['id'],
                                              description: doc['description'],
                                              typeservice: doc['type_service'],
                                              categorie:
                                                  doc['categorie'],
                                              type: doc['type'],
                                             nbr_chambre:
                                                  doc['nbr_chambre'],
                                              nom_proprio: doc['nom_proprio'],
                                              num_proprio: doc['num_proprio'],
                                              pri: doc['prix'],
                                             locI: doc['localisation'],
                                              image: doc['image'],
                                              com: doc['commission'],
                                              comdemarch: doc['com_demarche'],
                                              document: doc['document']
                                            ),
                                          );
                        })) },
    ),
   ], 
),
      ],
                  );
        }).toList(),
      )),Positioned(
        top: MediaQuery.of(context).size.height-400,
        child: CircleAvatar(
          backgroundColor: Colors.blue,
          radius: 27,
          child:  Text(prodc.length.toString(),style: TextStyle(fontSize: 20),),
        ))]) ;
        
    }
  )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return CreateImmeuble();
                                  },
                                ),
                              );

      },
      backgroundColor: Colors.blue,
      child: Icon(
                Icons.add,
                color: Colors.white,
              ),),
      );
      
      }
      
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

 }