import 'package:cleanpractice/core/utils/input_convertor.dart';
import 'package:cleanpractice/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  InputConverter inputConverter;
  setUp((){
    inputConverter=InputConverter();
  });
  group('stringToUnsignedInt', (){
    test('should return an integer when the string represent an unsigned integer', ()async{
      //arrange
      final str = '123';
      //act
      final result = inputConverter.stringToUnsignedInteger(str);
      //assert
      expect(result, Right(123));
    });
    test('should return a failure when the String is not an integer', ()async{
      //arrange
      final str = '1.02';
      //act
      final result = inputConverter.stringToUnsignedInteger(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });
    test('should return a failure when the String is negative integer', ()async{
      //arrange
      final str = '-123';
      //act
      final result = inputConverter.stringToUnsignedInteger(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });
  });
}