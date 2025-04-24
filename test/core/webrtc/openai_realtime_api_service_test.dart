import 'package:dream_catcher/core/webrtc/openai_realtime_api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
import 'openai_realtime_api_service_test.mocks.dart';

void main() {
  late OpenAIRealtimeApiService apiService;
  late MockClient mockHttpClient;

  const testApiKey = 'test-api-key';
  const testModel = 'test-model';
  const testSdp = 'test-sdp-data';

  setUp(() {
    mockHttpClient = MockClient();
    apiService = OpenAIRealtimeApiService(
      apiKey: testApiKey,
      model: testModel,
      httpClient: mockHttpClient,
    );
  });

  tearDown(() {
    apiService.dispose();
  });

  group('OpenAIRealtimeApiService WebRTC 연결 테스트', () {
    test('연결 요청 성공', () async {
      when(
        mockHttpClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          'test-response-sdp',
          200,
        ),
      );

      final response = await apiService.initiateWebRtcConnection(
        sdp: testSdp,
      );

      verify(
        mockHttpClient.post(
          any,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $testApiKey',
          },
          body: testSdp,
        ),
      ).called(1);

      expect(response.sdp, 'test-response-sdp');
      expect(response.type, 'answer');
    });

    test('연결 요청 실패 - 서버 오류', () async {
      when(
        mockHttpClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          '{"error": "서버 오류"}',
          500,
        ),
      );

      expect(
        () => apiService.initiateWebRtcConnection(sdp: testSdp),
        throwsException,
      );
    });

    test('연결 요청 실패 - 네트워크 오류', () async {
      when(
        mockHttpClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenThrow(Exception('네트워크 오류'));

      expect(
        () => apiService.initiateWebRtcConnection(sdp: testSdp),
        throwsException,
      );
    });
  });

  test('자원 해제 테스트', () {
    apiService.dispose();
    verify(mockHttpClient.close()).called(1);
  });
}
