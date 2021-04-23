import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/http_exception.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'user.dart';

class Auth with ChangeNotifier {
  // Token that will be used for endpoints that require authentication
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  // Bool that checks if user has logged in
  bool get isAuth {
    return token != null;
  }

  // Method that fetches the token when authenticated
  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  // Method that fetches the user ID
  String get userId {
    return _userId;
  }

  // Generic method used for signing up and loggin in
  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDelgcgjFozc2Qj95r9jQpdieHdafHObIQ';

    try {
      // Making a post request to send sign up with firebase
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );

      // Data obtained from http post method
      final responseData = json.decode(response.body);

      // Checking if the error message is provided in the body, that means the error was not from the network or the post
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      _token = responseData['idToken'];
      _userId = responseData['localId'];

      // Obtaining the date in which the token will expire
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );
      _autoLogout();
      notifyListeners();

      // Using shared preferences to store log in data on local memory
      final prefs = await SharedPreferences.getInstance();

      // Store user data using json format
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate.toIso8601String(),
      },
      );

      prefs.setString('userData', userData);

    } catch (error) {
      throw (error);
    }
  }


 // Method that adds a new user to the database
  Future<void> addUser(User user) {
    // URL that accesses users from the database
    final url =
        'https://shoppingappflutter-9c12b.firebaseio.com/users.json?auth=$_token';

    // Http post request that adds a user to the dataBase
    return http
        .post(
      url,
      body: json.encode({
        'name': user.name,
        'surname': user.surname,
        'email': user.email,
        'dateOfBirth': user.dateOfBirth,
        'phoneNumber': user.phoneNumber,
        'userId': userId,
      }),
    )
        .then((response) {
      // Add the user to users' list after the http request is done
      final newUser = User(
        name: user.name,
        surname: user.surname,
        email: user.email,
        dateOfBirth: user.dateOfBirth,
        phoneNumber: user.phoneNumber,
        userId: userId,
      );
     // _users.add(newUser);

      notifyListeners();
      
    }).catchError((error) {
      throw error;
    });
  }

  // Method used for signing up
  Future<void> signup(String email, String password) async {    
    return _authenticate(email, password, 'signUp');
  }

  // Method used for signing in
  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  // Method to retrieve data from sharedPrefences
  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Checking if the sharedPreferences has data stored in it
    if(!prefs.containsKey('userData')){
      return false;
    }

    // If shared preferences has user data we fetch the data
    final extractedUserData = json.decode(prefs.getString('userData')) as Map<String, Object>;

    // Checking if token has expired
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
    if(expiryDate.isBefore(DateTime.now())){
      return false;
    }

    // If the token has not expired re-login the user
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();

    // Restart the timer for autologout
    _autoLogout();

    return true;

  }

  // Method for logging out
  Future<void> logout() async{
    _token = null;
    _userId = null;
    _expiryDate = null;

    // Cancelling timer when timer logs out
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }

    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    prefs.clear();
  }

  // Method that autologouts the user after a while
  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    // User timer to set when user should automatically be logged out
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
