import 'package:flutter/material.dart';

class ModelMagasin {
  final String id,
      description,
      latitude,
      longitude,
      typemagasin,
      typeservice,
      nom_proprio,
      num_proprio,
      locT,
      pri;
  List<dynamic> image;

  ModelMagasin({
    this.id,
    this.description,
    this.latitude,
    this.longitude,
    this.typemagasin,
    this.typeservice,
    this.nom_proprio,
    this.pri,
    this.locT,
    this.num_proprio,
    this.image,
  });
}
