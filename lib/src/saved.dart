import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bloc/Bloc.dart';

class SavedList extends StatefulWidget {

//  SavedList({@required this.saved}); //constructor
// final Set<WordPair> saved;

  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Saved"),),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return StreamBuilder<Set<WordPair>>(
      stream: bloc.savedStream,
      builder: (context, snapshot) {
        var saved2 = Set<WordPair>();

        if (snapshot.hasData)//data가 있을 때만 snapshot.data를 전달해줌
          saved2.addAll(snapshot.data);
        else
          bloc.addCrrentSaved; //randomlist에서 변한 data를 trigger해줘야함


        return ListView.builder(
            itemCount: saved2.length * 2,
            itemBuilder: (context, index) { //itemcount갯수를 알려주기
              if (index.isOdd)
                return Divider();

              var realIndex = index ~/ 2;

              return _buildRow(
                  saved2.toList()[realIndex]); //saved는 set이므로 list로 변경후 받아옴
            });
      }
    );
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(pair.asPascalCase, textScaleFactor: 1.5,),
      onTap: () {
        setState(() {
          bloc.addToOrRemoveFromSavedList(pair); //이걸지우고 다시 화면 생성함
        });
      },
    );
  }
}
