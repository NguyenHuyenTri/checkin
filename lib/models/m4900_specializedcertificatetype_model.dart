class M4900SpecializedCertificateTypeModel {                                           
  String id;
  String Name;
                                                                 
																	
  M4900SpecializedCertificateTypeModel({this.id,this.Name});                                         
																	
  M4900SpecializedCertificateTypeModel.fromJson(Map<String, dynamic> json) {           
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
