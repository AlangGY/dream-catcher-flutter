import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dream_catcher/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks(
    [MockSpec<Connectivity>(), MockSpec<InternetConnectionChecker>()])
import 'network_info_test.mocks.dart';

void main() {
  late NetworkInfoImpl networkInfo;
  late MockConnectivity mockConnectivity;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockConnectivity = MockConnectivity();
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(
        connectivity: mockConnectivity,
        internetConnectionChecker: mockInternetConnectionChecker);
  });

  group('isConnected', () {
    test(
      '인터넷 연결이 있을 경우, true를 반환한다.',
      () async {
        // arrange
        when(mockConnectivity.checkConnectivity())
            .thenAnswer((_) async => Future.value([
                  ConnectivityResult.mobile,
                  ConnectivityResult.wifi,
                  ConnectivityResult.ethernet,
                ]));
        when(mockInternetConnectionChecker.hasConnection)
            .thenAnswer((_) async => true);
        // act
        final result = await networkInfo.isConnected;
        // assert
        verify(mockConnectivity.checkConnectivity());
        verify(mockInternetConnectionChecker.hasConnection);
        expect(result, true);
      },
    );

    test(
      '와이파이 연결은 되어있지만 실제 인터넷 핑은 실패할 경우, false를 반환한다.',
      () async {
        // arrange
        when(mockConnectivity.checkConnectivity())
            .thenAnswer((_) async => Future.value([
                  ConnectivityResult.wifi,
                ]));
        when(mockInternetConnectionChecker.hasConnection)
            .thenAnswer((_) async => false);
        // act
        final result = await networkInfo.isConnected;
        // assert
        verify(mockConnectivity.checkConnectivity());
        verify(mockInternetConnectionChecker.hasConnection);
        expect(result, false);
      },
    );

    test(
      '인터넷 연결이 없을 경우, false를 반환한다.',
      () async {
        // arrange
        when(mockConnectivity.checkConnectivity())
            .thenAnswer((_) async => Future.value([
                  ConnectivityResult.none,
                ]));
        // act
        final result = await networkInfo.isConnected;
        // assert
        verify(mockConnectivity.checkConnectivity());
        verifyZeroInteractions(mockInternetConnectionChecker);
        expect(result, false);
      },
    );
  });
}
