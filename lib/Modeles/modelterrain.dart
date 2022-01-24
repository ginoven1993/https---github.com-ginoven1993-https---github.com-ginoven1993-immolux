import 'package:flutter/material.dart';

class ModelTerrain {
  final String id,
      description,
      latitude,
      longitude,
      typeterrain,
      typeservice,
      nom_proprio,
      locT,
      pri,
      numPT;

  List<dynamic> image;

  ModelTerrain({
    this.id,
    this.description,
    this.latitude,
      this.longitude,
    this.typeterrain,
    this.typeservice,
    this.nom_proprio,
    this.pri,
    this.locT,
    this.numPT,
    this.image,
  });
}
