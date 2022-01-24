import 'package:flutter/material.dart';

class ModelAppart {
  final String id,
      description,
      latitude,
      longitude,
      typeappart,
      typeservice,
      categ,
      nbrecham,
      nom_proprio,
      num_proprio,
      locA,
      pri;

  List<dynamic> image;

  ModelAppart({
    this.id,
    this.description,
    this.latitude,
    this.longitude,
    this.typeservice,
    this.categ,
    this.typeappart,
    this.nbrecham,
    this.nom_proprio,
    this.num_proprio,
    this.pri,
    this.locA,
    this.image,
  });
}
