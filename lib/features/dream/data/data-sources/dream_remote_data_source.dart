import 'dart:convert';

import 'package:dream_catcher/core/error/exception.dart';
import 'package:dream_catcher/features/dream/data/data-sources/dream_data_source.dart';
import 'package:dream_catcher/features/dream/data/models/dream_detail_model.dart';
import 'package:dream_catcher/features/dream/data/models/dream_list_model.dart';
import 'package:http/http.dart' as http;

class DreamRemoteDataSource implements DreamDataSource {
  final http.Client _client;
  final String _baseUrl;
  final DreamListModelFactory _dreamListModelFactory;
  final DreamDetailModelFactory _dreamDetailModelFactory;

  DreamRemoteDataSource({
    required http.Client client,
    required String baseUrl,
    required DreamListModelFactory dreamListModelFactory,
    required DreamDetailModelFactory dreamDetailModelFactory,
  })  : _baseUrl = baseUrl,
        _client = client,
        _dreamDetailModelFactory = dreamDetailModelFactory,
        _dreamListModelFactory = dreamListModelFactory;

  // 인증 토큰을 포함한 헤더 생성 메서드
  Map<String, String> _headers() {
    // TODO: 토큰 저장소에서 토큰 가져오기
    final token = 'test_token';
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  @override
  Future<void> deleteDream(String dreamId) async {
    final response = await _client.delete(
      Uri.parse('$_baseUrl/v1/dreams/$dreamId'),
      headers: _headers(),
    );

    if (response.statusCode != 200) {
      throw ServerException('꿈 삭제 실패: ${response.body}');
    }
  }

  @override
  Future<DreamListModel> filterDreamsByDate(
      DateTime startDate, DateTime endDate) async {
    final formattedStartDate = startDate.toIso8601String();
    final formattedEndDate = endDate.toIso8601String();

    final response = await _client.get(
      Uri.parse(
          '$_baseUrl/v1/dreams?startDate=$formattedStartDate&endDate=$formattedEndDate'),
      headers: _headers(),
    );

    if (response.statusCode == 200) {
      return _dreamListModelFactory.fromJson(json.decode(response.body));
    } else {
      throw ServerException('날짜별 꿈 필터링 실패: ${response.body}');
    }
  }

  @override
  Future<DreamListModel> filterDreamsByMood(String mood) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/v1/dreams?mood=$mood'),
      headers: _headers(),
    );

    if (response.statusCode == 200) {
      return _dreamListModelFactory.fromJson(json.decode(response.body));
    } else {
      throw ServerException('기분별 꿈 필터링 실패: ${response.body}');
    }
  }

  @override
  Future<DreamDetailModel> getDream(String dreamId) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/v1/dreams/$dreamId'),
      headers: _headers(),
    );

    if (response.statusCode == 200) {
      return _dreamDetailModelFactory
          .fromJson(json.decode(response.body)['data']);
    } else {
      throw ServerException('꿈 상세 조회 실패: ${response.body}');
    }
  }

  @override
  Future<DreamListModel> getDreams() async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/v1/dreams'),
      headers: _headers(),
    );

    if (response.statusCode == 200) {
      return _dreamListModelFactory
          .fromJson(json.decode(response.body)['data']);
    } else {
      throw ServerException('꿈 목록 조회 실패: ${response.body}');
    }
  }

  @override
  Future<void> saveDream(DreamDetailModel dream) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/v1/dreams'),
      headers: _headers(),
      body: json.encode(dream.toJson()),
    );

    if (response.statusCode != 201) {
      throw ServerException('꿈 저장 실패: ${response.body}');
    }
  }

  @override
  Future<DreamListModel> searchDreams(String query) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/v1/dreams?keyword=$query'),
      headers: _headers(),
    );

    if (response.statusCode == 200) {
      return _dreamListModelFactory
          .fromJson(json.decode(response.body)["data"]);
    } else {
      throw ServerException('꿈 검색 실패: ${response.body}');
    }
  }

  @override
  Future<void> updateDream(DreamDetailModel dream) async {
    final response = await _client.put(
      Uri.parse('$_baseUrl/v1/dreams/${dream.id}'),
      headers: _headers(),
      body: json.encode(dream.toJson()),
    );

    if (response.statusCode != 200) {
      throw ServerException('꿈 수정 실패: ${response.body}');
    }
  }

  // 추가: 컨트롤러에 있는 꿈 분석 기능
  Future<DreamDetailModel> analyzeDream(String dreamId) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/v1/dreams/$dreamId/analyze'),
      headers: _headers(),
    );

    if (response.statusCode == 200) {
      return _dreamDetailModelFactory.fromJson(json.decode(response.body));
    } else {
      throw ServerException('꿈 분석 실패: ${response.body}');
    }
  }
}
