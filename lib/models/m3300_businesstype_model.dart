class M3300BusinessTypeModel {                                           
  String id;
  String Name;
                                                                 
																	
  M3300BusinessTypeModel({this.id,this.Name});                                         
																	
  M3300BusinessTypeModel.fromJson(Map<String, dynamic> json) {           
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
