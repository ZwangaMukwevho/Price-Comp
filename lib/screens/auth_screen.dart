import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../models/http_exception.dart';
import 'package:intl/intl.dart';
import '../providers/users.dart';
import '../providers/user.dart';

// Enum that changes to signup or login based on the mode that was chosen
enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  // RouteName for the authentication screen
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      // Used a stack widget because it allowx objects to be layed ontop of each other
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
                      transform: Matrix4.rotationZ(-8 * pi / 180)
                        ..translate(-10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange.shade900,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Text(
                        'Welcome',
                        style: TextStyle(
                          color: Theme.of(context).accentTextTheme.title.color,
                          fontSize: 50,
                          fontFamily: 'Anton',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  DateTime _selectedDate;
  final dateController = TextEditingController();
  var dateOfBirth = "";

  // Stores the email and password of user when state is saved
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;

  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  // Dialog that is shown if there is an error during authentication
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
          title: Text('An error occrred!'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ]),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();

    if (this.mounted) {
            setState(
              () {
                 _isLoading = true;
              },
            );
          }
    // setState(() {
    //   _isLoading = true;
    // });

    // Checking for errors when signing up or logging in
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false)
            .login(_authData['email'], _authData['password']);
      } else {
        
        await Provider.of<Auth>(context, listen: false).signup(
          _authData['email'],
          _authData['password'],);
        await Provider.of<Auth>(context,listen: false).addUser( new User(
            name: _nameController.text,
            surname: _surnameController.text,
            phoneNumber: _phoneNumberController.text,
            dateOfBirth: dateOfBirth,
            email: _authData['email']),
        );
      
      }
    }
    // Errors from validation of data
    on HttpException catch (error) {
      var errorMessage = 'Authentication failed';

      // Different cases of messages
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'Email address is already in use';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'The email address is invalid';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'The password is too weak';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'The email entered has no associated user';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'The password does not match this E-mail';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    if (this.mounted) {
            setState(
              () {
                 _isLoading = false;
              },
            );
          }
    // setState(() {
    //   _isLoading = false;
    // });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  // Function that shows the calender on choosing date of birth
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      // Rebuilds the UI and sets the date once the user picks date on calender
      setState(() {
        _selectedDate = pickedDate;
        dateOfBirth = DateFormat.yMd().format(_selectedDate);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.Signup ? 380 : 260,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 660 : 260),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'Confirm Password'),

                    // Masks the password to hide it for when the user is entering the password
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                          }
                        : null,
                  ),

                // Text fied that gets users first name
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'First Name'),
                    controller: _nameController,
                  ),

                // Text field that gets users surname
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'Last Name'),
                    controller: _surnameController,
                  ),

                // Text field that gets users date of birth
                if (_authMode == AuthMode.Signup)
                  TextField(
                      controller: TextEditingController(
                        text: dateOfBirth,
                      ),
                      // //controller: DateFormat.yMd().format(_selectedDate),
                      enabled: _authMode == AuthMode.Signup,
                      decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        hintText: 'Optional',
                      ),
                      onTap: () {
                        _presentDatePicker();
                      }),

                // Textfield that gets users phone number
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      hintText: 'e.g 0123456789',
                    ),
                    controller: _phoneNumberController,
                    // ignore: missing_return
                    validator: (value) {
                      if (value.length < 10) {
                        return 'Phone number is too short!';
                      } else if (!(value.startsWith('0'))) {
                        return 'Phone number does not start with 0';
                      } else {
                        return null;
                      }
                    },
                  ),

                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  RaisedButton(
                    child:
                        Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                    onPressed: _submit,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryTextTheme.button.color,
                  ),
                FlatButton(
                  // Button that switches between signup and login based on the authentication mode
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
