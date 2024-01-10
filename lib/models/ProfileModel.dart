class ProfileModel {
  String? cardCvv;
  int? cardExDateMonth;
  int? cardExDateYear;
  String? cardName;
  String? cardNumber;
  String? email;
  String? imageUrl;
  String? location;
  String? name;
  String? phoneNumber;

  ProfileModel(
      {this.cardCvv,
      this.cardExDateMonth,
      this.cardExDateYear,
      this.cardName,
      this.cardNumber,
      this.email,
      this.imageUrl,
      this.location,
      this.name,
      this.phoneNumber});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    cardCvv = json['cardCvv'];
    cardExDateMonth = json['cardExDateMonth'];
    cardExDateYear = json['cardExDateYear'];
    cardName = json['cardName'];
    cardNumber = json['cardNumber'];
    email = json['email'];
    imageUrl = json['imageUrl'];
    location = json['location'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cardCvv'] = cardCvv;
    data['cardExDateMonth'] = cardExDateMonth;
    data['cardExDateYear'] = cardExDateYear;
    data['cardName'] = cardName;
    data['cardNumber'] = cardNumber;
    data['email'] = email;
    data['imageUrl'] = imageUrl;
    data['location'] = location;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}

class CardsModel {
  String? cardCvv;
  int? cardExDateMonth;
  int? cardExDateYear;
  String? cardName;
  String? cardNumber;

  CardsModel({
    this.cardCvv,
    this.cardExDateMonth,
    this.cardExDateYear,
    this.cardName,
    this.cardNumber,
  });

  CardsModel.fromJson(Map<String, dynamic> json) {
    cardCvv = json['cardCvv'];
    cardExDateMonth = json['cardExDateMonth'];
    cardExDateYear = json['cardExDateYear'];
    cardName = json['cardName'];
    cardNumber = json['cardNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cardCvv'] = cardCvv;
    data['cardExDateMonth'] = cardExDateMonth;
    data['cardExDateYear'] = cardExDateYear;
    data['cardName'] = cardName;
    data['cardNumber'] = cardNumber;
    return data;
  }
}
