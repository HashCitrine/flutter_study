import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toonflix/toon/api/ApiService.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../model/EpisodeModel.dart';

class Detail extends StatefulWidget {
  final String id, title, thumb;

  const Detail(
      {super.key, required this.id, required this.title, required this.thumb});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  late Future<List<EpisodeModel>> episodes;
  late SharedPreferences preferences;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    episodes = ApiService.getEpisodes(widget.id);
    initPreferences();
  }

  onButtonTap(String url) async {
    await launchUrlString(url);
  }

  Future initPreferences() async {
    preferences = await SharedPreferences.getInstance();
    final liked = preferences.getStringList('liked');

    if (liked == null) {
      await preferences.setStringList('liked', []);
    } else {
      if (liked.contains(widget.id)) {
        setState(() {
          isLiked = true;
        });
      }
    }
  }

  onLikeTap() async {
    final liked = preferences.getStringList('liked');
    if (liked != null) {
      if (isLiked) {
        liked.remove(widget.id);
      } else {
        liked.add(widget.id);
      }
    }

    setState(() {
      isLiked = !isLiked;
    });

    await preferences.setStringList('liked', liked!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.white,
          foregroundColor: Colors.green,
          actions: [
            IconButton(
              onPressed: onLikeTap,
              icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_outline_outlined),
            ),
          ],
          title: Text(
            widget.title,
            style: const TextStyle(fontSize: 24),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: widget.id,
                  child: Container(
                    width: 250,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15,
                            offset: const Offset(10, 10),
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ]),
                    child: Image.network(
                      widget.thumb,
                      headers: const {
                        "User-Agent":
                            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.title,
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
              future: episodes,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  /*return Column(
                    children: [
                      for (var episode in snapshot.data!) Text(episode.title)
                    ],
                  );*/
                  return Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.length,
                      padding: const EdgeInsets.all(20),
                      itemBuilder: (context, index) {
                        var episode = snapshot.data![index];
                        return GestureDetector(
                          onTap: () => onButtonTap(
                              "https://comic.naver.com/webtoon/detail?titleId=${widget.id}&no=${episode.id}"),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.green.shade300,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 15,
                                    offset: const Offset(10, 10),
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    episode.title,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                  const Icon(
                                    Icons.chevron_right_rounded,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 40,
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ));
  }
}
