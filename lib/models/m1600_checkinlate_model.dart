class M1600CheckinLateModel {                                           
  String id;
  String IdCompany;
  String IdEmployee;
  String IdShift;
  String CheckinDate;
  String CheckinTime;
  String IdStatusApprove;
  String TrackingLocationLat;
  String TrackingLocationLng;
  String Reason;
                                                                 
																	
  M1600CheckinLateModel({this.id,this.IdCompany,this.IdEmployee,this.IdShift,this.CheckinDate,this.CheckinTime,this.IdStatusApprove,this.TrackingLocationLat,this.TrackingLocationLng,this.Reason});                                         
																	
  M1600CheckinLateModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    IdEmployee = json['IdEmployee'];
    IdShift = json['IdShift'];
    CheckinDate = json['CheckinDate'];
    CheckinTime = json['CheckinTime'];
    IdStatusApprove = json['IdStatusApprove'];
    TrackingLocationLat = json['TrackingLocationLat'];
    TrackingLocationLng = json['TrackingLocationLng'];
    Reason = json['Reason'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['IdEmployee'] = this.IdEmployee;
    data['IdShift'] = this.IdShift;
    data['CheckinDate'] = this.CheckinDate;
    data['CheckinTime'] = this.CheckinTime;
    data['IdStatusApprove'] = this.IdStatusApprove;
    data['TrackingLocationLat'] = this.TrackingLocationLat;
    data['TrackingLocationLng'] = this.TrackingLocationLng;
    data['Reason'] = this.Reason;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
