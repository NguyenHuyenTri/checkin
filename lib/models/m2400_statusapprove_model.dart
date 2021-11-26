class M2400StatusApproveModel {                                           
  String id;
  String Name;
                                                                 
																	
  M2400StatusApproveModel({this.id,this.Name});                                         
																	
  M2400StatusApproveModel.fromJson(Map<String, dynamic> json) {           
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
