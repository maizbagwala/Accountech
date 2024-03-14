class ItemSeriesResponse {
  List<Data>? data;
  String? message;
  bool? success;
  int? status;

  ItemSeriesResponse({this.data, this.message, this.success, this.status});

  ItemSeriesResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['success'] = success;
    data['status'] = status;
    return data;
  }
}

class Data {
  int? id;
  String? seriesName;

  Data({this.id, this.seriesName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    seriesName = json['series_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['series_name'] = seriesName;
    return data;
  }
}
