class CreatePartyResponse {
  Data? data;
  String? message;
  bool? success;
  int? status;

  CreatePartyResponse({this.data, this.message, this.success, this.status});

  CreatePartyResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['success'] = success;
    data['status'] = status;
    return data;
  }
}

class Data {
  int? partyId;

  Data({this.partyId});

  Data.fromJson(Map<String, dynamic> json) {
    partyId = json['party_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['party_id'] = partyId;
    return data;
  }
}
