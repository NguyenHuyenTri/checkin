class M2900CheckinLateAndCheckoutSoonSetupModel {                                           
  String id;
  String IdCompany;
  String IdShift;
  String LatelyCheckin;
  String MaxLateCheckinMinute;
  String EarlyCheckout;
  String MinSoonCheckinMinute;
                                                                 
																	
  M2900CheckinLateAndCheckoutSoonSetupModel({this.id,this.IdCompany,this.IdShift,this.LatelyCheckin,this.MaxLateCheckinMinute,this.EarlyCheckout,this.MinSoonCheckinMinute});                                         
																	
  M2900CheckinLateAndCheckoutSoonSetupModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    IdShift = json['IdShift'];
    LatelyCheckin = json['LatelyCheckin'];
    MaxLateCheckinMinute = json['MaxLateCheckinMinute'];
    EarlyCheckout = json['EarlyCheckout'];
    MinSoonCheckinMinute = json['MinSoonCheckinMinute'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['IdShift'] = this.IdShift;
    data['LatelyCheckin'] = this.LatelyCheckin;
    data['MaxLateCheckinMinute'] = this.MaxLateCheckinMinute;
    data['EarlyCheckout'] = this.EarlyCheckout;
    data['MinSoonCheckinMinute'] = this.MinSoonCheckinMinute;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
