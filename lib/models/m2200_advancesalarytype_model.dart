class M2200AdvanceSalaryTypeModel {                                           
  String id;
  String Name;
                                                                 
																	
  M2200AdvanceSalaryTypeModel({this.id,this.Name});                                         
																	
  M2200AdvanceSalaryTypeModel.fromJson(Map<String, dynamic> json) {           
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
