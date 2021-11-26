import 'dart:async';                                                       
																			 
import 'r400_information_provider.dart';
import 'r500_rule_provider.dart';
import 'r600_announcement_provider.dart';
import 'r700_salarytemplate_provider.dart';
import 'r800_salarydatetype_provider.dart';
import 'r900_onholiday_provider.dart';
import 'r1000_salarytable_provider.dart';
import 'r1100_onleave_provider.dart';
import 'r1200_formwork_provider.dart';
import 'r1300_onleavetype_provider.dart';
import 'r1400_typeleave_provider.dart';
import 'r1500_checkoutsoon_provider.dart';
import 'r1600_checkinlate_provider.dart';
import 'r1700_businesstrip_provider.dart';
import 'r1800_overtime_provider.dart';
import 'r1900_bonustype_provider.dart';
import 'r2000_bonus_provider.dart';
import 'r2100_overtimetype_provider.dart';
import 'r2200_advancesalarytype_provider.dart';
import 'r2300_advancesalary_provider.dart';
import 'r2400_statusapprove_provider.dart';
import 'r2500_timekeeping_provider.dart';
import 'r2600_timekeepingstatus_provider.dart';
import 'r2700_userface_provider.dart';
import 'r2800_modeluserface_provider.dart';
import 'r2900_checkinlateandcheckoutsoonsetup_provider.dart';
import 'r3000_shiftassignment_provider.dart';
import 'r3100_advancedtimekeepingsetup_provider.dart';
import 'r3200_shift_provider.dart';
import 'r3300_businesstype_provider.dart';
import 'r3400_company_provider.dart';
import 'r3500_insurance_provider.dart';
import 'r3600_contract_provider.dart';
import 'r3700_contracttype_provider.dart';
import 'r3800_personalincometaxtype_provider.dart';
import 'r3900_married_provider.dart';
import 'r4000_otherinfo_provider.dart';
import 'r4100_salaryallowance_provider.dart';
import 'r4200_salarycoefficient_provider.dart';
import 'r4300_allowance_provider.dart';
import 'r4400_paytype_provider.dart';
import 'r4500_payroll_provider.dart';
import 'r4600_healthystatus_provider.dart';
import 'r4700_contactinfo_provider.dart';
import 'r4800_workhistory_provider.dart';
import 'r4900_specializedcertificatetype_provider.dart';
import 'r5000_specializedcertificate_provider.dart';
import 'r5100_qualification_provider.dart';
import 'r5200_workingtime_provider.dart';
import 'r5300_major_provider.dart';
import 'r5400_worktype_provider.dart';
import 'r5500_employee_provider.dart';
import 'r5600_employeeactive_provider.dart';
import 'r5700_roleemployee_provider.dart';
import 'r5800_position_provider.dart';
import 'r5900_department_provider.dart';
import 'r6000_academiclevel_provider.dart';
import 'r6100_province_provider.dart';
import 'r6200_district_provider.dart';
import 'r6300_branch_provider.dart';
import 'r6400_announcementtype_provider.dart';
import 'r6500_viewinformation_provider.dart';
import 'r6600_timekeepingsetting_provider.dart';
import 'r6700_viewrule_provider.dart';
                                                                          
																			 
class Repository {                                                           
  final r400InformationProvider = R400InformationProvider();
  final r500RuleProvider = R500RuleProvider();
  final r600AnnouncementProvider = R600AnnouncementProvider();
  final r700SalaryTemplateProvider = R700SalaryTemplateProvider();
  final r800SalaryDateTypeProvider = R800SalaryDateTypeProvider();
  final r900OnHolidayProvider = R900OnHolidayProvider();
  final r1000SalaryTableProvider = R1000SalaryTableProvider();
  final r1100OnLeaveProvider = R1100OnLeaveProvider();
  final r1200FormWorkProvider = R1200FormWorkProvider();
  final r1300OnLeaveTypeProvider = R1300OnLeaveTypeProvider();
  final r1400TypeLeaveProvider = R1400TypeLeaveProvider();
  final r1500CheckoutSoonProvider = R1500CheckoutSoonProvider();
  final r1600CheckinLateProvider = R1600CheckinLateProvider();
  final r1700BusinessTripProvider = R1700BusinessTripProvider();
  final r1800OvertimeProvider = R1800OvertimeProvider();
  final r1900BonusTypeProvider = R1900BonusTypeProvider();
  final r2000BonusProvider = R2000BonusProvider();
  final r2100OvertimeTypeProvider = R2100OvertimeTypeProvider();
  final r2200AdvanceSalaryTypeProvider = R2200AdvanceSalaryTypeProvider();
  final r2300AdvanceSalaryProvider = R2300AdvanceSalaryProvider();
  final r2400StatusApproveProvider = R2400StatusApproveProvider();
  final r2500TimekeepingProvider = R2500TimekeepingProvider();
  final r2600TimekeepingStatusProvider = R2600TimekeepingStatusProvider();
  final r2700UserFaceProvider = R2700UserFaceProvider();
  final r2800ModelUserFaceProvider = R2800ModelUserFaceProvider();
  final r2900CheckinLateAndCheckoutSoonSetupProvider = R2900CheckinLateAndCheckoutSoonSetupProvider();
  final r3000ShiftAssignmentProvider = R3000ShiftAssignmentProvider();
  final r3100AdvancedTimekeepingSetupProvider = R3100AdvancedTimekeepingSetupProvider();
  final r3200ShiftProvider = R3200ShiftProvider();
  final r3300BusinessTypeProvider = R3300BusinessTypeProvider();
  final r3400CompanyProvider = R3400CompanyProvider();
  final r3500InsuranceProvider = R3500InsuranceProvider();
  final r3600ContractProvider = R3600ContractProvider();
  final r3700ContractTypeProvider = R3700ContractTypeProvider();
  final r3800PersonalIncomeTaxTypeProvider = R3800PersonalIncomeTaxTypeProvider();
  final r3900MarriedProvider = R3900MarriedProvider();
  final r4000OtherInfoProvider = R4000OtherInfoProvider();
  final r4100SalaryAllowanceProvider = R4100SalaryAllowanceProvider();
  final r4200SalaryCoefficientProvider = R4200SalaryCoefficientProvider();
  final r4300AllowanceProvider = R4300AllowanceProvider();
  final r4400PayTypeProvider = R4400PayTypeProvider();
  final r4500PayrollProvider = R4500PayrollProvider();
  final r4600HealthyStatusProvider = R4600HealthyStatusProvider();
  final r4700ContactInfoProvider = R4700ContactInfoProvider();
  final r4800WorkHistoryProvider = R4800WorkHistoryProvider();
  final r4900SpecializedCertificateTypeProvider = R4900SpecializedCertificateTypeProvider();
  final r5000SpecializedCertificateProvider = R5000SpecializedCertificateProvider();
  final r5100QualificationProvider = R5100QualificationProvider();
  final r5200WorkingTimeProvider = R5200WorkingTimeProvider();
  final r5300MajorProvider = R5300MajorProvider();
  final r5400WorkTypeProvider = R5400WorkTypeProvider();
  final r5500EmployeeProvider = R5500EmployeeProvider();
  final r5600EmployeeActiveProvider = R5600EmployeeActiveProvider();
  final r5700RoleEmployeeProvider = R5700RoleEmployeeProvider();
  final r5800PositionProvider = R5800PositionProvider();
  final r5900DepartmentProvider = R5900DepartmentProvider();
  final r6000AcademicLevelProvider = R6000AcademicLevelProvider();
  final r6100ProvinceProvider = R6100ProvinceProvider();
  final r6200DistrictProvider = R6200DistrictProvider();
  final r6300BranchProvider = R6300BranchProvider();
  final r6400AnnouncementTypeProvider = R6400AnnouncementTypeProvider();
  final r6500ViewInformationProvider = R6500ViewInformationProvider();
  final r6600TimeKeepingSettingProvider = R6600TimeKeepingSettingProvider();
  final r6700ViewRuleProvider = R6700ViewRuleProvider();
                                                                          
																			 
  /**                                                                        
   * execute Service                                                         
   */                                                                        
  Future<dynamic> executeService(int what, Map<String, dynamic> param) {     
    try {                                                                    
      param['what'] = what;                                                
      if (what >= 400 && what < 500) {                           
        // call provider Information                               
        return r400InformationProvider.p400Information(what, param);  
      }                                                         

      if (what >= 500 && what < 600) {                           
        // call provider Rule                               
        return r500RuleProvider.p500Rule(what, param);  
      }                                                         

      if (what >= 600 && what < 700) {                           
        // call provider Announcement                               
        return r600AnnouncementProvider.p600Announcement(what, param);  
      }                                                         

      if (what >= 700 && what < 800) {                           
        // call provider SalaryTemplate                               
        return r700SalaryTemplateProvider.p700SalaryTemplate(what, param);  
      }                                                         

      if (what >= 800 && what < 900) {                           
        // call provider SalaryDateType                               
        return r800SalaryDateTypeProvider.p800SalaryDateType(what, param);  
      }                                                         

      if (what >= 900 && what < 1000) {                           
        // call provider OnHoliday                               
        return r900OnHolidayProvider.p900OnHoliday(what, param);  
      }                                                         

      if (what >= 1000 && what < 1100) {                           
        // call provider SalaryTable                               
        return r1000SalaryTableProvider.p1000SalaryTable(what, param);  
      }                                                         

      if (what >= 1100 && what < 1200) {                           
        // call provider OnLeave                               
        return r1100OnLeaveProvider.p1100OnLeave(what, param);  
      }                                                         

      if (what >= 1200 && what < 1300) {                           
        // call provider FormWork                               
        return r1200FormWorkProvider.p1200FormWork(what, param);  
      }                                                         

      if (what >= 1300 && what < 1400) {                           
        // call provider OnLeaveType                               
        return r1300OnLeaveTypeProvider.p1300OnLeaveType(what, param);  
      }                                                         

      if (what >= 1400 && what < 1500) {                           
        // call provider TypeLeave                               
        return r1400TypeLeaveProvider.p1400TypeLeave(what, param);  
      }                                                         

      if (what >= 1500 && what < 1600) {                           
        // call provider CheckoutSoon                               
        return r1500CheckoutSoonProvider.p1500CheckoutSoon(what, param);  
      }                                                         

      if (what >= 1600 && what < 1700) {                           
        // call provider CheckinLate                               
        return r1600CheckinLateProvider.p1600CheckinLate(what, param);  
      }                                                         

      if (what >= 1700 && what < 1800) {                           
        // call provider BusinessTrip                               
        return r1700BusinessTripProvider.p1700BusinessTrip(what, param);  
      }                                                         

      if (what >= 1800 && what < 1900) {                           
        // call provider Overtime                               
        return r1800OvertimeProvider.p1800Overtime(what, param);  
      }                                                         

      if (what >= 1900 && what < 2000) {                           
        // call provider BonusType                               
        return r1900BonusTypeProvider.p1900BonusType(what, param);  
      }                                                         

      if (what >= 2000 && what < 2100) {                           
        // call provider Bonus                               
        return r2000BonusProvider.p2000Bonus(what, param);  
      }                                                         

      if (what >= 2100 && what < 2200) {                           
        // call provider OvertimeType                               
        return r2100OvertimeTypeProvider.p2100OvertimeType(what, param);  
      }                                                         

      if (what >= 2200 && what < 2300) {                           
        // call provider AdvanceSalaryType                               
        return r2200AdvanceSalaryTypeProvider.p2200AdvanceSalaryType(what, param);  
      }                                                         

      if (what >= 2300 && what < 2400) {                           
        // call provider AdvanceSalary                               
        return r2300AdvanceSalaryProvider.p2300AdvanceSalary(what, param);  
      }                                                         

      if (what >= 2400 && what < 2500) {                           
        // call provider StatusApprove                               
        return r2400StatusApproveProvider.p2400StatusApprove(what, param);  
      }                                                         

      if (what >= 2500 && what < 2600) {                           
        // call provider Timekeeping                               
        return r2500TimekeepingProvider.p2500Timekeeping(what, param);  
      }                                                         

      if (what >= 2600 && what < 2700) {                           
        // call provider TimekeepingStatus                               
        return r2600TimekeepingStatusProvider.p2600TimekeepingStatus(what, param);  
      }                                                         

      if (what >= 2700 && what < 2800) {                           
        // call provider UserFace                               
        return r2700UserFaceProvider.p2700UserFace(what, param);  
      }                                                         

      if (what >= 2800 && what < 2900) {                           
        // call provider ModelUserFace                               
        return r2800ModelUserFaceProvider.p2800ModelUserFace(what, param);  
      }                                                         

      if (what >= 2900 && what < 3000) {                           
        // call provider CheckinLateAndCheckoutSoonSetup                               
        return r2900CheckinLateAndCheckoutSoonSetupProvider.p2900CheckinLateAndCheckoutSoonSetup(what, param);  
      }                                                         

      if (what >= 3000 && what < 3100) {                           
        // call provider ShiftAssignment                               
        return r3000ShiftAssignmentProvider.p3000ShiftAssignment(what, param);  
      }                                                         

      if (what >= 3100 && what < 3200) {                           
        // call provider AdvancedTimekeepingSetup                               
        return r3100AdvancedTimekeepingSetupProvider.p3100AdvancedTimekeepingSetup(what, param);  
      }                                                         

      if (what >= 3200 && what < 3300) {                           
        // call provider Shift                               
        return r3200ShiftProvider.p3200Shift(what, param);  
      }                                                         

      if (what >= 3300 && what < 3400) {                           
        // call provider BusinessType                               
        return r3300BusinessTypeProvider.p3300BusinessType(what, param);  
      }                                                         

      if (what >= 3400 && what < 3500) {                           
        // call provider Company                               
        return r3400CompanyProvider.p3400Company(what, param);  
      }                                                         

      if (what >= 3500 && what < 3600) {                           
        // call provider Insurance                               
        return r3500InsuranceProvider.p3500Insurance(what, param);  
      }                                                         

      if (what >= 3600 && what < 3700) {                           
        // call provider Contract                               
        return r3600ContractProvider.p3600Contract(what, param);  
      }                                                         

      if (what >= 3700 && what < 3800) {                           
        // call provider ContractType                               
        return r3700ContractTypeProvider.p3700ContractType(what, param);  
      }                                                         

      if (what >= 3800 && what < 3900) {                           
        // call provider PersonalIncomeTaxType                               
        return r3800PersonalIncomeTaxTypeProvider.p3800PersonalIncomeTaxType(what, param);  
      }                                                         

      if (what >= 3900 && what < 4000) {                           
        // call provider Married                               
        return r3900MarriedProvider.p3900Married(what, param);  
      }                                                         

      if (what >= 4000 && what < 4100) {                           
        // call provider OtherInfo                               
        return r4000OtherInfoProvider.p4000OtherInfo(what, param);  
      }                                                         

      if (what >= 4100 && what < 4200) {                           
        // call provider SalaryAllowance                               
        return r4100SalaryAllowanceProvider.p4100SalaryAllowance(what, param);  
      }                                                         

      if (what >= 4200 && what < 4300) {                           
        // call provider SalaryCoefficient                               
        return r4200SalaryCoefficientProvider.p4200SalaryCoefficient(what, param);  
      }                                                         

      if (what >= 4300 && what < 4400) {                           
        // call provider Allowance                               
        return r4300AllowanceProvider.p4300Allowance(what, param);  
      }                                                         

      if (what >= 4400 && what < 4500) {                           
        // call provider PayType                               
        return r4400PayTypeProvider.p4400PayType(what, param);  
      }                                                         

      if (what >= 4500 && what < 4600) {                           
        // call provider Payroll                               
        return r4500PayrollProvider.p4500Payroll(what, param);  
      }                                                         

      if (what >= 4600 && what < 4700) {                           
        // call provider HealthyStatus                               
        return r4600HealthyStatusProvider.p4600HealthyStatus(what, param);  
      }                                                         

      if (what >= 4700 && what < 4800) {                           
        // call provider ContactInfo                               
        return r4700ContactInfoProvider.p4700ContactInfo(what, param);  
      }                                                         

      if (what >= 4800 && what < 4900) {                           
        // call provider WorkHistory                               
        return r4800WorkHistoryProvider.p4800WorkHistory(what, param);  
      }                                                         

      if (what >= 4900 && what < 5000) {                           
        // call provider SpecializedCertificateType                               
        return r4900SpecializedCertificateTypeProvider.p4900SpecializedCertificateType(what, param);  
      }                                                         

      if (what >= 5000 && what < 5100) {                           
        // call provider SpecializedCertificate                               
        return r5000SpecializedCertificateProvider.p5000SpecializedCertificate(what, param);  
      }                                                         

      if (what >= 5100 && what < 5200) {                           
        // call provider Qualification                               
        return r5100QualificationProvider.p5100Qualification(what, param);  
      }                                                         

      if (what >= 5200 && what < 5300) {                           
        // call provider WorkingTime                               
        return r5200WorkingTimeProvider.p5200WorkingTime(what, param);  
      }                                                         

      if (what >= 5300 && what < 5400) {                           
        // call provider Major                               
        return r5300MajorProvider.p5300Major(what, param);  
      }                                                         

      if (what >= 5400 && what < 5500) {                           
        // call provider WorkType                               
        return r5400WorkTypeProvider.p5400WorkType(what, param);  
      }                                                         

      if (what >= 5500 && what < 5600) {                           
        // call provider Employee                               
        return r5500EmployeeProvider.p5500Employee(what, param);  
      }                                                         

      if (what >= 5600 && what < 5700) {                           
        // call provider EmployeeActive                               
        return r5600EmployeeActiveProvider.p5600EmployeeActive(what, param);  
      }                                                         

      if (what >= 5700 && what < 5800) {                           
        // call provider RoleEmployee                               
        return r5700RoleEmployeeProvider.p5700RoleEmployee(what, param);  
      }                                                         

      if (what >= 5800 && what < 5900) {                           
        // call provider Position                               
        return r5800PositionProvider.p5800Position(what, param);  
      }                                                         

      if (what >= 5900 && what < 6000) {                           
        // call provider Department                               
        return r5900DepartmentProvider.p5900Department(what, param);  
      }                                                         

      if (what >= 6000 && what < 6100) {                           
        // call provider AcademicLevel                               
        return r6000AcademicLevelProvider.p6000AcademicLevel(what, param);  
      }                                                         

      if (what >= 6100 && what < 6200) {                           
        // call provider Province                               
        return r6100ProvinceProvider.p6100Province(what, param);  
      }                                                         

      if (what >= 6200 && what < 6300) {                           
        // call provider District                               
        return r6200DistrictProvider.p6200District(what, param);  
      }                                                         

      if (what >= 6300 && what < 6400) {                           
        // call provider Branch                               
        return r6300BranchProvider.p6300Branch(what, param);  
      }                                                         

      if (what >= 6400 && what < 6500) {                           
        // call provider AnnouncementType                               
        return r6400AnnouncementTypeProvider.p6400AnnouncementType(what, param);  
      }                                                         

      if (what >= 6500 && what < 6600) {                           
        // call provider ViewInformation                               
        return r6500ViewInformationProvider.p6500ViewInformation(what, param);  
      }                                                         

      if (what >= 6600 && what < 6700) {                           
        // call provider TimeKeepingSetting                               
        return r6600TimeKeepingSettingProvider.p6600TimeKeepingSetting(what, param);  
      }                                                         

      if (what >= 6700 && what < 6800) {                           
        // call provider ViewRule                               
        return r6700ViewRuleProvider.p6700ViewRule(what, param);  
      }                                                         

                                                                          
																			 
    } catch (e) {                                                            
      throw e;                                                               
    }                                                                        
  }                                                                          
}                                                                            
