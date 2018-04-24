import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    //final wordPair = new RandomWords();
    return new MaterialApp(
      title: 'Welcome',
      theme: new ThemeData(
        primaryColor: Colors.red
      ),
      home: new RandomWords(),
      // home: new Scaffold(
      //   appBar: new AppBar(
      //     title: new Text('Startup New Generator'),
      //   ),
      //   body: new Center(
      //     //child: new Text('Hello Worlds'),
      //     //child: new RandomWords(),
      //     child: new RandomWords(),
      //   ),
      // ),
    );
  }
}


class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords>{

  final _sugestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = new Set<WordPair>();

  void _pushSaved(){
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context){
          final tiles = _saved.map((pair){
            return new ListTile(
              title: new Text(
                pair.asCamelCase,
                style: _biggerFont,
              ),
            );
          });

        final devided = ListTile.divideTiles(
          context: context,
          tiles: tiles
        ).toList();

         return new Scaffold(
          appBar: new AppBar(
            title: new Text('Saved Suggestions'),
          ),
          body: new ListView(children: devided),
        );

        }
      )
    );
  }

  void _pushHome(){}

  @override
  Widget build(BuildContext context){
    //final wordPair = new WordPair.random();
    //return new Text(wordPair.asCamelCase);
    //return _buildSuggestions();

    return new Scaffold(
      appBar: new AppBar(
          title: new Text('List Words'),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.list),
              onPressed: _pushSaved),
              new IconButton(
                icon: new Icon(Icons.linked_camera),
                onPressed: _pushHome
              )
          ],

      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions(){
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context,i){

        // Add a one-pixel-high divider widget before each row in theListView.
        if(i.isOdd) return new Divider();
         // The syntax "i ~/ 2" divides i by 2 and returns an integer result.
        // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
        // This calculates the actual number of word pairings in the ListView,
        // minus the divider widgets.
        final index = i ~/ 2;
        if(index >= _sugestions.length){
          _sugestions.addAll(generateWordPairs().take(10));
        }

        return _builRow(_sugestions[index]);
      },

    );
  }
  Widget _builRow(WordPair pair){
    final _alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asCamelCase,
        style: _biggerFont),
      trailing: new Icon(
        _alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: _alreadySaved ? Colors.red : null
      ),
      onTap: (){
        setState((){
          _alreadySaved ? _saved.remove(pair):_saved.add(pair);
        });
      },
    );
  }

}