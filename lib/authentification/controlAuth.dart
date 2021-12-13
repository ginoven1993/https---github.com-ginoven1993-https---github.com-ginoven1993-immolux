import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:immolux_imobilier/gesTerrain/accueil.dart';
import 'package:immolux_imobilier/authentification/registration.dart';
import 'package:provider/provider.dart';

class Utilisateur {
  String idUtil;

  Utilisateur({this.idUtil});
}

class DonneesUtil {
  String email;
  String nom;
  String prenom;
  String numero;
  String password;

  DonneesUtil({this.email, this.nom, this.numero, this.password, this.prenom});
}

class StreamProviderAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //creation d'un objet user provenant de la classe firebaseUser
  // ignore: unused_element
  Utilisateur _user(User user) {
    return user != null ? Utilisateur(idUtil: user.uid) : null;
  }

  //La diffusion de l'auth de l'utilisateur

  Stream<User> get user {
    return _auth.authStateChanges();
  }
}

class Passerelle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //Si l'utilisateur existe on le redirige sur la page accueil si non il doit s'authentifier

    if (user == null) {
      return Registration();
    } else {
      return Home();
    }
  }
}

class GetCurrentUserData {
  String idUtil;
  GetCurrentUserData({this.idUtil});

  //reference de la connexion utilisateur
  final CollectionReference collectionUtil =
      FirebaseFirestore.instance.collection('users');
  DonneesUtil _donneesUtilDeSnapshot(DocumentSnapshot snapshot) {
    return DonneesUtil(
      nom: snapshot['nom'],
      prenom: snapshot['prenom'],
      numero: snapshot['numero'],
      password: snapshot['password'],
      email: snapshot['emailUtil'],
    );
  }

  //obtention doc util en stream

  Stream<DonneesUtil> get donneesUtil {
    return collectionUtil.doc(idUtil).snapshots().map(_donneesUtilDeSnapshot);
  }
}
