import 'package:cleanpractice/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource{
  ///Gets the cached [NumberTriviaModel] which was gotten last time
  ///the user had an internet connection
  ///
  /// Throws [CachedException] if no cached data is present
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}