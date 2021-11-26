class M2600TimekeepingStatusModel {                                           
  String id;
  String Name;
                                                                 
																	
  M2600TimekeepingStatusModel({this.id,this.Name});                                         
																	
  M2600TimekeepingStatusModel.fromJson(Map<String, dynamic> json) {           
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
