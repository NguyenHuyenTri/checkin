class M6700ViewRuleModel {                                           
  String id;
  String IdRule;
  String IdEmployee;
  String Status;
  String IdCompany;
                                                                 
																	
  M6700ViewRuleModel({this.id,this.IdRule,this.IdEmployee,this.Status,this.IdCompany});                                         
																	
  M6700ViewRuleModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdRule = json['IdRule'];
    IdEmployee = json['IdEmployee'];
    Status = json['Status'];
    IdCompany = json['IdCompany'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdRule'] = this.IdRule;
    data['IdEmployee'] = this.IdEmployee;
    data['Status'] = this.Status;
    data['IdCompany'] = this.IdCompany;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
