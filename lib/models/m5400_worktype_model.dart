class M5400WorkTypeModel {                                           
  String id;
  String Name;
                                                                 
																	
  M5400WorkTypeModel({this.id,this.Name});                                         
																	
  M5400WorkTypeModel.fromJson(Map<String, dynamic> json) {           
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
