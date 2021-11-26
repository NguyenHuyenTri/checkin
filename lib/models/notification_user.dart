import 'package:flutter/foundation.dart';

class NotificationUserPage {
  int page;
  int per_page;

  NotificationUserPage({this.page, this.per_page});

  @override
  String toString() => 'Page { id: $page, limit: $per_page}';

  NotificationUserPage.empty() {
    this.page = 1;
    this.per_page = 20;
  }

  NotificationUserPage.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    per_page = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['per_page'] = this.per_page;
    return data;
  }

}


class NotificationUserRead {
  bool success;
  String msg;

  NotificationUserRead.empty() {
    success = false;
    msg = "Lỗi không xác định";
  }

  NotificationUserRead.fromJson(Map<String, dynamic> json) {
    success = json['success'] != null ? json['success'] : "";
    msg = json['msg'] != null ? json['msg'] : "";
  }
}


class NotificationGlobalCount with ChangeNotifier, DiagnosticableTreeMixin{

  int num_unread_notify;

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', num_unread_notify));
  }


  void changeNumber(numberCount){
    print("Call changeNumber");
    print(num_unread_notify);

    num_unread_notify = numberCount;
    print(num_unread_notify);
    notifyListeners();
  }


}

class NotificationUserList with ChangeNotifier, DiagnosticableTreeMixin{
  List<NotificationUser> data;
  NotificationUserPage page;
  int num_unread;


  NotificationUserList({this.data, this.num_unread});

  NotificationUserList.empty() {
    this.num_unread = 0;
    data = [];
    page = NotificationUserPage.empty();
  }

  NotificationUserList.fromJson(Map<String, dynamic> json) {
    num_unread = json['num_unread'] != null ? json['num_unread'].toInt() : 0;
    if (json != null && json['data'] != null && json['data'].length > 0) {
      data = new List<NotificationUser>();
      json['data'].forEach((v) {
        data.add(new NotificationUser.fromJson(v));
      });
    } else {
      data = [];
    }
    // page = Page.fromJson(json['page']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

class NotificationUser {

  String id;
  String content;
  String image;
  String notify_type;
  String content_id;
  bool is_read;
  String machine_id;
  DateTime created_at;

  NotificationUser({
    this.id,
    this.is_read,
    this.content,
    this.notify_type,
    this.content_id,
    this.image,
    this.created_at
  });

  NotificationUser.empty() {
    this.id = "";
    this.content = "";
    this.image = "";
    this.notify_type = "";
    this.content_id = "";
    is_read = false;
    this.created_at = new DateTime.now();
  }

  NotificationUser.fromJson(Map<String, dynamic> json) {
    id = json['_id'] != null ? json['_id'] : "";
    content = json['content'] != null ? json['content'] : "";
    is_read = json['is_read'] != null ? json['is_read'] == 1 ? true : false : false;
    content_id = json['content_id'] != null ? json['content_id'] : "";
    image = json['image'] != null ? json['image'] : "";
    notify_type = json['notify_type'] != null ? json['notify_type'] : "";
    machine_id = json['machine_id'] != null ? json['machine_id'] : "";
    created_at = json['created_at'] == null ? null : DateTime.parse(json['created_at'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['content'] = this.content;
    data['image'] = this.image;
    data['notify_type'] = this.notify_type;
    data['machine_id'] = this.machine_id;
    data['created_at'] = this.created_at;
    return data;
  }
}