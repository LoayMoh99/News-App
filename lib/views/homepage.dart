import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app_api/helper/data.dart';
import 'package:news_app_api/helper/widgets.dart';
import 'package:news_app_api/models/categorie_model.dart';
import 'package:news_app_api/views/categorie_news.dart';
import '../helper/news.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading;
  var newslist;

  List<CategorieModel> categories = List<CategorieModel>();

  void getNews() async {
    News news = News();
    await news.getNews(context);
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loading = true;
    super.initState();

    categories = getCategories();
    getNews();
  }

  //for provider
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    categories = getCategories();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: SafeArea(
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      /// Categories
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 70,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return CategoryCard(
                                imageAssetUrl: categories[index].imageAssetUrl,
                                categoryName: categories[index].categorieName,
                              );
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Divider(
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "All The ",
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "News 📰",
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            )
                          ],
                        ),
                      ),

                      /// News Article
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: ListView.builder(
                            itemCount: newslist.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return NewsTile(
                                imgUrl: newslist[index].urlToImage ?? "",
                                title: newslist[index].title ?? "",
                                desc: newslist[index].description ?? "",
                                content: newslist[index].content ?? "",
                                posturl: newslist[index].articleUrl ?? "",
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imageAssetUrl, categoryName;

  CategoryCard({this.imageAssetUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(
                      newsCategory: categoryName.toLowerCase(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 14),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: imageAssetUrl,
                height: 60,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black26),
              child: Padding(
                padding: EdgeInsets.only(bottom: 6.0),
                child: Text(
                  categoryName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
