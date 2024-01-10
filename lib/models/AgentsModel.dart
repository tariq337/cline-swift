class AgentModel {
  List<Details>? details;
  bool? hasNext;
  bool? hasPrev;
  int? page;
  int? pages;

  AgentModel({this.details, this.hasNext, this.hasPrev, this.page, this.pages});

  AgentModel.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    data['hasNext'] = hasNext;
    data['hasPrev'] = hasPrev;
    data['page'] = page;
    data['pages'] = pages;
    return data;
  }
}

class Details {
  String? email;
  String? id;
  String? imageUrl;
  String? name;
  String? phoneNumber;
  int? timeResponce;

  Details(
      {this.email,
      this.id,
      this.imageUrl,
      this.name,
      this.phoneNumber,
      this.timeResponce});

  Details.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['id'];
    imageUrl = json['imageUrl'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    timeResponce = json['timeResponce'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['id'] = id;
    data['imageUrl'] = imageUrl;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['timeResponce'] = timeResponce;
    return data;
  }
}
