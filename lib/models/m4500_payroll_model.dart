class M4500PayrollModel {                                           
  String id;
  String IdCompany;
  String IdPayType;
  String Name;
  String Money;
                                                                 
																	
  M4500PayrollModel({this.id,this.IdCompany,this.IdPayType,this.Name,this.Money});                                         
																	
  M4500PayrollModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    IdPayType = json['IdPayType'];
    Name = json['Name'];
    Money = json['Money'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['IdPayType'] = this.IdPayType;
    data['Name'] = this.Name;
    data['Money'] = this.Money;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
