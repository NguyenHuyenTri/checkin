class M1000SalaryTableModel {                                           
  String id;
  String IdCompany;
  String Name;
  String Keyword;
  String Month;
  String IdSalaryTemplate;
  String IdSalaryDateType;
  String StartDate;
  String EndDate;
  String IsClientInvisible;
                                                                 
																	
  M1000SalaryTableModel({this.id,this.IdCompany,this.Name,this.Keyword,this.Month,this.IdSalaryTemplate,this.IdSalaryDateType,this.StartDate,this.EndDate,this.IsClientInvisible});                                         
																	
  M1000SalaryTableModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    Name = json['Name'];
    Keyword = json['Keyword'];
    Month = json['Month'];
    IdSalaryTemplate = json['IdSalaryTemplate'];
    IdSalaryDateType = json['IdSalaryDateType'];
    StartDate = json['StartDate'];
    EndDate = json['EndDate'];
    IsClientInvisible = json['IsClientInvisible'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['Name'] = this.Name;
    data['Keyword'] = this.Keyword;
    data['Month'] = this.Month;
    data['IdSalaryTemplate'] = this.IdSalaryTemplate;
    data['IdSalaryDateType'] = this.IdSalaryDateType;
    data['StartDate'] = this.StartDate;
    data['EndDate'] = this.EndDate;
    data['IsClientInvisible'] = this.IsClientInvisible;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
