class M3100AdvancedTimekeepingSetupModel {                                           
  String id;
  String IdCompany;
  String IdShift;
  String StartCheckinHour;
  String StartCheckinMinute;
  String EndCheckinHour;
  String EndCheckinMinute;
  String StartCheckoutHour;
  String StartCheckoutMinute;
  String EndCheckoutHour;
  String EndCheckoutMinute;
  String MinimumWorkingHour;
                                                                 
																	
  M3100AdvancedTimekeepingSetupModel({this.id,this.IdCompany,this.IdShift,this.StartCheckinHour,this.StartCheckinMinute,this.EndCheckinHour,this.EndCheckinMinute,this.StartCheckoutHour,this.StartCheckoutMinute,this.EndCheckoutHour,this.EndCheckoutMinute,this.MinimumWorkingHour});                                         
																	
  M3100AdvancedTimekeepingSetupModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    IdShift = json['IdShift'];
    StartCheckinHour = json['StartCheckinHour'];
    StartCheckinMinute = json['StartCheckinMinute'];
    EndCheckinHour = json['EndCheckinHour'];
    EndCheckinMinute = json['EndCheckinMinute'];
    StartCheckoutHour = json['StartCheckoutHour'];
    StartCheckoutMinute = json['StartCheckoutMinute'];
    EndCheckoutHour = json['EndCheckoutHour'];
    EndCheckoutMinute = json['EndCheckoutMinute'];
    MinimumWorkingHour = json['MinimumWorkingHour'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['IdShift'] = this.IdShift;
    data['StartCheckinHour'] = this.StartCheckinHour;
    data['StartCheckinMinute'] = this.StartCheckinMinute;
    data['EndCheckinHour'] = this.EndCheckinHour;
    data['EndCheckinMinute'] = this.EndCheckinMinute;
    data['StartCheckoutHour'] = this.StartCheckoutHour;
    data['StartCheckoutMinute'] = this.StartCheckoutMinute;
    data['EndCheckoutHour'] = this.EndCheckoutHour;
    data['EndCheckoutMinute'] = this.EndCheckoutMinute;
    data['MinimumWorkingHour'] = this.MinimumWorkingHour;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
