import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'count_provider.g.dart';

@riverpod
class CountState extends _$CountState{
  @override
  String build(){
    return "";
  }
  void setCount(String newState) {
    state = newState;
  }
}