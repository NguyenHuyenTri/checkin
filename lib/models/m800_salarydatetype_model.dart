class M800SalaryDateTypeModel {                                           
  String id;
  String Name;
                                                                 
																	
  M800SalaryDateTypeModel({this.id,this.Name});                                         
																	
  M800SalaryDateTypeModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    Name = json['Name'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['Name'] = this.Name;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
