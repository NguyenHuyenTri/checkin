class M5200WorkingTimeModel {                                           
  String id;
  String IdCompany;
  String IdEmployee;
  String IdWorkType;
  String LabourStartDate;
  String WorkingDate;
  String ExpiredDate;
  String CheckinLate;
  String CheckoutEarly;
  String Note;
  String QuitReason;
  String QuitDate;
                                                                 
																	
  M5200WorkingTimeModel({this.id,this.IdCompany,this.IdEmployee,this.IdWorkType,this.LabourStartDate,this.WorkingDate,this.ExpiredDate,this.CheckinLate,this.CheckoutEarly,this.Note,this.QuitReason,this.QuitDate});                                         
																	
  M5200WorkingTimeModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    IdEmployee = json['IdEmployee'];
    IdWorkType = json['IdWorkType'];
    LabourStartDate = json['LabourStartDate'];
    WorkingDate = json['WorkingDate'];
    ExpiredDate = json['ExpiredDate'];
    CheckinLate = json['CheckinLate'];
    CheckoutEarly = json['CheckoutEarly'];
    Note = json['Note'];
    QuitReason = json['QuitReason'];
    QuitDate = json['QuitDate'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['IdEmployee'] = this.IdEmployee;
    data['IdWorkType'] = this.IdWorkType;
    data['LabourStartDate'] = this.LabourStartDate;
    data['WorkingDate'] = this.WorkingDate;
    data['ExpiredDate'] = this.ExpiredDate;
    data['CheckinLate'] = this.CheckinLate;
    data['CheckoutEarly'] = this.CheckoutEarly;
    data['Note'] = this.Note;
    data['QuitReason'] = this.QuitReason;
    data['QuitDate'] = this.QuitDate;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
