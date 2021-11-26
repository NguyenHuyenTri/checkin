class M1100OnLeaveModel {                                           
  String id;
  String IdCompany;
  String IdEmployee;
  String IdTypeLeave;
  String IdOnLeaveType;
  String IdShift;
  String IdStatusApprove;
  String FromDate;
  String ToDate;
  String StartTime;
  String EndTime;
  String Reason;
  String HandoverTo;
  String Phone;
  String Content;
                                                                 
																	
  M1100OnLeaveModel({this.id,this.IdCompany,this.IdEmployee,this.IdTypeLeave,this.IdOnLeaveType,this.IdShift,this.IdStatusApprove,this.FromDate,this.ToDate,this.StartTime,this.EndTime,this.Reason,this.HandoverTo,this.Phone,this.Content});                                         
																	
  M1100OnLeaveModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    IdEmployee = json['IdEmployee'];
    IdTypeLeave = json['IdTypeLeave'];
    IdOnLeaveType = json['IdOnLeaveType'];
    IdShift = json['IdShift'];
    IdStatusApprove = json['IdStatusApprove'];
    FromDate = json['FromDate'];
    ToDate = json['ToDate'];
    StartTime = json['StartTime'];
    EndTime = json['EndTime'];
    Reason = json['Reason'];
    HandoverTo = json['HandoverTo'];
    Phone = json['Phone'];
    Content = json['Content'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['IdEmployee'] = this.IdEmployee;
    data['IdTypeLeave'] = this.IdTypeLeave;
    data['IdOnLeaveType'] = this.IdOnLeaveType;
    data['IdShift'] = this.IdShift;
    data['IdStatusApprove'] = this.IdStatusApprove;
    data['FromDate'] = this.FromDate;
    data['ToDate'] = this.ToDate;
    data['StartTime'] = this.StartTime;
    data['EndTime'] = this.EndTime;
    data['Reason'] = this.Reason;
    data['HandoverTo'] = this.HandoverTo;
    data['Phone'] = this.Phone;
    data['Content'] = this.Content;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
