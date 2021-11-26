class M3700ContractTypeModel {                                           
  String id;
  String Name;
                                                                 
																	
  M3700ContractTypeModel({this.id,this.Name});                                         
																	
  M3700ContractTypeModel.fromJson(Map<String, dynamic> json) {           
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
