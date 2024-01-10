class CompanyModel {
  String image;
  String name;
  double deliveryPrice;
  double receivedAmount;

  CompanyModel(
      {required this.name,
      required this.deliveryPrice,
      required this.image,
      required this.receivedAmount});
}

List<CompanyModel> ListCompanys = [
  CompanyModel(
      name: "كريم",
      deliveryPrice: 1230,
      image: "assets/image/Careem.png",
      receivedAmount: 23000),
  CompanyModel(
      name: "هنقرستيشن",
      deliveryPrice: 900,
      image: "assets/image/Hungerstation.png",
      receivedAmount: 13000),
  CompanyModel(
      name: "زوماتو",
      deliveryPrice: 1130,
      image: "assets/image/Zomato.png",
      receivedAmount: 22040)
];
