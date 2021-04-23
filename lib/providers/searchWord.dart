import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchWord with ChangeNotifier{

  // Token property and UserId
  final String authToken;
  final String userId;

  SearchWord(this.authToken,this.userId);

  List<String> _searchList = [];
  List<String> get searchList => _searchList;


  // Method that adds word to newList
  Future<void> addWord(String word){

    if(_searchList.contains(word)){
      return null;
    }
    else{
    //Url used to store the word
    final url = 'https://shoppingappflutter-9c12b.firebaseio.com/searchedWords.json?auth=$authToken';
    return http.post(
      url,
      body: json.encode({
        'searchWord':word,
        'userId':userId,
      }),
    ).then((response){

      _searchList.insert(0,word);
      notifyListeners();

    },).catchError((error){
      throw error;
    });  
    }
    

  }

  // Method to initialise and fetch products
  Future<void> fetchAndSetWords() async{

    // Url that fetches the products that are from a specifc user
    final url = 'https://shoppingappflutter-9c12b.firebaseio.com/searchedWords.json?auth=$authToken&orderBy="userId"&equalTo="$userId"';

    // Using a try and getch to fetch the words
    try{
      final response = await http.get(url);
      
      //Decoding the JSON responce
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      
      

      if(extractedData==null){
        return;
      }

      final List<String> extractedWords = [];

      // Converting the extracted data in json to the word list
      extractedData.forEach((wordId, word) {
        extractedWords.insert(0,word['searchWord']);
       });

       _searchList = extractedWords;
       notifyListeners();
    }catch(error){
      throw(error);
    }
  
  }
}