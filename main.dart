import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:query_loader_app/models/content.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:query_loader_app/pages/webViewer.dart';



void main() {
  runApp(MaterialApp(
    home: QueryLoader(),
  ));
}

class QueryLoader extends StatefulWidget {
  @override
  _QueryLoaderState createState() => _QueryLoaderState();
}

class _QueryLoaderState extends State<QueryLoader> {


  TextEditingController _controller = TextEditingController();
  StreamController<BaseModel> _streamController;
  Stream _stream;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController();
    _stream = _streamController.stream;

  }

  _search() async {

    if(_controller.text.isNotEmpty) {
      String query = _controller.text;
      Uri _url = Uri.parse('https://newsapi.org/v2/everything?q=$query&apiKey=04dd734da5984237b03ef87a522c7269');
      Response response = await get(_url);
      _streamController.add(BaseModel.fromJson(jsonDecode(response.body)));
    } else {
      _streamController.add(null);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 12, bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextFormField(
                    onChanged: (String text) {},
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      contentPadding: const EdgeInsets.only(left: 24),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  _search();
                },
              ),
            ],
          ),
        ),
        title: Text(
          'News',
        ),
      ),
      body: StreamBuilder<BaseModel>(
        stream: _stream,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                BaseModel model = snapshot.data;
                Content content = model.articles[index];
                return GestureDetector(
                  onTap: () {
                    setState((){
                      String url = content.url;
                      String author = content.author;
                      Route route = MaterialPageRoute(builder: (context) => WebViewer(url: url, author: author,));
                      Navigator.push(context, route);
                    });
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(content.title),
                      subtitle: Text(content.author),
                      leading: Image.network(content.image),
                    ),
                  ),
                );
              },
              itemCount: snapshot.data.articles.length,
            );
          } else {
            return Center(
              child: Text('Enter a search word'),
            );
          }
        },
      ),
    );
  }

}

