import 'package:flutter_bloc/flutter_bloc.dart';
part 'bottom_navigation_event.dart';

class BottomNavigationBloc extends Bloc<BottomNavigationEvent, int> {
  // Initial index is 2 (ShopsPage)
  BottomNavigationBloc() : super(2) {
    on<BottomNavigationEvent>((event, emit) {
      emit(event.index);
    });
  }
}
