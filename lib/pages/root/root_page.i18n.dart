import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static var _t = Translations("en_us") +
      // title walk through
      {
        "vi_vn": "Quản trị dữ liệu bằng website",
        "en_us": "Data manager by website",
      } +
      {
        "vi_vn": "Đăng nhập và Quyền trên Ứng dụng",
        "en_us": "Login and permit on Application",
      } +
      {
        "vi_vn": "Quyền của Quản lý trên Ứng dụng",
        "en_us": "Powers of manager on application",
      } +
      {
        "vi_vn": "Quyền của nhân viên trên Ứng dụng",
        "en_us": "Powers of employee on application",
      } +
      // missing subtitle walk through
      {
        "vi_vn": "Tiếp tục",
        "en_us": "Continue",
      } +
      // login
      {
        "vi_vn": "Chọn công ty",
        "en_us": "Select company",
      } +
      {
        "vi_vn": "Nhập email của bạn",
        "en_us": "Enter your email",
      } +
      {
        "vi_vn": "Nhập mật khẩu của bạn",
        "en_us": "Enter your password",
      } +
      {
        "vi_vn": "Ghi nhớ",
        "en_us": "Remember",
      } +
      {
        "vi_vn": "Quên mật khẩu?",
        "en_us": "Forgot password?",
      } +
      {
        "vi_vn": "Đăng nhập",
        "en_us": "Login",
      } +
      // bottom navigation
      {
        "vi_vn": "Lịch",
        "en_us": "Calendar",
      } +
      {
        "vi_vn": "Chấm công",
        "en_us": "Checkin",
      } +
      {
        "vi_vn": "Thông báo",
        "en_us": "Notification",
      } +
      {
        "vi_vn": "Cá nhân",
        "en_us": "Profile",
      } +
      // notification
      {
        "vi_vn": "Thêm mới",
        "en_us": "Create",
      } +
      {"vi_vn": "Ngôn ngữ", "en_us": "Language"} +
      {
        "vi_vn": "Thông tin",
        "en_us": "Create",
      };

  String get i18n => localize(this, _t);
}
