class M3000ShiftAssignmentModel {                                           
  String id;
  String IdCompany;
  String IdEmployee;
  String IdShift;
  String IdBranch;
  String IdDepartment;
  String IdPosition;
  String ActingTime;
  String SortIndex;
                                                                 
																	
  M3000ShiftAssignmentModel({this.id,this.IdCompany,this.IdEmployee,this.IdShift,this.IdBranch,this.IdDepartment,this.IdPosition,this.ActingTime,this.SortIndex});                                         
																	
  M3000ShiftAssignmentModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    IdEmployee = json['IdEmployee'];
    IdShift = json['IdShift'];
    IdBranch = json['IdBranch'];
    IdDepartment = json['IdDepartment'];
    IdPosition = json['IdPosition'];
    ActingTime = json['ActingTime'];
    SortIndex = json['SortIndex'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['IdEmployee'] = this.IdEmployee;
    data['IdShift'] = this.IdShift;
    data['IdBranch'] = this.IdBranch;
    data['IdDepartment'] = this.IdDepartment;
    data['IdPosition'] = this.IdPosition;
    data['ActingTime'] = this.ActingTime;
    data['SortIndex'] = this.SortIndex;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
