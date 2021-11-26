class M2000BonusModel {                                           
  String id;
  String IdBonusType;
  String Title;
  String Amount;
  String IdEmployee;
  String AllowanceDay;
  String ReasonContent;
  String IdStatusApprove;
                                                                 
																	
  M2000BonusModel({this.id,this.IdBonusType,this.Title,this.Amount,this.IdEmployee,this.AllowanceDay,this.ReasonContent,this.IdStatusApprove});                                         
																	
  M2000BonusModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdBonusType = json['IdBonusType'];
    Title = json['Title'];
    Amount = json['Amount'];
    IdEmployee = json['IdEmployee'];
    AllowanceDay = json['AllowanceDay'];
    ReasonContent = json['ReasonContent'];
    IdStatusApprove = json['IdStatusApprove'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdBonusType'] = this.IdBonusType;
    data['Title'] = this.Title;
    data['Amount'] = this.Amount;
    data['IdEmployee'] = this.IdEmployee;
    data['AllowanceDay'] = this.AllowanceDay;
    data['ReasonContent'] = this.ReasonContent;
    data['IdStatusApprove'] = this.IdStatusApprove;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
