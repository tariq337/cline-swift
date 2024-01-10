class FirstOrderModel {
  double? cash;
  String? description;
  String? name;
  String? phoneNumber;
  String? point;

  FirstOrderModel(
      {this.cash, this.description, this.name, this.phoneNumber, this.point});

  FirstOrderModel.fromJson(Map<String, dynamic> json) {
    cash = json['cash'];
    description = json['description'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    point = json['point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cash'] = cash;
    data['description'] = description;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['point'] = point;
    return data;
  }
}
