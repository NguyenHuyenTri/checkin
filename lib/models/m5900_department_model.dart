class M5900DepartmentModel {                                           
  String id;
  String IdCompany;
  String Name;
  String Description;
  String SortIndex;
                                                                 
																	
  M5900DepartmentModel({this.id,this.IdCompany,this.Name,this.Description,this.SortIndex});                                         
																	
  M5900DepartmentModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    Name = json['Name'];
    Description = json['Description'];
    SortIndex = json['SortIndex'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['Name'] = this.Name;
    data['Description'] = this.Description;
    data['SortIndex'] = this.SortIndex;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
