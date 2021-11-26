class M2100OvertimeTypeModel {                                           
  String id;
  String IdCompany;
  String Name;
  String Keyword;
  String Rate;
  String LimitOvertimeHoursMonth;
  String LimitOvertimeHoursYear;
  String Description;
                                                                 
																	
  M2100OvertimeTypeModel({this.id,this.IdCompany,this.Name,this.Keyword,this.Rate,this.LimitOvertimeHoursMonth,this.LimitOvertimeHoursYear,this.Description});                                         
																	
  M2100OvertimeTypeModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    Name = json['Name'];
    Keyword = json['Keyword'];
    Rate = json['Rate'];
    LimitOvertimeHoursMonth = json['LimitOvertimeHoursMonth'];
    LimitOvertimeHoursYear = json['LimitOvertimeHoursYear'];
    Description = json['Description'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['Name'] = this.Name;
    data['Keyword'] = this.Keyword;
    data['Rate'] = this.Rate;
    data['LimitOvertimeHoursMonth'] = this.LimitOvertimeHoursMonth;
    data['LimitOvertimeHoursYear'] = this.LimitOvertimeHoursYear;
    data['Description'] = this.Description;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
