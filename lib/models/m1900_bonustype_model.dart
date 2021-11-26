class M1900BonusTypeModel {                                           
  String id;
  String Name;
                                                                 
																	
  M1900BonusTypeModel({this.id,this.Name});                                         
																	
  M1900BonusTypeModel.fromJson(Map<String, dynamic> json) {           
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
