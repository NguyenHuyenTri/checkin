class M1800OvertimeModel {                                           
  String id;
  String IdCompany;
  String IdEmployee;
  String IdOvertimeType;
  String FromTime;
  String EndTime;
  String IdStatusApprove;
  String Reason;
  String Content;
  String OvertimeHour;
  String OvertimeBranch;
                                                                 
																	
  M1800OvertimeModel({this.id,this.IdCompany,this.IdEmployee,this.IdOvertimeType,this.FromTime,this.EndTime,this.IdStatusApprove,this.Reason,this.Content,this.OvertimeHour,this.OvertimeBranch});                                         
																	
  M1800OvertimeModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    IdEmployee = json['IdEmployee'];
    IdOvertimeType = json['IdOvertimeType'];
    FromTime = json['FromTime'];
    EndTime = json['EndTime'];
    IdStatusApprove = json['IdStatusApprove'];
    Reason = json['Reason'];
    Content = json['Content'];
    OvertimeHour = json['OvertimeHour'];
    OvertimeBranch = json['OvertimeBranch'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['IdEmployee'] = this.IdEmployee;
    data['IdOvertimeType'] = this.IdOvertimeType;
    data['FromTime'] = this.FromTime;
    data['EndTime'] = this.EndTime;
    data['IdStatusApprove'] = this.IdStatusApprove;
    data['Reason'] = this.Reason;
    data['Content'] = this.Content;
    data['OvertimeHour'] = this.OvertimeHour;
    data['OvertimeBranch'] = this.OvertimeBranch;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
