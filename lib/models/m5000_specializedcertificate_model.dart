class M5000SpecializedCertificateModel {                                           
  String id;
  String IdCompany;
  String IdEmployee;
  String IdSpecializedCertificateType;
  String Name;
  String FinishPlace;
  String FinishDate;
  String Note;
                                                                 
																	
  M5000SpecializedCertificateModel({this.id,this.IdCompany,this.IdEmployee,this.IdSpecializedCertificateType,this.Name,this.FinishPlace,this.FinishDate,this.Note});                                         
																	
  M5000SpecializedCertificateModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    IdEmployee = json['IdEmployee'];
    IdSpecializedCertificateType = json['IdSpecializedCertificateType'];
    Name = json['Name'];
    FinishPlace = json['FinishPlace'];
    FinishDate = json['FinishDate'];
    Note = json['Note'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['IdEmployee'] = this.IdEmployee;
    data['IdSpecializedCertificateType'] = this.IdSpecializedCertificateType;
    data['Name'] = this.Name;
    data['FinishPlace'] = this.FinishPlace;
    data['FinishDate'] = this.FinishDate;
    data['Note'] = this.Note;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
