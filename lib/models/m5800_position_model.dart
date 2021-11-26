class M5800PositionModel {                                           
  String id;
  String IdCompany;
  String IdAcademicLevel;
  String Name;
  String SortIndex;
  String Experience;
  String Description;
                                                                 
																	
  M5800PositionModel({this.id,this.IdCompany,this.IdAcademicLevel,this.Name,this.SortIndex,this.Experience,this.Description});                                         
																	
  M5800PositionModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    IdAcademicLevel = json['IdAcademicLevel'];
    Name = json['Name'];
    SortIndex = json['SortIndex'];
    Experience = json['Experience'];
    Description = json['Description'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['IdAcademicLevel'] = this.IdAcademicLevel;
    data['Name'] = this.Name;
    data['SortIndex'] = this.SortIndex;
    data['Experience'] = this.Experience;
    data['Description'] = this.Description;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
