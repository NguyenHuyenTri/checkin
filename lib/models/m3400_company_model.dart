class M3400CompanyModel {                                           
  String id;
  String IdProvince;
  String IdDistrict;
  String IdBusinessType;
  String CompanyName;
  String Image;
  String Address;
  String Phone;
  String UserName;
  String Password;
  String Website;
  String Email;
  String Scale;
  String CharterCapital;
  String Keyword;
  String BankName;
  String BankAccount;
  String TaxCode;
  String Note;
                                                                 
																	
  M3400CompanyModel({this.id,this.IdProvince,this.IdDistrict,this.IdBusinessType,this.CompanyName,this.Image,this.Address,this.Phone,this.UserName,this.Password,this.Website,this.Email,this.Scale,this.CharterCapital,this.Keyword,this.BankName,this.BankAccount,this.TaxCode,this.Note});                                         
																	
  M3400CompanyModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdProvince = json['IdProvince'];
    IdDistrict = json['IdDistrict'];
    IdBusinessType = json['IdBusinessType'];
    CompanyName = json['CompanyName'];
    Image = json['Image'];
    Address = json['Address'];
    Phone = json['Phone'];
    UserName = json['UserName'];
    Password = json['Password'];
    Website = json['Website'];
    Email = json['Email'];
    Scale = json['Scale'];
    CharterCapital = json['CharterCapital'];
    Keyword = json['Keyword'];
    BankName = json['BankName'];
    BankAccount = json['BankAccount'];
    TaxCode = json['TaxCode'];
    Note = json['Note'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdProvince'] = this.IdProvince;
    data['IdDistrict'] = this.IdDistrict;
    data['IdBusinessType'] = this.IdBusinessType;
    data['CompanyName'] = this.CompanyName;
    data['Image'] = this.Image;
    data['Address'] = this.Address;
    data['Phone'] = this.Phone;
    data['UserName'] = this.UserName;
    data['Password'] = this.Password;
    data['Website'] = this.Website;
    data['Email'] = this.Email;
    data['Scale'] = this.Scale;
    data['CharterCapital'] = this.CharterCapital;
    data['Keyword'] = this.Keyword;
    data['BankName'] = this.BankName;
    data['BankAccount'] = this.BankAccount;
    data['TaxCode'] = this.TaxCode;
    data['Note'] = this.Note;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
