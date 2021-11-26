class M2500TimekeepingModel {                                           
  String id;
  String IdCompany;
  String IdEmployee;
  String IdShift;
  String CheckinLat;
  String CheckinLng;
  String CheckinTime;
  String CheckinFace;
  String CheckinFaceStatus;
  String CheckoutLat;
  String CheckoutLng;
  String CheckoutFace;
  String CheckoutFaceStatus;
  String CheckoutTime;
  String IdTimekeepingStatus;
                                                                 
																	
  M2500TimekeepingModel({this.id,this.IdCompany,this.IdEmployee,this.IdShift,this.CheckinLat,this.CheckinLng,this.CheckinTime,this.CheckinFace,this.CheckinFaceStatus,this.CheckoutLat,this.CheckoutLng,this.CheckoutFace,this.CheckoutFaceStatus,this.CheckoutTime,this.IdTimekeepingStatus});                                         
																	
  M2500TimekeepingModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    IdEmployee = json['IdEmployee'];
    IdShift = json['IdShift'];
    CheckinLat = json['CheckinLat'];
    CheckinLng = json['CheckinLng'];
    CheckinTime = json['CheckinTime'];
    CheckinFace = json['CheckinFace'];
    CheckinFaceStatus = json['CheckinFaceStatus'];
    CheckoutLat = json['CheckoutLat'];
    CheckoutLng = json['CheckoutLng'];
    CheckoutFace = json['CheckoutFace'];
    CheckoutFaceStatus = json['CheckoutFaceStatus'];
    CheckoutTime = json['CheckoutTime'];
    IdTimekeepingStatus = json['IdTimekeepingStatus'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['IdEmployee'] = this.IdEmployee;
    data['IdShift'] = this.IdShift;
    data['CheckinLat'] = this.CheckinLat;
    data['CheckinLng'] = this.CheckinLng;
    data['CheckinTime'] = this.CheckinTime;
    data['CheckinFace'] = this.CheckinFace;
    data['CheckinFaceStatus'] = this.CheckinFaceStatus;
    data['CheckoutLat'] = this.CheckoutLat;
    data['CheckoutLng'] = this.CheckoutLng;
    data['CheckoutFace'] = this.CheckoutFace;
    data['CheckoutFaceStatus'] = this.CheckoutFaceStatus;
    data['CheckoutTime'] = this.CheckoutTime;
    data['IdTimekeepingStatus'] = this.IdTimekeepingStatus;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
