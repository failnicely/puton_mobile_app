import 'package:redux/redux.dart';

class ChangeTabAction {
  final int position;

  ChangeTabAction(this.position);
}

int _changeTab(int tabPosition, ChangeTabAction action) => action.position;

final Reducer<int> tabPositionReducer = combineReducers<int>([
  TypedReducer<int, ChangeTabAction>(_changeTab),
]);
