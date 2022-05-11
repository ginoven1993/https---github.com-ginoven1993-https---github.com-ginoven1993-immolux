import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:intl/intl.dart';
import '../Function/arprogress.dart';
import '../Function/ramdomfunction.dart';



class StoreSuscription extends StatefulWidget {
  

  @override
  _StoreSuscriptionState createState() => _StoreSuscriptionState();
}

class _StoreSuscriptionState extends State<StoreSuscription> {
  List<File> listFiles = [];
   @override
  void initState()  {
    Firebase.initializeApp().whenComplete(() { 
      
      setState(() {});
    });/* 
    _nameCtrl.text= userInfo['nom'];
    _numCtrl.text=userInfo['phone']; */
   super.initState();  
  }
  final _formKey = GlobalKey<FormState>();
  final _formKeys = GlobalKey<FormState>();
  String serv='1';
  String cat='1';
  String productId = '';
  String productImageLink = '';
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _numCtrl = TextEditingController();
 
  final TextEditingController _coutCtrl = TextEditingController();
  final TextEditingController _addeCtrl = TextEditingController();
 
  final TextEditingController _ldescCtrl = TextEditingController();
  final TextEditingController _storeCountry = TextEditingController(); 
  @override
  Widget build(BuildContext context) {
    _storeCountry.text="(+228) TOGO";
    InputDecoration getInputDecoration({String hintText, String labelText}) {
    return new InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: Theme.of(context).textTheme.bodyText2.merge(
            TextStyle(color: Theme.of(context).focusColor),
          ),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).hintColor.withOpacity(0.2))),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).hintColor)),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      labelStyle: Theme.of(context).textTheme.bodyText2.merge(
            TextStyle(color: Theme.of(context).hintColor),
          ),
    );
  }
  List<Asset> images = List<Asset>();
  List<String> imageUrls = <String>[];
  String _error = 'No Error Dectected';
  File _image;
  final picker = ImagePicker();

  Future getImageGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    print('Dick1');
    setState(() {
      if (pickedFile != null) {
        print('Dick1pro');
        listFiles.insert(listFiles.length, File(pickedFile.path));
        print('Dick1promax'+ listFiles[0].toString());
        /* _image = File(pickedFile.path); */
      } else {
        print('No image selected.');
      }
    });
  }
  Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      primary: false,
      crossAxisCount: 2,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      childAspectRatio: 2/2.6,
      
      children: List.generate(listFiles.length, (index) {
        File asset = listFiles[index];
        return Container(
          
          child:Column(
          children: [
             Container(
               height: 172,
          width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
            image: FileImage(asset),
            fit: BoxFit.cover,
          ),
          borderRadius: index==0? BorderRadius.only(
             topLeft: Radius.circular(25)
            ):index==1? BorderRadius.only(
             topRight: Radius.circular(25)
            ):BorderRadius.only(
             bottomRight: Radius.circular(0)
            ),
          color: Colors.red,
          border: Border(
              left: BorderSide(
                  color: Colors.green,
                  width: 3,
              ),
            ),
          ),
                    ),
             SizedBox(height:5),
             InkWell(
               onTap: () {
                      setState(() {
                        listFiles.remove(listFiles[index]);
                      });
                    },
               child: Container(
               height: 38,
              width: MediaQuery.of(context).size.width,
              color:Colors.red,
              child: Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children:[
                  Image.asset('assets/images/delete.png',color:Colors.white,height:30),
                  Text('Supprimer',style: TextStyle(/* fontFamily: GoogleFonts.poppins().fontFamily */color:Colors.white,fontWeight: FontWeight.bold,fontSize:18,),)
                ]
              ),
             ) ,
             )   
           ],
        )
        );
      }),
    );
  }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        leading: new IconButton(
          icon: new Icon(Icons.close, color: Colors.purple),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text("Que vendez vous?",
          style:Theme.of(context).textTheme.titleLarge.copyWith(color:Colors.purple),),
        ),
        ),
    
      body: Padding(padding:EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child:  Stack(
            children: [
              
              Column(
            children: [

              Container(
               // height: 300,
                width: MediaQuery.of(context).size.width-10,
                color: Colors.white,
                child: Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Column(
                  children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                        Text('Plus d\'infos sur votre bien',
          style: TextStyle(
            color:Colors.purple[800].withOpacity(0.9),
            fontWeight: FontWeight.bold,
            fontSize: 16
          ),)
                    ],
                  )
                    ,SizedBox(height: 10,),
                    Container(color: Colors.white,
                    height: 45,
                width: MediaQuery.of(context).size.width-5,
                      child: Padding(padding: EdgeInsets.symmetric(horizontal:0,vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              serv='Vente';
                            });
                          },
                          child:    Container(
      height: 40,
     width: MediaQuery.of(context).size.width/2.5,
      decoration:serv=='Vente'? BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple[800].withOpacity(0.9),
              Colors.purple[800].withOpacity(0.9),
             // color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
           border: Border.all(color:Colors.purple[800].withOpacity(0.9)),
          borderRadius: BorderRadius.circular(5),
        ): BoxDecoration(
          gradient: LinearGradient(
            colors: [
             Colors.white,
           Colors.white,
             // color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
           border: Border.all(color:Colors.purple[800].withOpacity(0.9)),
          borderRadius: BorderRadius.circular(5),
        ),
    
    child:Padding(padding: EdgeInsets.symmetric(horizontal: 5),
    child:  Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
 

          Text('Vente',
          style: TextStyle(
            color: serv=='Vente'? Colors.white:Colors.purple[800].withOpacity(0.9),
            fontWeight: FontWeight.normal,
            fontSize: 16
          ),)
        ],
      ),),)
    ,
                        ),  
                       InkWell(
                          onTap: (){
                            setState(() {
                              serv='Location';
                            });
                          },
                          child:    Container(
      height: 40,
     width: MediaQuery.of(context).size.width/2.5,
      decoration:serv=='Location'? BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple[800].withOpacity(0.9),
              Colors.purple[800].withOpacity(0.9),
             // color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
           border: Border.all(color:Colors.purple[800].withOpacity(0.9)),
          borderRadius: BorderRadius.circular(5),
        ): BoxDecoration(
          gradient: LinearGradient(
            colors: [
             Colors.white,
           Colors.white,
             // color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
           border: Border.all(color:Colors.purple[800].withOpacity(0.9)),
          borderRadius: BorderRadius.circular(5),
        ),
    
    child:Padding(padding: EdgeInsets.symmetric(horizontal: 5),
    child:  Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
 

          Text('Location',
          style: TextStyle(
            color: serv=='Location'? Colors.white:Colors.purple[800].withOpacity(0.9),
            fontWeight: FontWeight.normal,
            fontSize: 16
          ),)
        ],
      ),),)
    ,
                        ),
                    

                        ],
                      ),),
                    )
                  
                  ,SizedBox(height: 30,)
                  ,
                   Container(color: Colors.white,
                    height: 100,
                width: MediaQuery.of(context).size.width-5,
                      child: Padding(padding: EdgeInsets.symmetric(horizontal:0,vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              cat='Appartement';
                            });
                          },
                          child:    Container(
      height: 90,
     width: MediaQuery.of(context).size.width/3.5,
      decoration:cat=='Appartement'? BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple[800].withOpacity(0.5),
              Colors.purple[800].withOpacity(0.5),
             // color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
           border: Border.all(color:Colors.purple[800].withOpacity(0.9)),
          borderRadius: BorderRadius.circular(5),
        ): BoxDecoration(
          gradient: LinearGradient(
            colors: [
             Colors.white,
           Colors.white,
             // color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
           border: Border.all(color:Colors.purple[800].withOpacity(0.9)),
          borderRadius: BorderRadius.circular(5),
        ),
    
    child:Padding(padding: EdgeInsets.symmetric(horizontal: 5),
    child:  Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
  Image.asset(
                      "assets/icons/apartment.png",
                      color: cat=='Appartement'? Colors.white:Colors.purple[800].withOpacity(0.9),
                      height: 25.2,
                    ),

          Text('Appartement',
          style: TextStyle(
            color: cat=='Appartement'? Colors.white:Colors.purple[800].withOpacity(0.9),
            fontWeight: FontWeight.normal,
            fontSize: 16
          ),)
        ],
      ),),)
    ,
                        ),  
                       InkWell(
                          onTap: (){
                            setState(() {
                              cat='Terrain';
                            });
                          },
                          child:    Container(
      height: 90,
     width: MediaQuery.of(context).size.width/3.5,
      decoration:cat=='Terrain'? BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple[800].withOpacity(0.5),
              Colors.purple[800].withOpacity(0.5),
             // color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
           border: Border.all(color:Colors.purple[800].withOpacity(0.9)),
          borderRadius: BorderRadius.circular(5),
        ): BoxDecoration(
          gradient: LinearGradient(
            colors: [
             Colors.white,
           Colors.white,
             // color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
           border: Border.all(color:Colors.purple[800].withOpacity(0.9)),
          borderRadius: BorderRadius.circular(5),
        ),
    
    child:Padding(padding: EdgeInsets.symmetric(horizontal: 5),
    child:  Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
 Image.asset(
                      "assets/icons/tiles.png",
                      color: cat=='Terrain'? Colors.white:Colors.purple[800].withOpacity(0.9),
                      height: 25.2,
                    ),

          Text('Terrain',
          style: TextStyle(
            color: cat=='Terrain'? Colors.white:Colors.purple[800].withOpacity(0.9),
            fontWeight: FontWeight.normal,
            fontSize: 16
          ),)
        ],
      ),),)
    ,
                        ),  
                        InkWell(
                          onTap: (){
                            setState(() {
                              cat='Immeuble';
                            });
                          },
                          child:    Container(
      height: 90,
     width: MediaQuery.of(context).size.width/3.5,
      decoration:cat=='Immeuble'? BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple[800].withOpacity(0.5),
              Colors.purple[800].withOpacity(0.5),
             // color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
           border: Border.all(color:Colors.purple[800].withOpacity(0.9)),
          borderRadius: BorderRadius.circular(5),
        ): BoxDecoration(
          gradient: LinearGradient(
            colors: [
             Colors.white,
           Colors.white,
             // color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
           border: Border.all(color:Colors.purple[800].withOpacity(0.9)),
          borderRadius: BorderRadius.circular(5),
        ),
    
    child:Padding(padding: EdgeInsets.symmetric(horizontal: 5),
    child:  Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
 Image.asset(
                      "assets/icons/3d-buildings.png",
                      color: cat=='Immeuble'? Colors.white:Colors.purple[800].withOpacity(0.9),
                      height: 25.2,
                    ),

          Text('Immeuble',
          style: TextStyle(
            color: cat=='Immeuble'? Colors.white:Colors.purple[800].withOpacity(0.9),
            fontWeight: FontWeight.normal,
            fontSize: 16
          ),)
        ],
      ),),)
    ,
                        ),  
                        
    

                        ],
                      ),),
                    )
                   ,SizedBox(height: 5,)
                  ,
                   Container(color: Colors.white,
                    height: 100,
                width: MediaQuery.of(context).size.width-5,
                      child: Padding(padding: EdgeInsets.symmetric(horizontal:0,vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              cat='Villa';
                            });
                          },
                          child:    Container(
      height: 90,
     width: MediaQuery.of(context).size.width/3.5,
      decoration:cat=='Villa'? BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple[800].withOpacity(0.5),
              Colors.purple[800].withOpacity(0.5),
             // color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
           border: Border.all(color:Colors.purple[800].withOpacity(0.9)),
          borderRadius: BorderRadius.circular(5),
        ): BoxDecoration(
          gradient: LinearGradient(
            colors: [
             Colors.white,
           Colors.white,
             // color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
           border: Border.all(color:Colors.purple[800].withOpacity(0.9)),
          borderRadius: BorderRadius.circular(5),
        ),
    
    child:Padding(padding: EdgeInsets.symmetric(horizontal: 5),
    child:  Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
  Image.asset(
                      "assets/icons/apartment.png",
                      color: cat=='Villa'? Colors.white:Colors.purple[800].withOpacity(0.9),
                      height: 25.2,
                    ),

          Text('Villa',
          style: TextStyle(
            color: cat=='Villa'? Colors.white:Colors.purple[800].withOpacity(0.9),
            fontWeight: FontWeight.normal,
            fontSize: 16
          ),)
        ],
      ),),)
    ,
                        ),    
                        InkWell(
                          onTap: (){
                            setState(() {
                              cat='Terrain Agricole';
                            });
                          },
                          child:    Container(
      height: 90,
     width: MediaQuery.of(context).size.width/3.5,
      decoration:cat=='Terrain Agricole'? BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple[800].withOpacity(0.5),
              Colors.purple[800].withOpacity(0.5),
             // color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
           border: Border.all(color:Colors.purple[800].withOpacity(0.9)),
          borderRadius: BorderRadius.circular(5),
        ): BoxDecoration(
          gradient: LinearGradient(
            colors: [
             Colors.white,
           Colors.white,
             // color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
           border: Border.all(color:Colors.purple[800].withOpacity(0.9)),
          borderRadius: BorderRadius.circular(5),
        ),
    
    child:Padding(padding: EdgeInsets.symmetric(horizontal: 5),
    child:  Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
 Image.asset(
                      "assets/icons/tractor.png",
                      color: cat=='Terrain Agricole'? Colors.white:Colors.purple[800].withOpacity(0.9),
                      height: 25.2,
                    ),

          Text('Terrain Agricole',
          style: TextStyle(
            color: cat=='Terrain Agricole'? Colors.white:Colors.purple[800].withOpacity(0.9),
            fontWeight: FontWeight.normal,
           // fontSize: 16
          ),)
        ],
      ),),)
    ,
                        ),  
                        InkWell(
                          onTap: (){
                            setState(() {
                              cat='Boutique';
                            });
                          },
                          child:    Container(
      height: 90,
     width: MediaQuery.of(context).size.width/3.5,
      decoration:cat=='Boutique'? BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple[800].withOpacity(0.5),
              Colors.purple[800].withOpacity(0.5),
             // color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
           border: Border.all(color:Colors.purple[800].withOpacity(0.9)),
          borderRadius: BorderRadius.circular(5),
        ): BoxDecoration(
          gradient: LinearGradient(
            colors: [
             Colors.white,
           Colors.white,
             // color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
           border: Border.all(color:Colors.purple[800].withOpacity(0.9)),
          borderRadius: BorderRadius.circular(5),
        ),
    
    child:Padding(padding: EdgeInsets.symmetric(horizontal: 5),
    child:  Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
 Image.asset(
                      "assets/icons/store.png",
                      color: cat=='Boutique'? Colors.white:Colors.purple[800].withOpacity(0.9),
                      height: 25.2,
                    ),

          Text('Boutique',
          style: TextStyle(
            color: cat=='Boutique'? Colors.white:Colors.purple[800].withOpacity(0.9),
            fontWeight: FontWeight.normal,
            fontSize: 16
          ),)
        ],
      ),),)
    ,
                        ),  
                        
    

                        ],
                      ),),
                    )
                   ,SizedBox(height: 5,)
                  ,
                  serv=='Location'? Container(color: Colors.white,
                    height: 100,
                width: MediaQuery.of(context).size.width-5,
                      child: Padding(padding: EdgeInsets.symmetric(horizontal:0,vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              cat='Appart Meuble';
                            });
                          },
                          child:    Container(
      height: 90,
     width: MediaQuery.of(context).size.width/3.5,
      decoration:cat=='Appart Meuble'? BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple[800].withOpacity(0.5),
              Colors.purple[800].withOpacity(0.5),
             // color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
           border: Border.all(color:Colors.purple[800].withOpacity(0.9)),
          borderRadius: BorderRadius.circular(5),
        ): BoxDecoration(
          gradient: LinearGradient(
            colors: [
             Colors.white,
           Colors.white,
             // color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
           border: Border.all(color:Colors.purple[800].withOpacity(0.9)),
          borderRadius: BorderRadius.circular(5),
        ),
    
    child:Padding(padding: EdgeInsets.symmetric(horizontal: 5),
    child:  Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
  Image.asset(
                      "assets/icons/decorating.png",
                      color: cat=='Appart Meuble'? Colors.white:Colors.purple[800].withOpacity(0.9),
                      height: 25.2,
                    ),

          Text('Appart Meuble',
          style: TextStyle(
            color: cat=='Appart Meuble'? Colors.white:Colors.purple[800].withOpacity(0.9),
            fontWeight: FontWeight.normal,
            //fontSize: 
          ),)
        ],
      ),),)
    ,
                        ),  
                       InkWell(
                          onTap: (){
                            setState(() {
                              cat='Chambre';
                            });
                          },
                          child:    Container(
      height: 90,
     width: MediaQuery.of(context).size.width/3.5,
      decoration:cat=='Chambre'? BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple[800].withOpacity(0.5),
              Colors.purple[800].withOpacity(0.5),
             // color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
           border: Border.all(color:Colors.purple[800].withOpacity(0.9)),
          borderRadius: BorderRadius.circular(5),
        ): BoxDecoration(
          gradient: LinearGradient(
            colors: [
             Colors.white,
           Colors.white,
             // color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
           border: Border.all(color:Colors.purple[800].withOpacity(0.9)),
          borderRadius: BorderRadius.circular(5),
        ),
    
    child:Padding(padding: EdgeInsets.symmetric(horizontal: 5),
    child:  Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
 Image.asset(
                      "assets/icons/house-for-sale.png",
                      color: cat=='Chambre'? Colors.white:Colors.purple[800].withOpacity(0.9),
                      height: 25.2,
                    ),

          Text('Chambre',
          style: TextStyle(
            color: cat=='Chambre'? Colors.white:Colors.purple[800].withOpacity(0.9),
            fontWeight: FontWeight.normal,
            fontSize: 16
          ),)
        ],
      ),),)
    ,
                        ),       
                       InkWell(
                          onTap: (){
                            setState(() {
                              cat='Bureaux';
                            });
                          },
                          child:    Container(
      height: 90,
     width: MediaQuery.of(context).size.width/3.5,
      decoration:cat=='Bureaux'? BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple[800].withOpacity(0.5),
              Colors.purple[800].withOpacity(0.5),
             // color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
           border: Border.all(color:Colors.purple[800].withOpacity(0.9)),
          borderRadius: BorderRadius.circular(5),
        ): BoxDecoration(
          gradient: LinearGradient(
            colors: [
             Colors.white,
           Colors.white,
             // color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
           border: Border.all(color:Colors.purple[800].withOpacity(0.9)),
          borderRadius: BorderRadius.circular(5),
        ),
    
    child:Padding(padding: EdgeInsets.symmetric(horizontal: 5),
    child:  Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
 Image.asset(
                      "assets/icons/real-estate.png",
                      color: cat=='Bureaux'? Colors.white:Colors.purple[800].withOpacity(0.9),
                      height: 25.2,
                    ),

          Text('Bureaux',
          style: TextStyle(
            color: cat=='Bureaux'? Colors.white:Colors.purple[800].withOpacity(0.9),
            fontWeight: FontWeight.normal,
            fontSize: 16
          ),)
        ],
      ),),)
    ,
                        ),  
                   
    

                        ],
                      ),),
                    )
                   
                  :SizedBox(height: 0,) , SizedBox(height: 10,),
                   Text('Selectionnez le type de bien',
          style: TextStyle(
            color:Colors.purple[800].withOpacity(0.9),
            fontWeight: FontWeight.normal,
            fontSize: 16
          ),)],
                ),)
              ),

                Container(height: 5,
                            color: Colors.grey.withOpacity(0.1),            ),
SizedBox(height: 20),
                            Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                        Text('Details sur votre bien',
          style: TextStyle(
            color:Colors.purple[800].withOpacity(0.9),
            fontWeight: FontWeight.bold,
            fontSize: 16
          ),)
                    ],
                  ),
SizedBox(height: 
5),

  _buildTextField(
                keyboardType: TextInputType.text,
                labelText: 'Titre de l\'annonce',
                validator: (value) {
                  if (value.isEmpty) {
                    return 'adresse boutique requise';
                  }
                  return null;
                },
                controller: _addeCtrl,
              ),

                 _buildTextField(
                keyboardType: TextInputType.text,
                labelText: 'Coût du bien ( Valeur en F cfa)',
                hintText:'Coût',
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Coût du bien requis';
                  }
                  return null;
                },
                controller: _coutCtrl,
              ),
              


          
             Container(
                          margin:EdgeInsets.only(left:0,right:0,top:10,bottom:20),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              boxShadow: [
                BoxShadow(color: Colors.purple.withOpacity(0.10), offset: Offset(0, -4), blurRadius: 10)
              ],
            ),
            child: TextFormField(
              maxLength:8000,
               controller: _ldescCtrl, 
              maxLines: 5,
              enableSuggestions: true,
              
                
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 0,vertical:20),
                hintText: 'Description explicite et détaillée du bien',
                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.8)),
                
                border: UnderlineInputBorder(borderSide: BorderSide.none),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
  Container(height: 5,
                            color: Colors.grey.withOpacity(0.1),            ),
SizedBox(height: 20),
                            Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                        Text('Vos infos personelles',
          style: TextStyle(
            color:Colors.purple[800].withOpacity(0.9),
            fontWeight: FontWeight.bold,
            fontSize: 16
          ),)
                    ],
                  ),
SizedBox(height: 
5),


            _buildTextField(
                  keyboardType: TextInputType.text,
                labelText: 'Nom Propriétaire',
                hintText:'Nom complet',
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Nom propriétaire requis';
                  }
                  return null;
                },
                controller: _nameCtrl,
              ),
              

              _buildTextField(
                labelText: 'Numéro de Téléphone ( avec indicatif pays )',
                hintText:'Téléphone',
                keyboardType: TextInputType.number ,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Numéro requis';
                  }
                  return null;
                },
                controller: _numCtrl,
              ),
              Container(height: 5,
                            color: Colors.grey.withOpacity(0.1),            ),
SizedBox(height: 10),
                            Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                        Text('Les images du bien',
          style: TextStyle(
            color:Colors.purple[800].withOpacity(0.9),
            fontWeight: FontWeight.bold,
            fontSize: 16
          ),)
                    ],
                  ),
SizedBox(height: 
20),
             Positioned(bottom:MediaQuery.of(context).size.width/5 ,left:(MediaQuery.of(context).size.width/6-15),
          height: MediaQuery.of(context).size.width/8,
          width: MediaQuery.of(context).size.width/1.5,
            
            child: InkWell(
 onTap: () {
                 setState(() {
                           print('dicks');
                          getImageGallery();
                        }); 
                   },

              child: Container(
      height: 45,
     
      decoration: BoxDecoration(
         /*  gradient: LinearGradient(
            colors: [
              Colors.purple[800].withOpacity(0.4),
              Colors.purple[800].withOpacity(0.4),
             // color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ), */
          borderRadius: BorderRadius.circular(10),
            border: Border.all(color:Colors.purple[800].withOpacity(0.9)),
        ),
    
    child:Padding(padding: EdgeInsets.symmetric(horizontal: 0),
    child:  Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           ImageIcon(
	
    AssetImage('assets/images/upload.png'),
    color:Colors.purple[800].withOpacity(0.6),
	
    size: 30,
	
  ),
  SizedBox(width: 10,),

          Text('Ajouter les images',
          style: TextStyle(
            color:Colors.purple[800].withOpacity(0.6),
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),)
        ],
      ),),)
    ,
            )
    
    )
         ,SizedBox(height: 20,)
         , buildGridView(),
              
              ],
          ),
        
            ],
          )
        ),
      )
        ,
      )
      
     ,
      bottomNavigationBar:Padding(padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10)
      ,
      child:  InkWell(
 onTap: () 
                async{
        
        arProgress(context).show();
        List<String> ImageLinkList = <String>[];
          for (int i = 0; i < listFiles.length ; i++) {
                            /* String fileName = basename(listFiles[i].path); */
                            productId = CreateCryptoRandomString();
                            Reference firebaseStorageRef = FirebaseStorage
                                .instance
                                .ref()
                                .child('Uploads/Publication/$productId.jpg');
                            UploadTask uploadTask =
                                firebaseStorageRef.putFile(listFiles[i]);
                            TaskSnapshot taskSnapshot =
                                await uploadTask.whenComplete(() => {});

                            productImageLink =
                                await taskSnapshot.ref.getDownloadURL();
                            taskSnapshot.ref.getDownloadURL().then(
                                  (value) {},
                                );
                            ImageLinkList.add(productImageLink);
                          }
        
        var doc=FirebaseFirestore.instance.collection('Immeuble').doc();
      await  doc.set({
          'id':doc.id,
          'nom_proprio':_nameCtrl.text,
          'num_proprio':_numCtrl.text,
          'type_service':serv,
          'categorie':cat,
          'prix':_coutCtrl.text,
          'image':ImageLinkList,
          'titre': _addeCtrl.text,
          //'bref_desc': _bdescCtrl.text,
          'description':_ldescCtrl.text,
          'id_proprio':'',
          'user_name':'',
          'etat':'En attente',
          'date':DateFormat('yyyy-MM-dd').format(DateTime.now()),
          'com_demarche':'',
          'commission':'',
          'localisation':'',
          'disponible':false,
          'promo':false,
          'latitude':'',
          'longitude':'',
          'nbr':100,
          'nbr_douche':0,
          'nbr_chambre':0,
          'short_desc':'',
          
          'create_date':FieldValue.serverTimestamp()

        });
        Navigator.pop(context);
        Navigator.pop(context);
            arProgress2(context).show();

    
     
                   },

              child: Container(
      height: 45,
     
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple[800].withOpacity(0.9),
              Colors.purple[800].withOpacity(0.9),
             // color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
    
    child:Padding(padding: EdgeInsets.symmetric(horizontal: 0),
    child:  Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           ImageIcon(
	
    AssetImage('assets/images/upload.png'),
    color:Colors.white,
	
    size: 30,
	
  ),
  SizedBox(width: 10,),

          Text('Publiez gratuitement',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),)
        ],
      ),),)
    ,
            )
    ,)
         ,
    );
  }

  Widget _buildTextField({
    String labelText,String hintText,
    TextInputType keyboardType,
    FormFieldValidator<String> validator,
    TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
      hintText: hintText,
      labelText: labelText,
      
      hintStyle: Theme.of(context).textTheme.bodyText2.merge(
            TextStyle(color: Theme.of(context).focusColor),
          ),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).hintColor.withOpacity(0.2))),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).hintColor)),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      labelStyle: Theme.of(context).textTheme.bodyText2.merge(
            TextStyle(color: Theme.of(context).hintColor),
          ),
    ),
        validator: validator,
        controller: controller,
      ),
    );
  }

  
}