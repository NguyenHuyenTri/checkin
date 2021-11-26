class M1300OnLeaveTypeModel {                                           
  String id;
  String IdFormWork;
  String Name;
  String Keyword;
  String DayPerYear;
  String IdPayType;
  String IsDeliverEnough;
  String Year;
  String ExpirationDate;
  String Description;
  String IsAccumulatingByMonth;
  String IdCompany;
                                                                 
																	
  M1300OnLeaveTypeModel({this.id,this.IdFormWork,this.Name,this.Keyword,this.DayPerYear,this.IdPayType,this.IsDeliverEnough,this.Year,this.ExpirationDate,this.Description,this.IsAccumulatingByMonth,this.IdCompany});                                         
																	
  M1300OnLeaveTypeModel.fromJson(Map<String, dynamic> json) {           
    id = json['id'];
    IdFormWork = json['IdFormWork'];
    Name = json['Name'];
    Keyword = json['Keyword'];
    DayPerYear = json['DayPerYear'];
    IdPayType = json['IdPayType'];
    IsDeliverEnough = json['IsDeliverEnough'];
    Year = json['Year'];
    ExpirationDate = json['ExpirationDate'];
    Description = json['Description'];
    IsAccumulatingByMonth = json['IsAccumulatingByMonth'];
    IdCompany = json['IdCompany'];                                                                 
  }                                                                 
																	
  Map<String, dynamic> toJson() {                                   
    final Map<String, dynamic> data = new Map<String, dynamic>();   
    data['id'] = this.id;
    data['IdFormWork'] = this.IdFormWork;
    data['Name'] = this.Name;
    data['Keyword'] = this.Keyword;
    data['DayPerYear'] = this.DayPerYear;
    data['IdPayType'] = this.IdPayType;
    data['IsDeliverEnough'] = this.IsDeliverEnough;
    data['Year'] = this.Year;
    data['ExpirationDate'] = this.ExpirationDate;
    data['Description'] = this.Description;
    data['IsAccumulatingByMonth'] = this.IsAccumulatingByMonth;
    data['IdCompany'] = this.IdCompany;                                                                 
    return data;                                                    
  }                                                                 
}                                                                   
