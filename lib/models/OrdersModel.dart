class OrdersModel {
  List<Details>? details;
  bool? hasNext;
  bool? hasPrev;
  int? page;
  int? pages;

  OrdersModel(
      {this.details, this.hasNext, this.hasPrev, this.page, this.pages});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
    hasNext = json['hasNext'];
    hasPrev = json['hasPrev'];
    page = json['page'];
    pages = json['pages'];
  }
}

class Details {
  String? aTime;
  Agent? agent;
  String? cash;
  String? number;
  Delivery? delivery;
  String? fee;
  String? id;
  List<Points>? points;

  Details(
      {this.aTime,
      this.agent,
      this.cash,
      this.delivery,
      this.fee,
      this.id,
      this.points});

  Details.fromJson(Map<String, dynamic> json) {
    aTime = json['aTime'].toString();
    agent = json['agent'] != null ? Agent.fromJson(json['agent']) : null;
    cash = json['cash'].toString();
    number = json['number'].toString();
    delivery =
        json['delivery'] != null ? Delivery.fromJson(json['delivery']) : null;
    fee = json['fee'].toString();
    id = json['id'];
    if (json['points'] != null) {
      points = <Points>[];
      json['points'].forEach((v) {
        points!.add(Points.fromJson(v));
      });
    }
  }
}

class Agent {
  String? email;
  String? id;
  String? imageUrl;
  String? name;
  String? phoneNumber;

  Agent({this.email, this.id, this.imageUrl, this.name, this.phoneNumber});

  Agent.fromJson(Map<String, dynamic> json) {
    email = json['email'] ?? "";
    id = json['id'] ?? "";
    imageUrl = json['imageUrl'] ?? "";
    name = json['name'] ?? "";
    phoneNumber = json['phoneNumber'] ?? "";
  }
}

class Delivery {
  String? email;
  String? id;
  String? imageUrl;
  String? location;
  String? name;
  String? phoneNumber;

  Delivery(
      {this.email,
      this.id,
      this.imageUrl,
      this.location,
      this.name,
      this.phoneNumber});

  Delivery.fromJson(Map<String, dynamic> json) {
    email = json['email'] ?? "";
    id = json['id'] ?? "";
    imageUrl = json['profileImageUrl'] ?? "";
    location = json['location'] ?? "";
    name = json['name'] ?? "";
    phoneNumber = json['phoneNumber'] ?? "";
  }
}

class Points {
  String? cash;
  String? description;
  String? id;
  String? name;
  String? phoneNumber;
  String? point;
  States? state;
  List<States>? status;

  Points(
      {this.cash,
      this.description,
      this.id,
      this.name,
      this.phoneNumber,
      this.point,
      this.state,
      this.status});

  Points.fromJson(Map<String, dynamic> json) {
    cash = json['cash'].toString();
    description = json['description'] ?? "";
    id = json['id'] ?? "";
    name = json['name'] ?? "";
    phoneNumber = json['phoneNumber'] ?? "";
    point = json['point'] ?? "";
    state = json['state'] != null ? States.fromJson(json['state']) : null;
    if (json['status'] != null) {
      status = <States>[];
      json['status'].forEach((v) {
        status!.add(States.fromJson(v));
      });
    }
  }
}

class States {
  int? id;
  String? timestamp;

  States({this.id, this.timestamp});

  States.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timestamp = json['timestamp'];
  }
}
