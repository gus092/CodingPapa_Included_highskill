import 'package:english_words/english_words.dart';
import 'dart:async';

class Bloc {
  final Set<WordPair> saved = Set<WordPair>();
  final _savedController =
      StreamController<Set<WordPair>>.broadcast(); //dart:async import해주기
  //broadcast: snapshot을 여러군데 보내줄 수 있음
  //반드시 dispose해주기

//  Stream<Set<WordPair>> getSavedListStream(){ //Stream가져오는 function
//    return _savedController.stream;
//  }

  get savedStream => _savedController.stream; //stream 생성
  //아무data 받아오는 것 없이 data를 return하기만 하는 function => get

  get addCrrentSaved => _savedController.sink.add(saved);
  //savedList를 trigger하기 위함
  //지금 상태의 saved에 있는 data를 stream으로 보내주는 역할을 함

  addToOrRemoveFromSavedList(WordPair item) {
    if (saved.contains(item))
      saved.remove(item);
    else
      saved.add(item);
    //saved의 data를 변경하고

    _savedController.sink.add(saved);
    //controller에 알려줌 * sink : 변경된 data를 보내줄 때
  }

  dispose() {
    _savedController.close();
  }
}

var bloc = Bloc();
