import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/webtoon_episode.dart';

class WebtoonEpisodeItem extends StatelessWidget {
  final String webtoon_id;
  final WebtoonEpisodeModel item;
  const WebtoonEpisodeItem({
    super.key,
    required this.item,
    required this.webtoon_id,
  });

  void onButtonTap() async {
    await launchUrlString(
        'https://comic.naver.com/webtoon/detail?titleId=$webtoon_id&no=${item.id}');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
