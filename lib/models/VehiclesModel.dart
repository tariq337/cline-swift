class VehiclesModel {
  String? id;
  List<Vehicles>? vehicles;

  VehiclesModel({this.id, this.vehicles});

  VehiclesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['vehicles'] != null) {
      vehicles = <Vehicles>[];
      json['vehicles'].forEach((v) {
        vehicles!.add(Vehicles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (vehicles != null) {
      data['vehicles'] = vehicles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vehicles {
  String? area;
  String? id;
  String? imageUrl;
  String? name;
  double? price;
  int? speed;
  int? weight;

  Vehicles(
      {this.area,
      this.id,
      this.imageUrl,
      this.name,
      this.price,
      this.speed,
      this.weight});

  Vehicles.fromJson(Map<String, dynamic> json) {
    area = json['area'];
    id = json['id'];
    imageUrl = json['imageUrl'];
    name = json['name'];
    price = json['price'];
    speed = json['speed'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['area'] = area;
    data['id'] = id;
    data['imageUrl'] = imageUrl;
    data['name'] = name;
    data['price'] = price;
    data['speed'] = speed;
    data['weight'] = weight;
    return data;
  }
}
