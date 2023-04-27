// To parse this JSON data, do
//
//     final intitlemodel = intitlemodelFromJson(jsonString);

import 'dart:convert';

import 'package:sqflite/sqflite.dart';

Intitlemodel intitlemodelFromJson(String str) => Intitlemodel.fromJson(json.decode(str));

String intitlemodelToJson(Intitlemodel data) => json.encode(data.toJson());

class Intitlemodel {
  final int? totalItems;
  final List<Item>? items;

  Intitlemodel({
    this.totalItems,
    this.items,
  });

  factory Intitlemodel.fromJson(Map<String, dynamic> json) => Intitlemodel(
    totalItems: json["totalItems"],
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalItems": totalItems,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Item {
  final String? kind;
  final String? id;
  final String? selfLink;
  final VolumeInfo? volumeInfo;

  Item({
    this.kind,
    this.id,
    this.selfLink,
    this.volumeInfo,
  });

  Item.fromMap(Map<String, dynamic> result)
      : kind = result["kind"],
        id = result["id"],
        selfLink = result["selfLink"],
        volumeInfo = VolumeInfo.fromJson( result["volumeInfo"]);

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    kind: json["kind"],
    id: json["id"],
    selfLink: json["selfLink"],
    volumeInfo: json["volumeInfo"] == null ? null : VolumeInfo.fromJson(json["volumeInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "kind": kind,
    "id": id,
    "selfLink": selfLink,
    "volumeInfo": volumeInfo?.toJson(),
  };

  Map<String, dynamic> toMap() {
    return {
      'kind': kind,
      'id': id,
      'selfLink': selfLink,
      'volumeInfo': volumeInfo?.toJson()
    };
  }
}

class VolumeInfo {
  final String? title;
  final List<String>? authors;
  final String? publisher;
  final String? publishedDate;
  final String? description;
  final int? pageCount;
  final String? printType;
  final List<String>? categories;
  final double? averageRating;
  final int? ratingsCount;
  final String? maturityRating;
  final bool? allowAnonLogging;
  final String? contentVersion;
  final ImageLinks? imageLinks;
  final String? language;
  final String? previewLink;
  final String? infoLink;
  final String? canonicalVolumeLink;

  VolumeInfo({
    this.title,
    this.authors,
    this.publisher,
    this.publishedDate,
    this.description,
    this.pageCount,
    this.printType,
    this.categories,
    this.averageRating,
    this.ratingsCount,
    this.maturityRating,
    this.allowAnonLogging,
    this.contentVersion,
    this.imageLinks,
    this.language,
    this.previewLink,
    this.infoLink,
    this.canonicalVolumeLink,
  });

  factory VolumeInfo.fromJson(Map<String, dynamic> json) => VolumeInfo(
    title: json["title"],
    authors: json["authors"] == null ? [] : List<String>.from(json["authors"]!.map((x) => x)),
    publisher: json["publisher"],
    publishedDate: json["publishedDate"],
    description: json["description"],
    pageCount: json["pageCount"],
    printType: json["printType"],
    categories: json["categories"] == null ? [] : List<String>.from(json["categories"]!.map((x) => x)),
    averageRating: json["averageRating"]?.toDouble(),
    ratingsCount: json["ratingsCount"],
    maturityRating: json["maturityRating"],
    allowAnonLogging: json["allowAnonLogging"],
    contentVersion: json["contentVersion"],
    imageLinks: json["imageLinks"] == null ? null : ImageLinks.fromJson(json["imageLinks"]),
    language: json["language"],
    previewLink: json["previewLink"],
    infoLink: json["infoLink"],
    canonicalVolumeLink: json["canonicalVolumeLink"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "authors": authors == null ? [] : List<dynamic>.from(authors!.map((x) => x)),
    "publisher": publisher,
    "publishedDate": publishedDate,
    "description": description,
    "pageCount": pageCount,
    "printType": printType,
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x)),
    "averageRating": averageRating,
    "ratingsCount": ratingsCount,
    "maturityRating": maturityRating,
    "allowAnonLogging": allowAnonLogging,
    "contentVersion": contentVersion,
    "imageLinks": imageLinks?.toJson(),
    "language": language,
    "previewLink": previewLink,
    "infoLink": infoLink,
    "canonicalVolumeLink": canonicalVolumeLink,
  };
}

class ImageLinks {
  final String? smallThumbnail;
  final String? thumbnail;

  ImageLinks({
    this.smallThumbnail,
    this.thumbnail,
  });

  factory ImageLinks.fromJson(Map<String, dynamic> json) => ImageLinks(
    smallThumbnail: json["smallThumbnail"],
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "smallThumbnail": smallThumbnail,
    "thumbnail": thumbnail,
  };
}

