
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


ArsProgressDialog arProgress(context) {
  return ArsProgressDialog(context,
      blur: 7,
      backgroundColor: Color(0x33000000),
      useSafeArea: true,
      loadingWidget: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white, 
            boxShadow: [
                BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)
              ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            
            children: [
             
              SpinKitFadingCube(
                color: Theme.of(context).accentColor,
                size: 25.0,
              ),
              Text('Un instant...')
             
             
              
              
             
              
              
            ],
          )));
}

ArsProgressDialog arProgress2(context) {
  return ArsProgressDialog(context,
      blur: 7,
      backgroundColor: Color(0x33000000),
      useSafeArea: true,
      loadingWidget: AlertDialog(
        actions: [InkWell(
                  onTap: (){
                  Navigator.pop(context);
                },child: Text("Fermer"),),],
      contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                title: Row(
                  children: <Widget>[
                  //  Image.asset('assets/loader.gif'),
                    SizedBox(width: 10),
                    Text(
                      'Soumission réussie',
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ),
                content: Text("Notre équipe l'étuduera et nous vous contacterons sous peu.\nMerci !"),
    )
          );
}


