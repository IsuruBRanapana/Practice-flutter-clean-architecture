import 'package:cleanpractice/core/errors/exceptions.dart';
import 'package:cleanpractice/core/errors/failures.dart';
import 'package:cleanpractice/core/platform/network_info.dart';
import 'package:cleanpractice/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:cleanpractice/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:cleanpractice/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:cleanpractice/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:cleanpractice/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockRemoteDataSource extends Mock implements NumberTriviaRemoteDataSource{}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource{}

class MockNetworkInfo extends Mock implements NetworkInfo{}

void main(){
  NumberTriviaRepositoryImpl repository;
  MockLocalDataSource mockLocalDataSource;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp((){
    mockRemoteDataSource=MockRemoteDataSource();
    mockLocalDataSource=MockLocalDataSource();
    mockNetworkInfo=MockNetworkInfo();
    repository=NumberTriviaRepositoryImpl(
      remoteDataSource:mockRemoteDataSource,
      localDataSource:mockLocalDataSource,
      networkInfo:mockNetworkInfo,
    );
  });

  group('getConcreteNumberTrivia', (){
    final tNumber=1;
    final tNumberTriviaModel=NumberTriviaModel(number: tNumber,text: 'test trivia');
    final NumberTrivia tNumberTrivia=tNumberTriviaModel;

    test('Should check if the device is online', ()async{
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async=>true );

      //act
      repository.getConcreteNumberTrivia(tNumber);
      //assert
      verify(mockNetworkInfo.isConnected);
    },);
    group('device is online',(){
      setUp((){
        when(mockNetworkInfo.isConnected).thenAnswer((_)async => true);
      });
      test('Should return remote data when the call to remote data source success', ()async{
        //arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(any)).thenAnswer((_) async => tNumberTriviaModel);
        //act
        final result = await repository.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
        expect(result, equals(Right(tNumberTrivia)));
      });
      test('Should cache the data locally when the call to remote data source success', ()async{
        //arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(any)).thenAnswer((_) async => tNumberTriviaModel);
        //act
        await repository.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
        verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
      });
      test('Should return server failure when the call to remote data source unsuccessful', ()async{
        //arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(any)).thenThrow(ServerException());
        //act
        final result = await repository.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });
    group('device is offline', (){
      setUp((){
        when(mockNetworkInfo.isConnected).thenAnswer((_)async => false);
      });
    });
  });
}
