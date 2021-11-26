class M2300AdvanceSalaryModel {                                           
  String id;
  String IdCompany;
  String IdEmployee;
  String Money;
  String Title;
  String AllowanceDay;
  String Reason;
  String IdStatusApprove;
  String CreatedAt;
                                                                 
																	
  M2300AdvanceSalaryModel({this.id,this.IdCompany,this.IdEmployee,this.Money,this.Title,this.AllowanceDay,this.Reason,this.IdStatusApprove,this.CreatedAt});
																	
  M2300AdvanceSalaryModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    IdEmployee = json['IdEmployee'];
    Money = json['Money'];
    Title = json['Title'];
    AllowanceDay = json['AllowanceDay'];
    Reason = json['Reason'];
    IdStatusApprove = json['IdStatusApprove'];
    CreatedAt = json['CreatedAt'];
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['IdEmployee'] = this.IdEmployee;
    data['Money'] = this.Money;
    data['Title'] = this.Title;
    data['AllowanceDay'] = this.AllowanceDay;
    data['Reason'] = this.Reason;
    data['IdStatusApprove'] = this.IdStatusApprove;
    data['CreatedAt'] = this.CreatedAt;
    return data;                                                    
  }                                                                 
}                                                                   
