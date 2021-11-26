class M6300BranchModel {                                           
  String id;
  String IdCompany;
  String IdProvince;
  String IdDistrict;
  String Name;
  String Address;
  String Phone;
  String SortIndex;
  String Note;
                                                                 
																	
  M6300BranchModel({this.id,this.IdCompany,this.IdProvince,this.IdDistrict,this.Name,this.Address,this.Phone,this.SortIndex,this.Note});                                         
																	
  M6300BranchModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    IdProvince = json['IdProvince'];
    IdDistrict = json['IdDistrict'];
    Name = json['Name'];
    Address = json['Address'];
    Phone = json['Phone'];
    SortIndex = json['SortIndex'];
    Note = json['Note'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['IdProvince'] = this.IdProvince;
    data['IdDistrict'] = this.IdDistrict;
    data['Name'] = this.Name;
    data['Address'] = this.Address;
    data['Phone'] = this.Phone;
    data['SortIndex'] = this.SortIndex;
    data['Note'] = this.Note;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
