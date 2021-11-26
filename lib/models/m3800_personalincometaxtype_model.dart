class M3800PersonalIncomeTaxTypeModel {                                           
  String id;
  String Name;
                                                                 
																	
  M3800PersonalIncomeTaxTypeModel({this.id,this.Name});                                         
																	
  M3800PersonalIncomeTaxTypeModel.fromJson(Map<String, dynamic> json) {           
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
