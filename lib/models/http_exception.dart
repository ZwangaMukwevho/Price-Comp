
class HttpException implements Exception{
// When impementing abstract classes in flutter you must implement all methods in the abstract class
// N.B Every class in flutter has a toString method

  final String message;

  HttpException(this.message);

// Overriding the toString method to return message
@override 
String toString(){
  return message;
}
}