class M6100ProvinceModel {                                           
  String id;
  String Name;
  String Type;
                                                                 
																	
  M6100ProvinceModel({this.id,this.Name,this.Type});                                         
																	
  M6100ProvinceModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    Name = json['Name'];
    Type = json['Type'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['Name'] = this.Name;
    data['Type'] = this.Type;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
