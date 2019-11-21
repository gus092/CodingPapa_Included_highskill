import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RandomListState();
}

class _RandomListState extends State<RandomList> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>(); // 동일한 값의 object가 들어갈 수 없음.

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("naming app"),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return ListView.builder(itemBuilder: (context, index) {
      //context 앱의 현재 상황
      // 0, 2, 4, 6, 8 = real item
      //1, 3, 5, 7, 9 = divieders
      if (index.isOdd) {
        return Divider();
      }
      var realIndex = index ~/ 2; //index를 2로 나눈 몫을 가리킴

      if (realIndex >= _suggestions.length) {
        _suggestions.addAll(
            generateWordPairs().take(10)); //suggestions의 단어 10개를 가져와서 넣어줘라

      }

      return _buildRow(
          _suggestions[realIndex]); //_suggetsions[realIndex]에는 random 단어가 들어있음
    });
  }

  Widget _buildRow(WordPair pair) {
    //pair로 단어 자체를 받음
    final bool alreadySaved = _saved.contains(pair); //_saved안에 pair라는 단어가 있는지 없는지에 따라 bool 값이 들어가 있음
     return ListTile(
      title: Text(pair.asPascalCase, textScaleFactor: 2),
      trailing: Icon(
       alreadySaved? Icons.favorite : Icons.favorite_border,
        color: Colors.pinkAccent,
      ),
      onTap: (){
        setState(() { //stateful 위젯안의 state를 다시 재실행.update
          if (alreadySaved)
            _saved.remove(pair);//true이면
          else
            _saved.add(pair); //false인경우
        });
      },
    );
  }
}
