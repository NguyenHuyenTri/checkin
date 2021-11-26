class M4300AllowanceModel {                                           
  String id;
  String IdCompany;
  String Name;
  String Money;
  String IsPersonalIncomeTax;
  String IsInsurance;
                                                                 
																	
  M4300AllowanceModel({this.id,this.IdCompany,this.Name,this.Money,this.IsPersonalIncomeTax,this.IsInsurance});                                         
																	
  M4300AllowanceModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    Name = json['Name'];
    Money = json['Money'];
    IsPersonalIncomeTax = json['IsPersonalIncomeTax'];
    IsInsurance = json['IsInsurance'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['Name'] = this.Name;
    data['Money'] = this.Money;
    data['IsPersonalIncomeTax'] = this.IsPersonalIncomeTax;
    data['IsInsurance'] = this.IsInsurance;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
