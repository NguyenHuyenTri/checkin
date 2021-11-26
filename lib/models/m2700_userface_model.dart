class M2700UserFaceModel {                                           
  String id;
  String IdCompany;
  String IdEmployee;
  String Avatar;
  String CreatedAt;
                                                                 
																	
  M2700UserFaceModel({this.id,this.IdCompany,this.IdEmployee,this.Avatar,this.CreatedAt});                                         
																	
  M2700UserFaceModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    IdEmployee = json['IdEmployee'];
    Avatar = json['Avatar'];
    CreatedAt = json['CreatedAt'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['IdEmployee'] = this.IdEmployee;
    data['Avatar'] = this.Avatar;
    data['CreatedAt'] = this.CreatedAt;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
