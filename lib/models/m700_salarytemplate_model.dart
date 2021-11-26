class M700SalaryTemplateModel {                                           
  String id;
  String IdCompany;
  String IdEmployee;
  String IdBranch;
  String IdPayType;
  String Name;
  String Description;
  String Keyword;
  String LocationApplies;
                                                                 
																	
  M700SalaryTemplateModel({this.id,this.IdCompany,this.IdEmployee,this.IdBranch,this.IdPayType,this.Name,this.Description,this.Keyword,this.LocationApplies});                                         
																	
  M700SalaryTemplateModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    IdEmployee = json['IdEmployee'];
    IdBranch = json['IdBranch'];
    IdPayType = json['IdPayType'];
    Name = json['Name'];
    Description = json['Description'];
    Keyword = json['Keyword'];
    LocationApplies = json['LocationApplies'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['IdEmployee'] = this.IdEmployee;
    data['IdBranch'] = this.IdBranch;
    data['IdPayType'] = this.IdPayType;
    data['Name'] = this.Name;
    data['Description'] = this.Description;
    data['Keyword'] = this.Keyword;
    data['LocationApplies'] = this.LocationApplies;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
