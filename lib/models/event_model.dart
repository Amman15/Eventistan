// To parse this JSON data, do
//
//     final event = eventFromJson(jsonString);

import 'dart:convert';

List<Event> eventsFromJson(String str) =>
    List<Event>.from(json.decode(str).map((x) => Event.fromJson(x)));

String eventsToJson(List<Event> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Event eventFromJson(String str) => Event.fromJson(json.decode(str));

String eventToJson(Event data) => json.encode(data.toJson());

class Event {
  final String? id;
  final String? name;
  final String? venue;
  final DateTime? date;
  final String? description;
  final String? organizer;
  final String? eventLogo;
  final Coordinates? coordinates;
  final List<dynamic>? ratings;
  final String? eventType;
  final int? price;
  final int? v;
  final double? distance;
  final List<OrganizerDetail>? organizerDetails;

  Event({
    this.id,
    this.name,
    this.venue,
    this.date,
    this.description,
    this.organizer,
    this.eventLogo,
    this.coordinates,
    this.ratings,
    this.eventType,
    this.price,
    this.v,
    this.distance,
    this.organizerDetails,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["_id"],
        name: json["name"],
        venue: json["venue"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        description: json["description"],
        organizer: json["organizer"],
        eventLogo: json["eventLogo"],
        coordinates: json["coordinates"] == null
            ? null
            : (json["coordinates"]["type"] != null &&
                    json["coordinates"]["coordinates"] != null)
                ? Coordinates(
                    lat: json["coordinates"]["coordinates"][1],
                    lng: json["coordinates"]["coordinates"][0],
                  )
                : Coordinates.fromJson(json["coordinates"]),
        ratings: json["ratings"] == null
            ? []
            : List<dynamic>.from(json["ratings"]!.map((x) => x)),
        eventType: json["eventType"],
        price: json["price"],
        v: json["__v"],
        distance: json["distance"]?.toDouble(),
        organizerDetails: json["organizerDetails"] == null
            ? []
            : List<OrganizerDetail>.from(json["organizerDetails"]!
                .map((x) => OrganizerDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "venue": venue,
        "date": date?.toIso8601String(),
        "description": description,
        "organizer": organizer,
        "eventLogo": eventLogo,
        "coordinates": coordinates?.toJson(),
        "ratings":
            ratings == null ? [] : List<dynamic>.from(ratings!.map((x) => x)),
        "eventType": eventType,
        "price": price,
        "__v": v,
        "distance": distance,
        "organizerDetails": organizerDetails == null
            ? []
            : List<dynamic>.from(organizerDetails!.map((x) => x.toJson())),
      };
}

class Coordinates {
  final double? lat;
  final double? lng;
  final String? id;

  Coordinates({
    this.lat,
    this.lng,
    this.id,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
        "_id": id,
      };
}

class OrganizerDetail {
  final String? id;
  final String? email;
  final String? password;
  final String? role;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? profilePicture;
  final int? age;
  final String? bio;
  final String? name;
  final String? city;
  final String? phone;
  final String? teamName;
  final int? teamSize;

  OrganizerDetail({
    this.id,
    this.email,
    this.password,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.profilePicture,
    this.age,
    this.bio,
    this.name,
    this.city,
    this.phone,
    this.teamName,
    this.teamSize,
  });

  factory OrganizerDetail.fromJson(Map<String, dynamic> json) =>
      OrganizerDetail(
        id: json["_id"],
        email: json["email"],
        password: json["password"],
        role: json["role"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        profilePicture: json["profilePicture"],
        age: json["age"],
        bio: json["bio"],
        name: json["name"],
        city: json["city"],
        phone: json["phone"],
        teamName: json["teamName"],
        teamSize: json["teamSize"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "password": password,
        "role": role,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "profilePicture": profilePicture,
        "age": age,
        "bio": bio,
        "name": name,
        "city": city,
        "phone": phone,
        "teamName": teamName,
        "teamSize": teamSize,
      };
}
