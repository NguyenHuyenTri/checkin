class M1700BusinessTripModel {                                           
  String id;
  String IdCompany;
  String IdEmployee;
  String FromTime;
  String EndTime;
  String Place;
  String TrackingPlace;
  String IdShift;
  String Reason;
                                                                 
																	
  M1700BusinessTripModel({this.id,this.IdCompany,this.IdEmployee,this.FromTime,this.EndTime,this.Place,this.TrackingPlace,this.IdShift,this.Reason});                                         
																	
  M1700BusinessTripModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    IdEmployee = json['IdEmployee'];
    FromTime = json['FromTime'];
    EndTime = json['EndTime'];
    Place = json['Place'];
    TrackingPlace = json['TrackingPlace'];
    IdShift = json['IdShift'];
    Reason = json['Reason'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['IdEmployee'] = this.IdEmployee;
    data['FromTime'] = this.FromTime;
    data['EndTime'] = this.EndTime;
    data['Place'] = this.Place;
    data['TrackingPlace'] = this.TrackingPlace;
    data['IdShift'] = this.IdShift;
    data['Reason'] = this.Reason;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
