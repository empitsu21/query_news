class Content {

  String title;
  String author;
  String image;
  String url;

  Content({this.author, this.image, this.title, this.url});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      title: json['title'] == null ? '' : json['title'],
      author: json['author'] == null ? '' : json['author'],
      image: json['urlToImage'] == null ? '' : json['urlToImage'],
      url: json['url'] == null ? '' : json['url'],
    );
  }

}

class BaseModel {


  List<Content> articles;

  BaseModel({this.articles});

  factory BaseModel.fromJson(Map<String, dynamic> json) {
    var contentJson = json['articles'] as List;
    List<Content> contentList = contentJson.map((content) => Content.fromJson(content)).toList();
    return BaseModel(
      articles: contentList);
  }
}