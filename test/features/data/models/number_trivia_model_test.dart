import 'package:cleanpractice/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:cleanpractice/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  final tNumberTriviaModel=NumberTriviaModel(number:1,text:'Test Text');
  test('Should be subclass of number trivia entity', () async{
    //assert
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });
}