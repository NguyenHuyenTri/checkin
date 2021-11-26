import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    visualDensity: VisualDensity(vertical: 0.5, horizontal: 0.5),
    primarySwatch: MaterialColor(
      0xFFF5E0C3,
      <int, Color>{
        50: Color(0x1aF5E0C3),
        100: Color(0xa1F5E0C3),
        200: Color(0xaaF5E0C3),
        300: Color(0xafF5E0C3),
        400: Color(0xffF5E0C3),
        500: Color(0xffEDD5B3),
        600: Color(0xffDEC29B),
        700: Color(0xffC9A87C),
        800: Color(0xffB28E5E),
        900: Color(0xff936F3E)
      },
    ),
    primaryColor: Colors.deepOrangeAccent,
    primaryColorBrightness: Brightness.light,
    primaryColorLight: Color(0x1aF5E0C3),
    primaryColorDark: Color(0xff936F3E),
    canvasColor: Color(0xffE09E45),
    accentColor: Color(0xffff5722),
    accentColorBrightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xfff6f8fa),
    bottomAppBarColor: Color(0xff6D42CE),
    cardColor: Color(0xaaF5E0C3),
    dividerColor: Color(0x1f6D42CE),
    focusColor: Color(0x1aF5E0C3),
    hoverColor: Color(0xffDEC29B),
    highlightColor: Color(0xff936F3E),
    splashColor: Color(0xffff5722),
//  splashFactory: # override create method from  InteractiveInkFeatureFactory
    selectedRowColor: Colors.grey,
    unselectedWidgetColor: Colors.grey.shade400,
    disabledColor: Colors.grey.shade200,
    buttonTheme: ButtonThemeData(
        //button themes
        ),
    toggleButtonsTheme: ToggleButtonsThemeData(
        //toggle button theme
        ),
    buttonColor: Color(0xff936F3E),
    secondaryHeaderColor: Colors.grey,
    textSelectionColor: Color(0xffB5BFD3),
    cursorColor: Color(0xffff5722),
    textSelectionHandleColor: Color(0xffff5722),
    backgroundColor: Color(0xFFFB8C00),
    dialogBackgroundColor: Colors.white,
    indicatorColor: Color(0xfff4511e),
    hintColor: Colors.grey,
    errorColor: Colors.red,
    toggleableActiveColor: Color(0xff6D42CE),
    textTheme: TextTheme(
        //text themes that contrast with card and canvas
        ),
    primaryTextTheme: TextTheme(
        headline6: TextStyle(
            color: Colors.white
        )
        //text theme that contrast with primary color
        ),
    accentTextTheme: TextTheme(
        //text theme that contrast with accent Color
        ),
    inputDecorationTheme: InputDecorationTheme(
        // default values for InputDecorator, TextField, and TextFormField
        ),
    iconTheme: IconThemeData(
        //icon themes that contrast with card and canvas
        ),
    primaryIconTheme: IconThemeData(

        color: Colors.white
        //icon themes that contrast primary color
        ),
    accentIconTheme: IconThemeData(
        //icon themes that contrast accent color
        ),
    sliderTheme: SliderThemeData(
        // slider themes
        ),
    tabBarTheme: TabBarTheme(
        // tab bat theme
        ),
    tooltipTheme: TooltipThemeData(
        // tool tip theme
        ),
    cardTheme: CardTheme(
        // card theme
        ),
    chipTheme: ChipThemeData(
        backgroundColor: Color(0xff936F3E),
        disabledColor: Color(0xaaF5E0C3),
        shape: StadiumBorder(),
        brightness: Brightness.light,
        labelPadding: EdgeInsets.all(8),
        labelStyle: TextStyle(),
        padding: EdgeInsets.all(8),
        secondaryLabelStyle: TextStyle(),
        secondarySelectedColor: Colors.white38,
        selectedColor: Colors.white
        // chip theme
        ),
    platform: TargetPlatform.android,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    applyElevationOverlayColor: true,
    pageTransitionsTheme: PageTransitionsTheme(
        //page transition theme
        ),
    appBarTheme: AppBarTheme(
        //app bar theme
        ),
    bottomAppBarTheme: BottomAppBarTheme(
        // bottom app bar theme
        ),
    colorScheme: ColorScheme(
        primary: Color(0xffEDD5B3),
        primaryVariant: Color(0x1aF5E0C3),
        secondary: Color(0xffC9A87C),
        secondaryVariant: Color(0xaaC9A87C),
        brightness: Brightness.light,
        background: Color(0xffB5BFD3),
        error: Colors.red,
        onBackground: Color(0xffB5BFD3),
        onError: Colors.red,
        onPrimary: Color(0xffEDD5B3),
        onSecondary: Color(0xffC9A87C),
        onSurface: Color(0xffff5722),
        surface: Color(0xffff5722)),
    snackBarTheme: SnackBarThemeData(
        // snack bar theme
        ),
    dialogTheme: DialogTheme(
        // dialog theme
        ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        // floating action button theme
        ),
    navigationRailTheme: NavigationRailThemeData(
        // navigation rail theme
        ),
    typography: Typography.material2018(),
    cupertinoOverrideTheme: CupertinoThemeData(
        //cupertino theme
        ),
    bottomSheetTheme: BottomSheetThemeData(
        //bottom sheet theme
        ),
    popupMenuTheme: PopupMenuThemeData(
        //pop menu theme
        ),
    bannerTheme: MaterialBannerThemeData(
        // material banner theme
        ),
    dividerTheme: DividerThemeData(
        //divider, vertical divider theme
        ),
    buttonBarTheme: ButtonBarThemeData(
        // button bar theme
        ),
    fontFamily: 'ROBOTO',
    splashFactory: InkSplash.splashFactory);