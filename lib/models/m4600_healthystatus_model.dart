class M4600HealthyStatusModel {                                           
  String id;
  String IdCompany;
  String IdEmployee;
  String Height;
  String Weight;
  String Blood;
  String Congenital;
  String HealthyStatus;
  String HealthLastDate;
                                                                 
																	
  M4600HealthyStatusModel({this.id,this.IdCompany,this.IdEmployee,this.Height,this.Weight,this.Blood,this.Congenital,this.HealthyStatus,this.HealthLastDate});                                         
																	
  M4600HealthyStatusModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    IdEmployee = json['IdEmployee'];
    Height = json['Height'];
    Weight = json['Weight'];
    Blood = json['Blood'];
    Congenital = json['Congenital'];
    HealthyStatus = json['HealthyStatus'];
    HealthLastDate = json['HealthLastDate'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['IdEmployee'] = this.IdEmployee;
    data['Height'] = this.Height;
    data['Weight'] = this.Weight;
    data['Blood'] = this.Blood;
    data['Congenital'] = this.Congenital;
    data['HealthyStatus'] = this.HealthyStatus;
    data['HealthLastDate'] = this.HealthLastDate;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
