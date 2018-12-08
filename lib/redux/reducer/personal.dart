import 'package:puton/redux/store/personal.dart';
import 'package:puton/redux/store/post.dart';
import 'package:redux/redux.dart';

class ClearTilesAction {}

class AddTilesAction {
  final List<Post> tiles;

  AddTilesAction(this.tiles);
}

class ToggleStaggeredAction {}

class ActivateLoadingAction {}

class DeactivateLoadingAction {}

Personal _clearTiles(Personal personal, ClearTilesAction action) =>
    personal.copyWith(tiles: []);

Personal _addTiles(Personal personal, AddTilesAction action) =>
    personal.copyWith(tiles: (personal.tiles..addAll(action.tiles)));

Personal _toggleStaggered(Personal personal, ToggleStaggeredAction action) =>
    personal.copyWith(isStaggered: !personal.isStaggered);

Personal _activateLoading(Personal personal, ActivateLoadingAction action) =>
    personal.copyWith(isLoading: true);

Personal _deactivateLoading(Personal personal, DeactivateLoadingAction action) =>
    personal.copyWith(isLoading: false);

final Reducer<Personal> personalReducer = combineReducers<Personal>([
  TypedReducer<Personal, ClearTilesAction>(_clearTiles),
  TypedReducer<Personal, AddTilesAction>(_addTiles),
  TypedReducer<Personal, ToggleStaggeredAction>(_toggleStaggered),
  TypedReducer<Personal, ActivateLoadingAction>(_activateLoading),
  TypedReducer<Personal, DeactivateLoadingAction>(_deactivateLoading),
]);
