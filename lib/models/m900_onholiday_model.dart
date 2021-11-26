class M900OnHolidayModel {                                           
  String id;
  String IdCompany;
  String IdShift;
  String Title;
  String OnHolidayStart;
  String OnHolidayEnd;
  String WorkingWageCoeficient;
                                                                 
																	
  M900OnHolidayModel({this.id,this.IdCompany,this.IdShift,this.Title,this.OnHolidayStart,this.OnHolidayEnd,this.WorkingWageCoeficient});                                         
																	
  M900OnHolidayModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    IdShift = json['IdShift'];
    Title = json['Title'];
    OnHolidayStart = json['OnHolidayStart'];
    OnHolidayEnd = json['OnHolidayEnd'];
    WorkingWageCoeficient = json['WorkingWageCoeficient'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['IdShift'] = this.IdShift;
    data['Title'] = this.Title;
    data['OnHolidayStart'] = this.OnHolidayStart;
    data['OnHolidayEnd'] = this.OnHolidayEnd;
    data['WorkingWageCoeficient'] = this.WorkingWageCoeficient;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
