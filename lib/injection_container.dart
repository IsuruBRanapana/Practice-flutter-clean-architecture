import 'package:cleanpractice/core/network/network_info.dart';
import 'package:cleanpractice/core/utils/input_convertor.dart';
import 'package:cleanpractice/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:cleanpractice/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:cleanpractice/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:cleanpractice/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:cleanpractice/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:cleanpractice/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:cleanpractice/features/number_trivia/presentation/bloc/bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async{
  ///features
  //bloc
  sl.registerFactory(
    () => NumberTriviaBloc(
      concrete: sl(),
      random: sl(),
      inputConverter: sl(),
    ),
  );

  //use cases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  //repository
  sl.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  ///Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      sl(),
    ),
  );

  ///external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
