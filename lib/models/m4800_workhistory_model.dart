class M4800WorkHistoryModel {                                           
  String id;
  String IdCompany;
  String IdEmployee;
  String WorkPlace;
  String Position;
  String WorkDays;
  String FromDate;
  String ToDate;
                                                                 
																	
  M4800WorkHistoryModel({this.id,this.IdCompany,this.IdEmployee,this.WorkPlace,this.Position,this.WorkDays,this.FromDate,this.ToDate});                                         
																	
  M4800WorkHistoryModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    IdEmployee = json['IdEmployee'];
    WorkPlace = json['WorkPlace'];
    Position = json['Position'];
    WorkDays = json['WorkDays'];
    FromDate = json['FromDate'];
    ToDate = json['ToDate'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['IdEmployee'] = this.IdEmployee;
    data['WorkPlace'] = this.WorkPlace;
    data['Position'] = this.Position;
    data['WorkDays'] = this.WorkDays;
    data['FromDate'] = this.FromDate;
    data['ToDate'] = this.ToDate;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
