import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/toon/api/ApiService.dart';
import 'package:flutter_study/toon/model/WebtoonModel.dart';
import 'package:flutter_study/toon/widgets/Detail.dart';
import 'package:flutter_study/toon/widgets/WebtoonCard.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool isLoading = false;

  Future<List<WebtoonModel>> webtoons = ApiService.getWebtoons();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 2,
            backgroundColor: Colors.white,
            foregroundColor: Colors.green,
            title: const Text(
              "오늘의 웹툰",
              style: TextStyle(fontSize: 24),
            ),
          ),
          body: FutureBuilder(
            future: webtoons,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Expanded(child: makeList(snapshot)),
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(), // Loading 표시
              );
            },
          )),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.length,
      padding: EdgeInsets.all(20),
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return WebtoonCard(id: webtoon.id, title: webtoon.title, thumb: webtoon.thumb);
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
    );
  }
}
