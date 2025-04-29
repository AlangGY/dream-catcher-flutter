import 'dart:convert';

import 'package:dream_catcher/core/error/exception.dart';
import 'package:dream_catcher/features/dream/data/data-sources/dream_interview_data_source.dart';
import 'package:dream_catcher/features/dream/data/models/dream_interview_model.dart';
import 'package:dream_catcher/features/dream/domain/entities/dream_interview.dart';
import 'package:http/http.dart' as http;

class DreamInterviewRemoteDataSource implements DreamInterviewDataSource {
  final http.Client _client;
  final String _baseUrl;
  final DreamInterviewModelFactory _dreamInterviewModelFactory;

  DreamInterviewRemoteDataSource({
    required http.Client client,
    required String baseUrl,
    required DreamInterviewModelFactory dreamInterviewModelFactory,
  })  : _client = client,
        _baseUrl = baseUrl,
        _dreamInterviewModelFactory = dreamInterviewModelFactory;

  Map<String, String> _headers() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  @override
  Future<DreamInterviewModel> startInterview() async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/v1/dream-interview/start'),
      headers: _headers(),
    );

    if (response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      return _dreamInterviewModelFactory.fromJson(jsonResponse['data']);
    } else {
      throw ServerException('인터뷰 시작 실패: ${response.body}');
    }
  }

  @override
  Future<DreamInterviewModel> answerMessage(
    String interviewId,
    SpeakerType speakerType,
    String content,
  ) async {
    final speaker = speakerType == SpeakerType.me ? 'USER' : 'AI';

    final response = await _client.post(
      Uri.parse('$_baseUrl/v1/dream-interview/answer'),
      headers: _headers(),
      body: json.encode({
        'interviewId': interviewId,
        'speaker': speaker,
        'message': content,
      }),
    );

    if (response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      return _dreamInterviewModelFactory.fromJson(jsonResponse['data']);
    } else {
      throw ServerException('인터뷰 메시지 추가 실패: ${response.body}');
    }
  }

  @override
  Future<void> completeInterview(String interviewId) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/v1/dream-interview/end'),
      headers: _headers(),
      body: json.encode({
        'interviewId': interviewId,
      }),
    );

    if (response.statusCode != 201) {
      throw ServerException('인터뷰 완료 실패: ${response.body}');
    }
  }

  @override
  Future<DreamInterviewModel> getCurrentInterview(String interviewId) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/v1/dream-interview/$interviewId'),
      headers: _headers(),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return _dreamInterviewModelFactory.fromJson(jsonResponse['data']);
    } else {
      throw ServerException('현재 인터뷰 조회 실패: ${response.body}');
    }
  }

  @override
  Future<String> convertVoiceToText(List<int> audioData) async {
    // TODO: 음성-텍스트 변환 API 구현 필요
    throw UnimplementedError();
  }
}
