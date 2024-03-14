class DeletePartyResponse {
  int? data;
  String? message;
  bool? success;
  int? status;

  DeletePartyResponse({this.data, this.message, this.success, this.status});

  DeletePartyResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    message = json['message'];
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    data['message'] = message;
    data['success'] = success;
    data['status'] = status;
    return data;
  }
}
