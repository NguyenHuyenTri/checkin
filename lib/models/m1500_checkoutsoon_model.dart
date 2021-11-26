class M1500CheckoutSoonModel {                                           
  String id;
  String IdCompany;
  String IdEmployee;
  String IdShift;
  String CheckoutDate;
  String CheckoutTime;
  String IdStatusApprove;
  String TrackingLocationLat;
  String TrackingLocationLng;
  String Reason;
                                                                 
																	
  M1500CheckoutSoonModel({this.id,this.IdCompany,this.IdEmployee,this.IdShift,this.CheckoutDate,this.CheckoutTime,this.IdStatusApprove,this.TrackingLocationLat,this.TrackingLocationLng,this.Reason});                                         
																	
  M1500CheckoutSoonModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    IdEmployee = json['IdEmployee'];
    IdShift = json['IdShift'];
    CheckoutDate = json['CheckoutDate'];
    CheckoutTime = json['CheckoutTime'];
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
    data['CheckoutDate'] = this.CheckoutDate;
    data['CheckoutTime'] = this.CheckoutTime;
    data['IdStatusApprove'] = this.IdStatusApprove;
    data['TrackingLocationLat'] = this.TrackingLocationLat;
    data['TrackingLocationLng'] = this.TrackingLocationLng;
    data['Reason'] = this.Reason;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
