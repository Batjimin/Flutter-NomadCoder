import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoonapp/models/webtoon_detail_model.dart';
import 'package:webtoonapp/models/webtoon_episode_model.dart';
import 'package:webtoonapp/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      'https://webtoon-crawler.nomadcoders.workers.dev';
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        final instance = WebtoonModel.fromJson(webtoon);
        webtoonInstances.add(instance);
      }
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse("$baseUrl/$id"); //url생성.
    final response = await http.get(url); //URL로 request전송.
    if (response.statusCode == 200) {
      //request성공적인지 확인.
      final webtoon = jsonDecode(response.body); //response.body 받아 json으로 전환.
      return WebtoonDetailModel.fromJson(webtoon); //json constructor로 전달.
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    List<WebtoonEpisodeModel> episodesInstances = []; //episode를 받아오기 위한 List생성
    final url = Uri.parse("$baseUrl/$id/episodes"); //url생성.
    final response = await http.get(url); //URL로 request전송.
    if (response.statusCode == 200) {
      //request성공적인지 확인.
      final episodes = jsonDecode(response.body); //response.body 받아 json으로 전환.
      for (var episode in episodes) {
        WebtoonEpisodeModel.fromJson(episode);
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  }
}
