class BillsModel {
  List<Details>? details;
  bool? hasNext;
  bool? hasPrev;
  int? page;
  int? pages;

  BillsModel({this.details, this.hasNext, this.hasPrev, this.page, this.pages});

  BillsModel.fromJson(Map<String, dynamic> json) {
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
  double? bloan;
  String? end;
  String? id;
  double? aloan;
  String? start;
  int? state;

  Details({this.bloan, this.end, this.id, this.aloan, this.start, this.state});

  Details.fromJson(Map<String, dynamic> json) {
    bloan = double.parse(json['bLoan'].toString());
    end = json['end'];
    id = json['id'];
    aloan = double.parse(json['aLoan'].toString());
    start = json['start'];
    state = json['state'];
  }
}
