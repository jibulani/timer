import 'package:bloc/bloc.dart';

import 'navigation_event.dart';
import 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  int currentIndex = 0;

  NavigationBloc()
      : super(PageLoading()) {
    on<PageTapped>((event, emit) async {
      currentIndex = event.index;
      emit(CurrentIndexChanged(currentIndex));
      emit(PageLoading());
      if (event.index == 0) {
        emit(HomePageLoaded());
      }
      if (event.index == 1) {
        emit(OtherPageLoaded());
      }
    });
  }
}