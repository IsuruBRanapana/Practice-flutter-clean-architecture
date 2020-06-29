import 'dart:convert';

import 'package:cleanpractice/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:cleanpractice/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main(){
  final tNumberTriviaModel=NumberTriviaModel(number:1,text:'Test Text');
  test('Should be subclass of number trivia entity', () async{
    //assert
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group('From json', (){
    test('should return valid number when the JSON number is an integer', ()async{
      //arrange
      final Map<String,dynamic> jsonMap=json.decode(fixture('trivia.json'));

      //act
      final result = NumberTriviaModel.fromJson(jsonMap);

      //assert
      expect(result, tNumberTriviaModel);
    });
    test('should return valid number when the JSON number is regarded as double', ()async{
      //arrange
      final Map<String,dynamic> jsonMap=json.decode(fixture('trivia_double.json'));

      //act
      final result = NumberTriviaModel.fromJson(jsonMap);

      //assert
      expect(result, tNumberTriviaModel);
    });
  });

  group('To Json', (){
    test('Should return proper json map', ()async{
      //act
      final result = tNumberTriviaModel.toJson();
      //assert
      final expectedMap={
          "text":"Test Text",
          "number": 1,
      };
      expect(result, expectedMap);
    });
  });
}