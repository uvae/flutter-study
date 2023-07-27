import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webtoon/models/webtoon_detail.dart';
import 'package:webtoon/models/webtoon_episode.dart';
import 'package:webtoon/services/api.dart';
import 'package:webtoon/widgets/episode_item.dart';

class DeatilScreen extends StatefulWidget {
  final String id, title, thumb;
  const DeatilScreen({
    super.key,
    required this.id,
    required this.title,
    required this.thumb,
  });

  @override
  State<DeatilScreen> createState() => _DeatilScreenState();
}

class _DeatilScreenState extends State<DeatilScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;
  late SharedPreferences pref;
  bool isLiked = false;

  Future initPrefs() async {
    pref = await SharedPreferences.getInstance();
    final likes = pref.getStringList('likes');
    if (likes == null) return await pref.setStringList('likes', []);
    if (likes.contains(widget.id)) isLiked = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    webtoon = APIService.getToonDetailById(widget.id);
    episodes = APIService.getEpisodeListById(widget.id);
    initPrefs();
  }

  void onLikeTap() async {
    final likes = pref.getStringList('likes');
    isLiked ? likes!.remove(widget.id) : likes!.add(widget.id);

    await pref.setStringList('likes', likes);
    isLiked = !isLiked;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: onLikeTap,
            icon: isLiked
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border),
          ),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.id,
                    child: Container(
                      width: 256,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                            color: Colors.black.withOpacity(0.25),
                          )
                        ],
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(widget.thumb),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              FutureBuilder(
                future: webtoon,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text('...');
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data!.about,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text('${snapshot.data!.genre} / ${snapshot.data!.age}'),
                    ],
                  );
                },
              ),
              const SizedBox(height: 32),
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text('...');
                  return Column(
                    children: [
                      for (var item in snapshot.data!)
                        WebtoonEpisodeItem(webtoon_id: widget.id, item: item)
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
