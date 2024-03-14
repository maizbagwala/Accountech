class DebitNoteListModel {
  List<Data>? data;
  String? message;
  bool? success;
  int? status;

  DebitNoteListModel({this.data, this.message, this.success, this.status});

  DebitNoteListModel.fromJson(Map<String, dynamic> json) {
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
  int? partyName;
  int? debitNoteNo;
  String? dueIn;
  int? amount;

  Data({this.id, this.partyName, this.debitNoteNo, this.dueIn, this.amount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    partyName = json['party_name'];
    debitNoteNo = json['debit_note_no'];
    dueIn = json['due_in'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['party_name'] = partyName;
    data['debit_note_no'] = debitNoteNo;
    data['due_in'] = dueIn;
    data['amount'] = amount;
    return data;
  }
}
