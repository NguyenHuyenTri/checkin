class M6200DistrictModel {                                           
  String id;
  String IdProvince;
  String Name;
  String Type;
                                                                 
																	
  M6200DistrictModel({this.id,this.IdProvince,this.Name,this.Type});                                         
																	
  M6200DistrictModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdProvince = json['IdProvince'];
    Name = json['Name'];
    Type = json['Type'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdProvince'] = this.IdProvince;
    data['Name'] = this.Name;
    data['Type'] = this.Type;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
