import 'package:cleanpractice/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class NumberTriviaModel extends NumberTrivia {
  NumberTriviaModel({
    @required String text,
    @required int number,
  }) : super(number: number, text: text);

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(
      number: (json['number'] as num).toInt(),
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'text':text,
      'number':number
    };
}

}