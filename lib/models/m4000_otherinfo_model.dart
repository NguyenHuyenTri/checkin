class M4000OtherInfoModel {                                           
  String id;
  String IdEmployee;
  String IdCompany;
  String TaxCode;
  String Union;
  String Ethnic;
  String Religion;
  String IdMarried;
  String Note;
                                                                 
																	
  M4000OtherInfoModel({this.id,this.IdEmployee,this.IdCompany,this.TaxCode,this.Union,this.Ethnic,this.Religion,this.IdMarried,this.Note});                                         
																	
  M4000OtherInfoModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdEmployee = json['IdEmployee'];
    IdCompany = json['IdCompany'];
    TaxCode = json['TaxCode'];
    Union = json['Union'];
    Ethnic = json['Ethnic'];
    Religion = json['Religion'];
    IdMarried = json['IdMarried'];
    Note = json['Note'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdEmployee'] = this.IdEmployee;
    data['IdCompany'] = this.IdCompany;
    data['TaxCode'] = this.TaxCode;
    data['Union'] = this.Union;
    data['Ethnic'] = this.Ethnic;
    data['Religion'] = this.Religion;
    data['IdMarried'] = this.IdMarried;
    data['Note'] = this.Note;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
