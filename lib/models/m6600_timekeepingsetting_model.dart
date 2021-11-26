class M6600TimeKeepingSettingModel {                                           
  String id;
  String IdCompany;
  String IdEmployee;
  String IsMultiMobile;
  String IsLocationTracking;
  String IsNoNeedTimekeeping;
  String IsNoConstraintTimekeeping;
  String IsAllowingLatelyCheckinOut;
  String IsAllowingEarlyCheckinOut;
  String IsAutoTimekeeping;
  String IsAutoCheckout;
  String IsClockinUsingImage;
  String IsClockoutUsingImage;
  String IsHelpCheckShift;
                                                                 
																	
  M6600TimeKeepingSettingModel({this.id,this.IdCompany,this.IdEmployee,this.IsMultiMobile,this.IsLocationTracking,this.IsNoNeedTimekeeping,this.IsNoConstraintTimekeeping,this.IsAllowingLatelyCheckinOut,this.IsAllowingEarlyCheckinOut,this.IsAutoTimekeeping,this.IsAutoCheckout,this.IsClockinUsingImage,this.IsClockoutUsingImage,this.IsHelpCheckShift});                                         
																	
  M6600TimeKeepingSettingModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    IdEmployee = json['IdEmployee'];
    IsMultiMobile = json['IsMultiMobile'];
    IsLocationTracking = json['IsLocationTracking'];
    IsNoNeedTimekeeping = json['IsNoNeedTimekeeping'];
    IsNoConstraintTimekeeping = json['IsNoConstraintTimekeeping'];
    IsAllowingLatelyCheckinOut = json['IsAllowingLatelyCheckinOut'];
    IsAllowingEarlyCheckinOut = json['IsAllowingEarlyCheckinOut'];
    IsAutoTimekeeping = json['IsAutoTimekeeping'];
    IsAutoCheckout = json['IsAutoCheckout'];
    IsClockinUsingImage = json['IsClockinUsingImage'];
    IsClockoutUsingImage = json['IsClockoutUsingImage'];
    IsHelpCheckShift = json['IsHelpCheckShift'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['IdEmployee'] = this.IdEmployee;
    data['IsMultiMobile'] = this.IsMultiMobile;
    data['IsLocationTracking'] = this.IsLocationTracking;
    data['IsNoNeedTimekeeping'] = this.IsNoNeedTimekeeping;
    data['IsNoConstraintTimekeeping'] = this.IsNoConstraintTimekeeping;
    data['IsAllowingLatelyCheckinOut'] = this.IsAllowingLatelyCheckinOut;
    data['IsAllowingEarlyCheckinOut'] = this.IsAllowingEarlyCheckinOut;
    data['IsAutoTimekeeping'] = this.IsAutoTimekeeping;
    data['IsAutoCheckout'] = this.IsAutoCheckout;
    data['IsClockinUsingImage'] = this.IsClockinUsingImage;
    data['IsClockoutUsingImage'] = this.IsClockoutUsingImage;
    data['IsHelpCheckShift'] = this.IsHelpCheckShift;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
