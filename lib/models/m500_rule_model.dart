class M500RuleModel {                                           
  String id;
  String IdCompany;
  String Title;
  String IsShow;
  String Image;
  String Description;
  String Document;
  String Status;
                                                                 
																	
  M500RuleModel({this.id,this.IdCompany,this.Title,this.IsShow,this.Image,this.Description,this.Document,this.Status});                                         
																	
  M500RuleModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    Title = json['Title'];
    IsShow = json['IsShow'];
    Image = json['Image'];
    Description = json['Description'];
    Document = json['Document'];
    Status = json['Status'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['Title'] = this.Title;
    data['IsShow'] = this.IsShow;
    data['Image'] = this.Image;
    data['Description'] = this.Description;
    data['Document'] = this.Document;
    data['Status'] = this.Status;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
