class M6400AnnouncementTypeModel {                                           
  String id;
  String IdCompany;
  String Name;
                                                                 
																	
  M6400AnnouncementTypeModel({this.id,this.IdCompany,this.Name});                                         
																	
  M6400AnnouncementTypeModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    Name = json['Name'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['Name'] = this.Name;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
