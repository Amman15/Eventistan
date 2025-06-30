// To parse this JSON data, do
//
//     final ticket = ticketFromJson(jsonString);

import 'dart:convert';

import 'package:eventistan/models/event_model.dart';

List<Ticket> ticketFromJson(String str) =>
    List<Ticket>.from(json.decode(str).map((x) => Ticket.fromJson(x)));

String ticketToJson(List<Ticket> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ticket {
  final String id;
  final Event event;
  final String user;
  final String status;
  final int quantity;
  final DateTime purchaseDate;
  final String? paymentIntentId;
  final int v;

  Ticket({
    required this.id,
    required this.event,
    required this.user,
    required this.status,
    required this.quantity,
    required this.purchaseDate,
    this.paymentIntentId,
    required this.v,
  });

  Ticket copyWith({
    String? id,
    Event? event,
    String? user,
    String? status,
    int? quantity,
    DateTime? purchaseDate,
    String? paymentIntentId,
    int? v,
  }) =>
      Ticket(
        id: id ?? this.id,
        event: event ?? this.event,
        user: user ?? this.user,
        status: status ?? this.status,
        quantity: quantity ?? this.quantity,
        purchaseDate: purchaseDate ?? this.purchaseDate,
        paymentIntentId: paymentIntentId ?? this.paymentIntentId,
        v: v ?? this.v,
      );

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        id: json["_id"],
        event: Event.fromJson(json["event"]),
        user: json["user"],
        status: json["status"],
        quantity: json["quantity"],
        purchaseDate: DateTime.parse(json["purchaseDate"]),
        paymentIntentId: json["paymentIntentId"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "event": event.toJson(),
        "user": user,
        "status": status,
        "quantity": quantity,
        "purchaseDate": purchaseDate.toIso8601String(),
        "paymentIntentId": paymentIntentId,
        "__v": v,
      };
}
