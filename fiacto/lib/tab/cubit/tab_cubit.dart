import 'package:common/common.dart';
import 'package:equatable/equatable.dart';
import 'package:fiacto/tab/models/models.dart';
import 'package:fiacto/tab/view/view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'tab_state.dart';

class TabCubit extends Cubit<TabState> {
  TabCubit({required TabItem initialTab})
    : super(TabState(currentTab: initialTab));

  void onTabChanged(TabItem tab, GoRouter router) {
    if (tab == state.currentTab) return;

    $debugPrint(tab, tag: 'tab-changed');
    router.go(TabPage.route(tab));
    emit(TabState(currentTab: tab));
  }
}
