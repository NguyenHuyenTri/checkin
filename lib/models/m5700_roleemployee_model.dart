class M5700RoleEmployeeModel {                                           
  String id;
  String DisplayName;
                                                                 
																	
  M5700RoleEmployeeModel({this.id,this.DisplayName});                                         
																	
  M5700RoleEmployeeModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    DisplayName = json['DisplayName'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['DisplayName'] = this.DisplayName;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
