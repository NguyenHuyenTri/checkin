class M5100QualificationModel {                                           
  String id;
  String IdCompany;
  String IdEmployee;
  String IdAcademicLevel;
  String IdMajor;
  String TrainingPlace;
  String FinishDate;
  String Note;
                                                                 
																	
  M5100QualificationModel({this.id,this.IdCompany,this.IdEmployee,this.IdAcademicLevel,this.IdMajor,this.TrainingPlace,this.FinishDate,this.Note});                                         
																	
  M5100QualificationModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    IdEmployee = json['IdEmployee'];
    IdAcademicLevel = json['IdAcademicLevel'];
    IdMajor = json['IdMajor'];
    TrainingPlace = json['TrainingPlace'];
    FinishDate = json['FinishDate'];
    Note = json['Note'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['IdEmployee'] = this.IdEmployee;
    data['IdAcademicLevel'] = this.IdAcademicLevel;
    data['IdMajor'] = this.IdMajor;
    data['TrainingPlace'] = this.TrainingPlace;
    data['FinishDate'] = this.FinishDate;
    data['Note'] = this.Note;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
