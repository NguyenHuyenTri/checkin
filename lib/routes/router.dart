import 'package:auto_route/auto_route_annotations.dart';
import 'package:vao_ra/pages/itime/S999_ItimeCameraTrain.dart';
import 'package:vao_ra/screens/task/S7e_ItimeCheckoutCamera.dart';

import '../screens/screens.dart';
import '../pages/pages.dart';

export 'router.gr.dart';

/// All routes are defined in this single router.
///
/// Do NOT specify `initial` to true for any of these routes if you want to
/// reuse this router for nested navigation (as in this example).
///
/// You will declare `initialRoute` in each `ExtendedNavigator` accordingly.
@MaterialAutoRouter(
  routes: [
    MaterialRoute<void>(page: ItimeSplashScreen),
    MaterialRoute<void>(page: ItimeLogin),
    MaterialRoute<void>(page: ItimeWalkThrough),
    MaterialRoute<void>(page: ItimeVerification),
    MaterialRoute<void>(page: Root),
    MaterialRoute<void>(page: ItimeNotificationScreen),
    MaterialRoute<void>(page: ItimeTaskScreen),
    MaterialRoute<void>(page: ItimeCalendarScreen),
    MaterialRoute<void>(page: ItimeProfileScreen),
    MaterialRoute<void>(page: ItimeAddInfo),
    MaterialRoute<void>(page: ItimeEditInfo),
    MaterialRoute<void>(page: ItimeReadInfo),
    MaterialRoute<void>(page: ItimeAddRule),
    MaterialRoute<void>(page: ItimeEditRule),
    MaterialRoute<void>(page: ItimeReadRule),
    MaterialRoute<void>(page: ItimeDetailNotification),
    MaterialRoute<void>(page: ItimeFilterNotification),
    MaterialRoute<void>(page: ItimeMainTask),
    MaterialRoute<void>(page: ItimeTaskReport),
    MaterialRoute<void>(page: ItimeFilterRank),
    MaterialRoute<void>(page: ItimeFilterDetail),
    MaterialRoute<void>(page: ItimeCheckinNormal),
    MaterialRoute<void>(page: ItimeCheckinCamera),
    MaterialRoute<void>(page: ItimeCheckoutNormal),
    MaterialRoute<void>(page: ItimeCheckoutCamera),
    MaterialRoute<void>(page: ItimeSendError),
    // MaterialRoute<void>(page: ItimeApproveRequest),
    // MaterialRoute<void>(page: ItimeDeniedRequest),
    // MaterialRoute<void>(page: ItimeMyRequest),
    MaterialRoute<void>(page: ItimeAdvanceSalaryDetail),
    MaterialRoute<void>(page: ItimeBusinessTripDetail),
    MaterialRoute<void>(page: ItimeCheckinLateDetail),
    MaterialRoute<void>(page: ItimeCheckoutSoonDetail),
    MaterialRoute<void>(page: ItimeOnLeaveDetail),
    MaterialRoute<void>(page: ItimeOvertimeDetail),
    MaterialRoute<void>(page: ItimeNeedApprove),
    MaterialRoute<void>(page: ItimeManagerRequest),
    MaterialRoute<void>(page: ItimeFilterRequest),
    MaterialRoute<void>(page: ItimeRecommendAndRequest),
    MaterialRoute<void>(page: ItimeAdvanceSalary),
    MaterialRoute<void>(page: ItimeOvertimeRequest),
    MaterialRoute<void>(page: ItimeBusinessTrip),
    MaterialRoute<void>(page: ItimeCheckinLate),
    MaterialRoute<void>(page: ItimeCheckoutSoon),
    MaterialRoute<void>(page: ItimeTakeLeave),
    MaterialRoute<void>(page: ItimeTimeKeeping),
    MaterialRoute<void>(page: ItimeFilterTimeKeeping),
    MaterialRoute<void>(page: ItimeProfileMain),
    MaterialRoute<void>(page: ItimeCommonSetting),
    MaterialRoute<void>(page: ItimeAlertSetting),
    MaterialRoute<void>(page: ItimePersonalInformation),
    MaterialRoute<void>(page: ItimeTimeKeeperReport),
    MaterialRoute<void>(page: ItimeDeviceChart),
    MaterialRoute<void>(page: ItimeLateAndSoonChart),
    MaterialRoute<void>(page: ItimeTimeKeeper),
    MaterialRoute<void>(page: ItimeTimeKeeperChart),
    MaterialRoute<void>(page: ItimeNotAttendanceChart),
    MaterialRoute<void>(page: ItimeHRReport),
    MaterialRoute<void>(page: ItimeAboutAge),
    MaterialRoute<void>(page: ItimeAboutBirthday),
    MaterialRoute<void>(page: ItimeAboutEducationLevel),
    MaterialRoute<void>(page: ItimeAboutGender),
    MaterialRoute<void>(page: ItimeAboutWorkContact),
    MaterialRoute<void>(page: ItimeTimeReport),
    MaterialRoute<void>(page: ItimeOverTime),
    MaterialRoute<void>(page: ItimeTimeCoefficient),
    MaterialRoute<void>(page: ItimeEmployeeReport),
    MaterialRoute<void>(page: ItimeEmployeeDetailReport),
    MaterialRoute<void>(page: ItimeTakeLeaveList),
    MaterialRoute<void>(page: ItimeTakeLeaveInformation),
    MaterialRoute<void>(page: ItimeSalaryCoupon),
    MaterialRoute<void>(page: ItimeResultList),
    MaterialRoute<void>(page: ItimeMarkList),
    MaterialRoute<void>(page: ItimeCameraTrain),
  ],
)
class $AppRouter {}
