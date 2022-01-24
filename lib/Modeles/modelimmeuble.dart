import 'package:flutter/material.dart';

class ModelImmeuble {
  final String id,
      description,
      latitude,
      longitude,
      typeimmeuble,
      typeservice,
      nom_proprio,
      num_proprio,
      pri,
      locI;

  List<dynamic> image;

  ModelImmeuble({
    this.id,
    this.description,
    this.latitude,
    this.longitude,
    this.typeimmeuble,
    this.typeservice,
    this.nom_proprio,
    this.num_proprio,
    this.pri,
    this.locI,
    this.image,
  });
}
