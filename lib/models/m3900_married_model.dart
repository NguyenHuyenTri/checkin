class M3900MarriedModel {                                           
  String id;
  String Name;
                                                                 
																	
  M3900MarriedModel({this.id,this.Name});                                         
																	
  M3900MarriedModel.fromJson(Map<String, dynamic> json) {           
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
