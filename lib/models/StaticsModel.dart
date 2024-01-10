class StaticsModel {
  List<int>? s1;
  List<int>? s2;
  List<int>? s3;
  List<int>? s4;
  List<int>? s5;

  StaticsModel({this.s1, this.s2, this.s3, this.s4, this.s5});

  StaticsModel.fromJson(Map<String, dynamic> json) {
    s1 = json['s1'].cast<int>();
    s2 = json['s2'].cast<int>();
    s3 = json['s3'].cast<int>();
    s4 = json['s4'].cast<int>();
    s5 = json['s5'].cast<int>();
  }
}
