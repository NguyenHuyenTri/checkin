class M5500EmployeeModel {
  String id;
  String IdBranch;
  String IdDepartment;
  String IdCompany;
  String RoleEmployee;
  String IdEmployeeActive;
  String Fullname;
  String Phone;
  String Email;
  String Image;
  String Birthday;
  String Gender;
  String SortIndex;
  String CardIdentity;
  String DateRelease;
  String PlaceRelease;
  String PassportCard;
  String PassportDate;
  String PassportExpiryDate;
  String PassportIssueIn;
  String BankAccountName;
  String BankAccount;
  String BankName;
  String BankAddress;
  String Password;

  M5500EmployeeModel(
      {this.id,
      this.IdBranch,
      this.IdDepartment,
      this.IdCompany,
      this.RoleEmployee,
      this.IdEmployeeActive,
      this.Fullname,
      this.Phone,
      this.Email,
      this.Image,
      this.Birthday,
      this.Gender,
      this.SortIndex,
      this.CardIdentity,
      this.DateRelease,
      this.PlaceRelease,
      this.PassportCard,
      this.PassportDate,
      this.PassportExpiryDate,
      this.PassportIssueIn,
      this.BankAccountName,
      this.BankAccount,
      this.BankName,
      this.BankAddress,
      this.Password});

  M5500EmployeeModel.fromJson(Map<String, dynamic> json) {
    print('Call M5500EmployeeModel.fromJson ${json}');
    id = json['id'];
    IdBranch = json['IdBranch'];
    IdDepartment = json['IdDepartment'];
    IdCompany = json['IdCompany'];
    RoleEmployee = json['RoleEmployee'];
    IdEmployeeActive = json['IdEmployeeActive'];
    Fullname = json['Fullname'];
    Phone = json['Phone'];
    Email = json['Email'];
    Image = json['Image'];
    Birthday = json['Birthday'];
    Gender = json['Gender'];
    SortIndex = json['SortIndex'];
    CardIdentity = json['CardIdentity'];
    DateRelease = json['DateRelease'];
    PlaceRelease = json['PlaceRelease'];
    PassportCard = json['PassportCard'];
    PassportDate = json['PassportDate'];
    PassportExpiryDate = json['PassportExpiryDate'];
    PassportIssueIn = json['PassportIssueIn'];
    BankAccountName = json['BankAccountName'];
    BankAccount = json['BankAccount'];
    BankName = json['BankName'];
    BankAddress = json['BankAddress'];
    Password = json['Password'];
    print('Call M5500EmployeeModel.fromJson success');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['IdBranch'] = this.IdBranch;
    data['IdDepartment'] = this.IdDepartment;
    data['IdCompany'] = this.IdCompany;
    data['RoleEmployee'] = this.RoleEmployee;
    data['IdEmployeeActive'] = this.IdEmployeeActive;
    data['Fullname'] = this.Fullname;
    data['Phone'] = this.Phone;
    data['Email'] = this.Email;
    data['Image'] = this.Image;
    data['Birthday'] = this.Birthday;
    data['Gender'] = this.Gender;
    data['SortIndex'] = this.SortIndex;
    data['CardIdentity'] = this.CardIdentity;
    data['DateRelease'] = this.DateRelease;
    data['PlaceRelease'] = this.PlaceRelease;
    data['PassportCard'] = this.PassportCard;
    data['PassportDate'] = this.PassportDate;
    data['PassportExpiryDate'] = this.PassportExpiryDate;
    data['PassportIssueIn'] = this.PassportIssueIn;
    data['BankAccountName'] = this.BankAccountName;
    data['BankAccount'] = this.BankAccount;
    data['BankName'] = this.BankName;
    data['BankAddress'] = this.BankAddress;
    data['Password'] = this.Password;
    return data;
  }
}
