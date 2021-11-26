import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vao_ra/blocs/authentication/authentication.dart';
import 'package:vao_ra/blocs/login/login.dart';
import 'package:vao_ra/models/models.dart';
import 'package:vao_ra/repositories/auth_prodiver.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_select/smart_select.dart';

import '../../blocs/blocs.dart';

class ItimeLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final maxHeight = constraints.maxHeight;
            final maxWidth = constraints.maxWidth;
            final maxHeightLogin = maxHeight / 2;
            final heightList = maxHeight - maxHeightLogin;
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Scaffold(
                body: Container(
                  height: maxHeight,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Image.asset(
                          "assets/images/itime/main_top.png",
                          width: maxWidth * 0.35,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Image.asset(
                          "assets/images/itime/login_bottom.png",
                          width: maxWidth * 0.4,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: maxHeight / 3,
                            padding: EdgeInsets.all(50.0),
                            child:
                                Image.asset('assets/images/itime/20943476.png'),
                          ),
                          Container(
                            height: maxHeight / (3 / 2),
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 0, left: 35, right: 35),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  child: BlocBuilder<AuthenticationBloc,
                                      AuthenticationState>(
                                    builder: (context, state) {
                                      final authBloc =
                                          BlocProvider.of<AuthenticationBloc>(
                                              context);
                                      if (state
                                          is AuthenticationNotAuthenticated) {
                                        return _AuthForm(); // show authentication form
                                      }
                                      if (state
                                          is AuthenticationAuthenticatedNeedChooseCompany) {
                                        return _CompanyForm(); // show authentication form
                                      }
                                      if (state is AuthenticationFailure) {
                                        // show error message
                                        return Center(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(state.message),
                                            FlatButton(
                                              textColor: Theme.of(context)
                                                  .primaryColor,
                                              child: Text('Retry'),
                                              onPressed: () {
                                                authBloc.add(AppLoaded());
                                              },
                                            )
                                          ],
                                        ));
                                      }
                                      // show splash screen
                                      return Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AuthForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = RepositoryProvider.of<AuthProvider>(context);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Container(
      alignment: Alignment.center,
      child: BlocProvider<LoginBlocBaohq>(
        create: (context) => LoginBlocBaohq(authBloc, authService),
        child: _SignInForm(),
      ),
    );
  }
}

class _SignInForm extends StatefulWidget {
  @override
  __SignInFormState createState() => __SignInFormState();
}

class __SignInFormState extends State<_SignInForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  // final _usernameController = TextEditingController(text: 'dat18090@gmail.com');
  // final _passwordController = TextEditingController(text: '123456');
  final _usernameController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  bool _autoValidate = false;
  FocusNode _focusNodeUsername;
  FocusNode _focusNodePassword;
  Color colorLabelUsername;
  Color colorLabelPassword;

  // Initially password is obscure
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _focusNodeUsername = FocusNode();
    _focusNodeUsername.addListener(() {
      colorLabelUsername =
          _focusNodeUsername.hasFocus ? Colors.deepOrangeAccent : Colors.grey;
    });

    _focusNodePassword = FocusNode();
    _focusNodePassword.addListener(() {
      colorLabelPassword =
          _focusNodePassword.hasFocus ? Colors.deepOrangeAccent : Colors.grey;
    });
  }

  @override
  void dispose() {
    _focusNodeUsername.dispose();
    _focusNodePassword.dispose();
    super.dispose();
  }

  void _requestFocusUsername() {
    setState(() {
      FocusScope.of(context).requestFocus(_focusNodeUsername);
    });
  }

  void _requestFocusPassword() {
    setState(() {
      FocusScope.of(context).requestFocus(_focusNodePassword);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.of<LoginBlocBaohq>(context);

    _onLoginButtonPressed() {
      if (_key.currentState.validate()) {
        _loginBloc.add(LoginInWithUsernameButtonPressed(
            username: _usernameController.text,
            password: _passwordController.text));
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    }

    return BlocListener<LoginBlocBaohq, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          _showError(state.error);
        }
      },
      child: BlocBuilder<LoginBlocBaohq, LoginState>(
        builder: (context, state) {
          if (state is LoginLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Form(
            key: _key,
            autovalidate: _autoValidate,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    focusNode: _focusNodeUsername,
                    onTap: _requestFocusUsername,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        borderSide: BorderSide(
                            color: Colors.deepOrangeAccent, width: 2),
                      ),
                      alignLabelWithHint: false,
                      labelText: 'Email hoặc điện thoại',
                      labelStyle: TextStyle(color: colorLabelUsername),
                      hintStyle: TextStyle(color: Colors.black),
                      filled: true,
                      // focusColor: Colors.red,
                      // hoverColor: Colors.red,
                      isDense: true,
                      prefixIcon: Icon(Icons.assignment_ind_outlined),
                    ),
                    controller: _usernameController,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    validator: (value) {
                      if (value == null) {
                        return 'Không được bỏ trống';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    // textAlignVertical: TextAlignVertical.center,
                    focusNode: _focusNodePassword,
                    onTap: _requestFocusPassword,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Mật khẩu',
                      filled: true,
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        borderSide: BorderSide(
                            color: Colors.deepOrangeAccent, width: 2),
                      ),
                      labelStyle: TextStyle(color: colorLabelPassword),
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null) {
                        return 'Không được bỏ trống';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity, // match_parent
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(12),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(25)),
                      child: Text(
                        'Đăng nhập',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed:
                          state is LoginLoading ? () {} : _onLoginButtonPressed,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showError(String error) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(error),
      backgroundColor: Theme.of(context).errorColor,
    ));
  }
}

class _CompanyForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = RepositoryProvider.of<AuthProvider>(context);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Container(
      alignment: Alignment.center,
      child: BlocProvider<LoginBlocBaohq>(
        create: (context) => LoginBlocBaohq(authBloc, authService),
        child: _SelectCompany(),
      ),
    );
  }
}

class _SelectCompany extends StatefulWidget {
  @override
  _SelectCompanyState createState() => _SelectCompanyState();
}

class _SelectCompanyState extends State<_SelectCompany> {
  // Get list from future
  final companyBLOC = CompanyBloc();

  double height;

  M3400CompanyModel currentCompany;

  // Get list model
  List<M3400CompanyModel> companyNameList = [];

  String idCompany = '';
  List<S2Choice<String>> companiesOptionList = [];

  @override
  void initState() {
    super.initState();
    companyBLOC.companyStream3407.listen(_handleCompanyListReturn);
    companyBLOC.callWhat3407();
  }

  void _handleCompanyListReturn(List<M3400CompanyModel> companies) {
    print('companies ${companies}');
    companyNameList = companies;
    companiesOptionList = [];
    for (var i = 0; i < companyNameList.length; i++) {
      companiesOptionList.add(S2Choice<String>(
          value: companyNameList[i].id, title: companyNameList[i].CompanyName));
    }

    print(companiesOptionList);
  }

  @override
  void dispose() {
    companyBLOC.dispose();
    super.dispose();
  }

  String _car = '';

  void _openFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: this.height / (3 / 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(this.height / 4),
              topRight: Radius.circular(this.height / 4),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
            ),
            shape: BoxShape.rectangle,
            // color: HexColor('#4f4f4f'),
          ),
          child: Container(
            color: Colors.white,
            child: ListView.builder(
              itemCount: this.companyNameList.length,
              itemBuilder: (BuildContext context, int index) {
                return _companyCard(this.companyNameList[index], context);
              },
            ),
          ),
        );
      },
    ).then((data) {
      setState(() {
        this.currentCompany = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    this.height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return BlocListener<LoginBlocBaohq, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          _showError(state.error);
        }
      },
      child: BlocBuilder<LoginBlocBaohq, LoginState>(
        builder: (context, state) {
          if (state is LoginLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Container(
              // color: Colors.red,
              width: width - 40,
              height: MediaQuery.of(context).size.height / 3,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _openFilterDialog();
                    },
                    child: Container(
                      height: (this.currentCompany != null &&
                              this.currentCompany.id != null &&
                              this.currentCompany.id != "")
                          ? 100
                          : 70,
                      // color: Colors.green,
                      decoration: new BoxDecoration(
                        color: Colors.grey.shade200,
                        // shape: BoxShape.circle,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        shape: BoxShape.rectangle,
                        // color: Colors.grey,
                        // boxShadow: [
                        //   // color: Colors.white, //background color of box
                        //   BoxShadow(
                        //     color: Colors.black.withOpacity(0.25),
                        //     blurRadius: 10.0, // soften the shadow
                        //     spreadRadius: -5.0, //extend the shadow
                        //
                        //     offset: Offset(
                        //       0.0, // Move to right 10  horizontally
                        //       5.0, // Move to bottom 10 Vertically
                        //     ),
                        //   )
                        // ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: (this.currentCompany != null &&
                                this.currentCompany.id != null &&
                                this.currentCompany.id != "")
                            ? Row(
                                children: [
                                  SizedBox(
                                    height: 50.0 - 10.0,
                                    width: 50.0 - 10.0,
                                    child: CircleAvatar(
                                      backgroundImage: (this.currentCompany !=
                                                  null &&
                                              this.currentCompany.Image !=
                                                  null &&
                                              this.currentCompany.Image != "")
                                          ? NetworkImage(
                                              this.currentCompany.Image)
                                          : AssetImage(
                                              "assets/images/itime/20943476.png"),
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: SizedBox(
                                      width: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width - 210,
                                    height: 100.0 - 10.0,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: width - 200,
                                          child: Text(
                                              this.currentCompany.CompanyName,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.left),
                                        ),
                                        Container(
                                          width: width - 200,
                                          child: Text(
                                              this.currentCompany.Address,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.black87,
                                              ),
                                              textAlign: TextAlign.left),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25,
                                    height: 50.0 - 10.0,
                                    // width: 50.0 - 10.0,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.arrow_forward_ios_sharp),
                                        // Text(">",
                                        //     overflow: TextOverflow.ellipsis,
                                        //     style: TextStyle(
                                        //       color: Colors.black87,
                                        //     ),
                                        //     textAlign: TextAlign.center),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Text(
                                    'Chọn công ty ...',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      // fontSize: 15,
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: SizedBox(),
                                  ),
                                  Icon(Icons.arrow_forward_ios_sharp),
                                ],
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: double.infinity, // match_parent
                    child: RaisedButton(
                      color: (this.currentCompany != null &&
                              this.currentCompany.id != null &&
                              this.currentCompany.id != "")
                          ? Theme.of(context).primaryColor
                          : Colors.grey.shade400,
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(12),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(12)),
                      child: Text(
                        'Tiếp tục',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () async {
                        if (this.currentCompany != null &&
                            this.currentCompany.id != null &&
                            this.currentCompany.id != "") {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          String jsonCompany = jsonEncode(this.currentCompany);
                          await prefs.setString('company', jsonCompany);
                          authBloc.add(AppLoaded());
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showError(String error) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(error),
      backgroundColor: Theme.of(context).errorColor,
    ));
  }

  Widget _companyCard(M3400CompanyModel company, index) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop(company);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: ClipRRect(
          child: Stack(
            children: <Widget>[
              Container(
                // height: 125,
                width: width,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.black26),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Row(
                      children: [
                        SizedBox(
                          height: 100.0 - 30.0,
                          width: 100.0 - 30.0,
                          child: CircleAvatar(
                            backgroundImage: (company != null &&
                                    company.Image != null &&
                                    company.Image != "")
                                ? NetworkImage(company.Image)
                                : AssetImage(
                                    "assets/images/itime/20943476.png"),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: SizedBox(
                            width: 15,
                          ),
                        ),
                        SizedBox(
                          width: width - 110,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: width - 30,
                                child: Text(company.CompanyName,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left),
                              ),
                              Container(
                                width: width - 30,
                                child: Text(company.Address,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black87,
                                    ),
                                    textAlign: TextAlign.left),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
