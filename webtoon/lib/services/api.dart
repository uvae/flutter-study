import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:webtoon/models/webtoon.dart';
import 'package:webtoon/models/webtoon_detail.dart';
import 'package:webtoon/models/webtoon_episode.dart';

class APIService {
  static const String baseUrl =
      'https://webtoon-crawler.nomadcoders.workers.dev';
  static const String today = 'today';

  static Future<List<WebtoonModel>> getTodayToonList() async {
    List<WebtoonModel> result = [];

    final url = Uri.parse('$baseUrl/$today');
    final res = await http.get(url);

    if (res.statusCode != 200) throw Error();
    for (var json in jsonDecode(res.body)) {
      result.add(WebtoonModel.fromJSON(json));
    }

    return result;
  }

  static Future<WebtoonDetailModel> getToonDetailById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final res = await http.get(url);

    if (res.statusCode != 200) throw Error();
    final webtoon = jsonDecode(res.body);
    return WebtoonDetailModel.fromJson(webtoon);
  }

  static Future<List<WebtoonEpisodeModel>> getEpisodeListById(String id) async {
    List<WebtoonEpisodeModel> result = [];

    final url = Uri.parse('$baseUrl/$id/episodes');
    final res = await http.get(url);

    if (res.statusCode != 200) throw Error();
    for (var json in jsonDecode(res.body)) {
      result.add(WebtoonEpisodeModel.fromJson(json));
    }

    return result;
  }
}
