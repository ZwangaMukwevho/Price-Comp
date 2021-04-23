import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'user.dart';

class Users with ChangeNotifier {
  // Token property and UserId
  final String authToken;
  final String userId;

  // Constructor that gets authToken and UserId
  Users(this.authToken, this.userId);

  // User that has logged in
  User _loggedInUser;

  // Getter that gets user that has logged in
  User get user {
    return _loggedInUser;
  }

  List<User> _userList = [];
  List<User> get userList => _userList;

  // Fetches the user from the database
  Future<void> fetchAndSetUsers() async {
    final url = 'https://shoppingappflutter-9c12b.firebaseio.com/users.json?auth=$authToken&orderBy="userId"&equalTo="$userId"';
    
    // 'https://shoppingappflutter-9c12b.firebaseio.com/users.json?auth=$authToken&orderBy="userId"&equalTo=$userId'
    // Using a try and getch to fetch the words
    try {
      final response = await http.get(url);
     
      //Decoding the JSON responce
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
     
      if (extractedData == null) {
        return;
      }
      final List<User> extractedUser = [];
      extractedData.forEach(
        (userKey, userData) {
          extractedUser.add(User(
            name: userData['name'],
            surname: userData['surname'],
            phoneNumber: userData['phoneNumber'],
            dateOfBirth: userData['dateOfBirth'],
            userId: userData['userId'],
          ));
        },
      );
      
      
      _loggedInUser = extractedUser[0];
      _userList = extractedUser;
      
      notifyListeners();

    } catch (error) {
      throw (error);
    }
  }

  // Method that adds a new user to the database
  Future<void> addUser(User user) {
    // URL that accesses users from the database
    final url =
        'https://shoppingappflutter-9c12b.firebaseio.com/users.json?auth=$authToken';

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
      //_users.add(newUser);
      _loggedInUser = newUser;
      notifyListeners();
      
    }).catchError((error) {
      throw error;
    });
  }

  // Method that updates the user at the database
  Future<void> updateUser(String id, User newUser) async {
    // final userIndex = _users.indexWhere((user) => user.userId == id);
    if (id == userId ) {
      // Url that goes to specific user on database
      final url =
          'https://shoppingappflutter-9c12b.firebaseio.com/users/$id.json?auth=$authToken';

      await http.patch(
        url,
        body: json.encode({
          'name': newUser.name,
          'surname': newUser.surname,
          'email': newUser.email,
          'dateOfBirth': newUser.dateOfBirth,
          'phoneNumber': newUser.phoneNumber,
        }),
      );
      _loggedInUser = newUser;
      notifyListeners();
    } else {}
  }
}
