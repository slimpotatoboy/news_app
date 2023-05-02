import 'package:flutter/material.dart';
import 'package:news_app/api/news_api.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  // api bata aako news haru store garcha in array
  List allNews = [];

  @override
  void initState() {
    super.initState();
    newsApiCall();
  }

  void newsApiCall() async {
    // getting response from api
    var res = await NewsApi().getAllNews();
    // if res is not null
    if (res != null) {
      setState(() {
        allNews = res.articles;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News App"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: allNews.isNotEmpty
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: allNews.length, //value :11807
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (allNews[index].urlToImage != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                allNews[index].urlToImage,
                                width: 150,
                              ),
                            ),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  allNews[index].title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text("By Dipen"),
                                Text("Published At: 2023-04-06"),
                                Text("Published By: dipenmaharjan.com.np"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  })
              : Container(),
        ),
      ),
    );
  }
}
