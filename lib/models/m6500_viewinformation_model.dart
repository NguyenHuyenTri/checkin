class M6500ViewInformationModel {                                           
  String id;
  String IdInformation;
  String IdEmployee;
  String Status;
  String IdCompany;
                                                                 
																	
  M6500ViewInformationModel({this.id,this.IdInformation,this.IdEmployee,this.Status,this.IdCompany});                                         
																	
  M6500ViewInformationModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdInformation = json['IdInformation'];
    IdEmployee = json['IdEmployee'];
    Status = json['Status'];
    IdCompany = json['IdCompany'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdInformation'] = this.IdInformation;
    data['IdEmployee'] = this.IdEmployee;
    data['Status'] = this.Status;
    data['IdCompany'] = this.IdCompany;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
