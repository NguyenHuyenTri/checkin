class M4700ContactInfoModel {                                           
  String id;
  String IdCompany;
  String IdEmployee;
  String IdProvince;
  String IdDistrict;
  String Address;
  String Skype;
  String Facebook;
  String EmergencyContact;
  String EmergencyRelate;
  String EmergencyTel;
  String EmergencyPhone;
  String EmergencyAddress;
                                                                 
																	
  M4700ContactInfoModel({this.id,this.IdCompany,this.IdEmployee,this.IdProvince,this.IdDistrict,this.Address,this.Skype,this.Facebook,this.EmergencyContact,this.EmergencyRelate,this.EmergencyTel,this.EmergencyPhone,this.EmergencyAddress});                                         
																	
  M4700ContactInfoModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    IdEmployee = json['IdEmployee'];
    IdProvince = json['IdProvince'];
    IdDistrict = json['IdDistrict'];
    Address = json['Address'];
    Skype = json['Skype'];
    Facebook = json['Facebook'];
    EmergencyContact = json['EmergencyContact'];
    EmergencyRelate = json['EmergencyRelate'];
    EmergencyTel = json['EmergencyTel'];
    EmergencyPhone = json['EmergencyPhone'];
    EmergencyAddress = json['EmergencyAddress'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['IdEmployee'] = this.IdEmployee;
    data['IdProvince'] = this.IdProvince;
    data['IdDistrict'] = this.IdDistrict;
    data['Address'] = this.Address;
    data['Skype'] = this.Skype;
    data['Facebook'] = this.Facebook;
    data['EmergencyContact'] = this.EmergencyContact;
    data['EmergencyRelate'] = this.EmergencyRelate;
    data['EmergencyTel'] = this.EmergencyTel;
    data['EmergencyPhone'] = this.EmergencyPhone;
    data['EmergencyAddress'] = this.EmergencyAddress;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
