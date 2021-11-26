class M4100SalaryAllowanceModel {                                           
  String id;
  String IdCompany;
  String IdEmployee;
  String IdPayType;
  String IdPayroll;
  String IdAllowance;
  String IdSalaryCoefficient;
  String Salary;
                                                                 
																	
  M4100SalaryAllowanceModel({this.id,this.IdCompany,this.IdEmployee,this.IdPayType,this.IdPayroll,this.IdAllowance,this.IdSalaryCoefficient,this.Salary});                                         
																	
  M4100SalaryAllowanceModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdCompany = json['IdCompany'];
    IdEmployee = json['IdEmployee'];
    IdPayType = json['IdPayType'];
    IdPayroll = json['IdPayroll'];
    IdAllowance = json['IdAllowance'];
    IdSalaryCoefficient = json['IdSalaryCoefficient'];
    Salary = json['Salary'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdCompany'] = this.IdCompany;
    data['IdEmployee'] = this.IdEmployee;
    data['IdPayType'] = this.IdPayType;
    data['IdPayroll'] = this.IdPayroll;
    data['IdAllowance'] = this.IdAllowance;
    data['IdSalaryCoefficient'] = this.IdSalaryCoefficient;
    data['Salary'] = this.Salary;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
