class M1400TypeLeaveModel {
  String id;
  String Name;
  String Type;

  M1400TypeLeaveModel({this.id, this.Name, this.Type});

  M1400TypeLeaveModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    Name = json['Name'];
    Type = json['Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Name'] = this.Name;
    data['Type'] = this.Type;
    return data;
  }
}
