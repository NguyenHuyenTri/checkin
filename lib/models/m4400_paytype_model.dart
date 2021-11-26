class M4400PayTypeModel {                                           
  String id;
  String Name;
                                                                 
																	
  M4400PayTypeModel({this.id,this.Name});                                         
																	
  M4400PayTypeModel.fromJson(Map<String, dynamic> json) {           
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
