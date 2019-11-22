import 'package:codingpapa_including_highskill/src/bloc/Bloc.dart';
import 'package:codingpapa_including_highskill/src/saved.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RandomListState();
}

class _RandomListState extends State<RandomList> {
  final List<WordPair> _suggestions = <WordPair>[];
  //final Set<WordPair> _saved = Set<WordPair>(); // 동일한 값의 object가 들어갈 수 없음.


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("naming app"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: (){

              Navigator.of (context).push( //페이지 전환 Navigator object사용
                MaterialPageRoute(builder:  (context) => SavedList()) //_saved를 받아서 SavedList의 saved에 바로 넣어줌
                //**Data를 보내는게 아니라reference를 보내서 savedlist에서 수정해도 같이 수정됨
              );
            },
          )
        ]
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return StreamBuilder<Set<WordPair>>(
      stream: bloc.savedStream,
      builder: (context, snapshot) { //snapshot : data가 변경될때마다 절달되는 data
        //snapshot이 올때마다 refresh
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

          return _buildRow(snapshot.data, _suggestions[realIndex]); //_suggetsions[realIndex]에는 random 단어가 들어있음
        });
      }
    );
  }

  Widget _buildRow(Set<WordPair> saved, WordPair pair) {
    //pair로 단어 자체를 받음
    final bool alreadySaved = saved == null? false  : saved.contains(pair); //_saved안에 pair라는 단어가 있는지 없는지에 따라 bool 값이 들어가 있음
     return ListTile(
      title: Text(pair.asPascalCase, textScaleFactor: 2),
      trailing: Icon(
       alreadySaved? Icons.favorite : Icons.favorite_border,
        color: Colors.pinkAccent,
      ),
      onTap: (){
        bloc.addToOrRemoveFromSavedList(pair);
//        setState(() { //stateful 위젯안의 state를 다시 재실행.update
//          if (alreadySaved)
//            saved.remove(pair);//true이면
//          else
//            saved.add(pair); //false인경우
//        });
      },
    );
  }

}
