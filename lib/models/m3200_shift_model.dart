import 'm2500_timekeeping_model.dart';

class M3200ShiftModel {
  String id;
  String IdCompany;
  String Name;
  String Coefficient;
  String StartHour;
  String StartMinute;
  String EndHour;
  String EndMinute;
  String RestStartHour;
  String RestStartMinute;
  String RestEndHour;
  String RestEndMinute;
  String CheckinStartHour;
  String CheckinStartMinute;
  String CheckinEndHour;
  String CheckinEndMinute;
  String CheckoutStartHour;
  String CheckoutStartMinute;
  String CheckoutEndHour;
  String CheckoutEndMinute;
  String IsOvertimeShift;

  String currentTypeAction = '';

  bool canTakeActionWithShiftNow = false;
  bool shiftInTimeRangeNow = false;

  bool canCheckinAction = false;
  bool canWillCheckinAction = false;

  int checkinCountDown = 0;
  int checkinWillCountDown = 0;

  bool canCheckoutAction = false;
  bool canWillCheckoutAction = false;

  int checkoutCountDown = 0;
  int checkoutWillCountDown = 0;

  bool hasCheckin = false;
  bool hasCheckout = false;

  M2500TimekeepingModel timeKeeping;

  List<TimelineCheckin> timelineCheckin;

  M3200ShiftModel({this.id,this.IdCompany,this.Name,this.Coefficient,this.StartHour,this.StartMinute,this.EndHour,this.EndMinute,this.RestStartHour,this.RestStartMinute,this.RestEndHour,this.RestEndMinute,this.CheckinStartHour,this.CheckinStartMinute,this.CheckinEndHour,this.CheckinEndMinute,this.CheckoutStartHour,this.CheckoutStartMinute,this.CheckoutEndHour,this.CheckoutEndMinute,this.IsOvertimeShift});                                         
																	
  M3200ShiftModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    Name = json['Name'];
    Coefficient = json['Coefficient'];
    StartHour = json['StartHour'];
    StartMinute = json['StartMinute'];
    EndHour = json['EndHour'];
    EndMinute = json['EndMinute'];
    RestStartHour = json['RestStartHour'];
    RestStartMinute = json['RestStartMinute'];
    RestEndHour = json['RestEndHour'];
    RestEndMinute = json['RestEndMinute'];
    CheckinStartHour = json['CheckinStartHour'];
    CheckinStartMinute = json['CheckinStartMinute'];
    CheckinEndHour = json['CheckinEndHour'];
    CheckinEndMinute = json['CheckinEndMinute'];
    CheckoutStartHour = json['CheckoutStartHour'];
    CheckoutStartMinute = json['CheckoutStartMinute'];
    CheckoutEndHour = json['CheckoutEndHour'];
    CheckoutEndMinute = json['CheckoutEndMinute'];
    IsOvertimeShift = json['IsOvertimeShift'];
    // print('json timeKeeping  ${json['timeKeeping']}');
    if(json['timeKeeping'] != null) {
      timeKeeping = M2500TimekeepingModel.fromJson(json['timeKeeping']);
    }
  }
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['Name'] = this.Name;
    data['Coefficient'] = this.Coefficient;
    data['StartHour'] = this.StartHour;
    data['StartMinute'] = this.StartMinute;
    data['EndHour'] = this.EndHour;
    data['EndMinute'] = this.EndMinute;
    data['RestStartHour'] = this.RestStartHour;
    data['RestStartMinute'] = this.RestStartMinute;
    data['RestEndHour'] = this.RestEndHour;
    data['RestEndMinute'] = this.RestEndMinute;
    data['CheckinStartHour'] = this.CheckinStartHour;
    data['CheckinStartMinute'] = this.CheckinStartMinute;
    data['CheckinEndHour'] = this.CheckinEndHour;
    data['CheckinEndMinute'] = this.CheckinEndMinute;
    data['CheckoutStartHour'] = this.CheckoutStartHour;
    data['CheckoutStartMinute'] = this.CheckoutStartMinute;
    data['CheckoutEndHour'] = this.CheckoutEndHour;
    data['CheckoutEndMinute'] = this.CheckoutEndMinute;
    data['IsOvertimeShift'] = this.IsOvertimeShift;                                                                 
    return data;                                                    
  }                                                                 
}


class TimelineCheckin {
  int id;
  bool done;
  String action;
  DateTime datetime;
  TimelineCheckin({this.id,this.done,this.action,this.datetime});
}