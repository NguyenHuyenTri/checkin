class M600AnnouncementModel {                                           
  String id;
  String IdCompany;
  String IdEmployee;
  String IdBranch;
  String IdAnnouncementType;
  String Title;
  String Document;
  String Content;
                                                                 
																	
  M600AnnouncementModel({this.id,this.IdCompany,this.IdEmployee,this.IdBranch,this.IdAnnouncementType,this.Title,this.Document,this.Content});                                         
																	
  M600AnnouncementModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    IdEmployee = json['IdEmployee'];
    IdBranch = json['IdBranch'];
    IdAnnouncementType = json['IdAnnouncementType'];
    Title = json['Title'];
    Document = json['Document'];
    Content = json['Content'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['IdEmployee'] = this.IdEmployee;
    data['IdBranch'] = this.IdBranch;
    data['IdAnnouncementType'] = this.IdAnnouncementType;
    data['Title'] = this.Title;
    data['Document'] = this.Document;
    data['Content'] = this.Content;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
