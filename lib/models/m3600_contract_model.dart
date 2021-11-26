class M3600ContractModel {                                           
  String id;
  String IdCompany;
  String IdEmployee;
  String IdContractType;
  String IdPersonalIncomeTaxType;
  String IdWorkType;
  String IdPayType;
  String ContractNumber;
  String Signer;
  String SignDate;
  String ExpirationDate;
  String TrainWorkTime;
  String Salary;
  String Manager;
  String WorkLocation;
  String WorkingDate;
  String Settlement;
  String Attachment;
  String Note;
                                                                 
																	
  M3600ContractModel({this.id,this.IdCompany,this.IdEmployee,this.IdContractType,this.IdPersonalIncomeTaxType,this.IdWorkType,this.IdPayType,this.ContractNumber,this.Signer,this.SignDate,this.ExpirationDate,this.TrainWorkTime,this.Salary,this.Manager,this.WorkLocation,this.WorkingDate,this.Settlement,this.Attachment,this.Note});                                         
																	
  M3600ContractModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    IdEmployee = json['IdEmployee'];
    IdContractType = json['IdContractType'];
    IdPersonalIncomeTaxType = json['IdPersonalIncomeTaxType'];
    IdWorkType = json['IdWorkType'];
    IdPayType = json['IdPayType'];
    ContractNumber = json['ContractNumber'];
    Signer = json['Signer'];
    SignDate = json['SignDate'];
    ExpirationDate = json['ExpirationDate'];
    TrainWorkTime = json['TrainWorkTime'];
    Salary = json['Salary'];
    Manager = json['Manager'];
    WorkLocation = json['WorkLocation'];
    WorkingDate = json['WorkingDate'];
    Settlement = json['Settlement'];
    Attachment = json['Attachment'];
    Note = json['Note'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['IdEmployee'] = this.IdEmployee;
    data['IdContractType'] = this.IdContractType;
    data['IdPersonalIncomeTaxType'] = this.IdPersonalIncomeTaxType;
    data['IdWorkType'] = this.IdWorkType;
    data['IdPayType'] = this.IdPayType;
    data['ContractNumber'] = this.ContractNumber;
    data['Signer'] = this.Signer;
    data['SignDate'] = this.SignDate;
    data['ExpirationDate'] = this.ExpirationDate;
    data['TrainWorkTime'] = this.TrainWorkTime;
    data['Salary'] = this.Salary;
    data['Manager'] = this.Manager;
    data['WorkLocation'] = this.WorkLocation;
    data['WorkingDate'] = this.WorkingDate;
    data['Settlement'] = this.Settlement;
    data['Attachment'] = this.Attachment;
    data['Note'] = this.Note;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
