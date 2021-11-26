class M3500InsuranceModel {                                           
  String id;
  String IdCompany;
  String IdEmployee;
  String Gender;
  String Birthday;
  String IdInsurance;
  String IdInsuranceCard;
  String IsSubmitInsuranceBook;
  String IdCard;
                                                                 
																	
  M3500InsuranceModel({this.id,this.IdCompany,this.IdEmployee,this.Gender,this.Birthday,this.IdInsurance,this.IdInsuranceCard,this.IsSubmitInsuranceBook,this.IdCard});                                         
																	
  M3500InsuranceModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    IdEmployee = json['IdEmployee'];
    Gender = json['Gender'];
    Birthday = json['Birthday'];
    IdInsurance = json['IdInsurance'];
    IdInsuranceCard = json['IdInsuranceCard'];
    IsSubmitInsuranceBook = json['IsSubmitInsuranceBook'];
    IdCard = json['IdCard'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['IdEmployee'] = this.IdEmployee;
    data['Gender'] = this.Gender;
    data['Birthday'] = this.Birthday;
    data['IdInsurance'] = this.IdInsurance;
    data['IdInsuranceCard'] = this.IdInsuranceCard;
    data['IsSubmitInsuranceBook'] = this.IsSubmitInsuranceBook;
    data['IdCard'] = this.IdCard;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
