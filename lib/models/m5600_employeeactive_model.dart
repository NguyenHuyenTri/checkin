class M5600EmployeeActiveModel {                                           
  String id;
  String Name;
                                                                 
																	
  M5600EmployeeActiveModel({this.id,this.Name});                                         
																	
  M5600EmployeeActiveModel.fromJson(Map<String, dynamic> json) {           
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
