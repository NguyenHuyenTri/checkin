class M4200SalaryCoefficientModel {                                           
  String id;
  String IdCompany;
  String Name;
  String Money;
                                                                 
																	
  M4200SalaryCoefficientModel({this.id,this.IdCompany,this.Name,this.Money});                                         
																	
  M4200SalaryCoefficientModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    Name = json['Name'];
    Money = json['Money'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['Name'] = this.Name;
    data['Money'] = this.Money;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
