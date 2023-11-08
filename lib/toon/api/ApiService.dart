import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:toonflix/toon/model/EpisodeModel.dart';
import 'package:toonflix/toon/model/WebtoonModel.dart';
class ApiService {
  static const String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";
  static const String episodes = "episodes";

  static Future<List<dynamic>> get(uri) async {
    final url = Uri.parse('$baseUrl/$uri');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Error();
  }

  static Future<List<WebtoonModel>> getWebtoons() async {
    List<dynamic> response = await ApiService.get(ApiService.today);
    List<WebtoonModel> webtoons = [];

    for (var webtoon in response) {
      webtoons.add(WebtoonModel.fromJson(webtoon));
    }

    return webtoons;
  }

  static Future<List<EpisodeModel>> getEpisodes(String id) async {
    List<dynamic> response = await ApiService.get("$id/$episodes");
    List<EpisodeModel> webtoonEpisodes = [];

    for (var episode in response) {
      webtoonEpisodes.add(EpisodeModel.fromJson(episode));
    }

    return webtoonEpisodes;
  }
}