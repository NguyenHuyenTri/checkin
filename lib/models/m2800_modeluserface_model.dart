class M2800ModelUserFaceModel {                                           
  String id;
  String IdCompany;
  String IdEmployee;
  String ModelTrain;
  String CreatedAt;
                                                                 
																	
  M2800ModelUserFaceModel({this.id,this.IdCompany,this.IdEmployee,this.ModelTrain,this.CreatedAt});                                         
																	
  M2800ModelUserFaceModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    IdEmployee = json['IdEmployee'];
    ModelTrain = json['ModelTrain'];
    CreatedAt = json['CreatedAt'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['IdEmployee'] = this.IdEmployee;
    data['ModelTrain'] = this.ModelTrain;
    data['CreatedAt'] = this.CreatedAt;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
