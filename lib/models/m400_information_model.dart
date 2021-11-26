class M400InformationModel {                                           
  String id;
  String IdCompany;
  String IdEmployee;
  String IdBranch;
  String IdDepartment;
  String Document;
  String Title;
  String Content;
  String IsInfoPins;
  String ViewedRequest;
  String Status;
                                                                 
																	
  M400InformationModel({this.id,this.IdCompany,this.IdEmployee,this.IdBranch,this.IdDepartment,this.Document,this.Title,this.Content,this.IsInfoPins,this.ViewedRequest,this.Status});                                         
																	
  M400InformationModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    IdEmployee = json['IdEmployee'];
    IdBranch = json['IdBranch'];
    IdDepartment = json['IdDepartment'];
    Document = json['Document'];
    Title = json['Title'];
    Content = json['Content'];
    IsInfoPins = json['IsInfoPins'];
    ViewedRequest = json['ViewedRequest'];
    Status = json['Status'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['IdEmployee'] = this.IdEmployee;
    data['IdBranch'] = this.IdBranch;
    data['IdDepartment'] = this.IdDepartment;
    data['Document'] = this.Document;
    data['Title'] = this.Title;
    data['Content'] = this.Content;
    data['IsInfoPins'] = this.IsInfoPins;
    data['ViewedRequest'] = this.ViewedRequest;
    data['Status'] = this.Status;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
