import 'package:flutter_bloc/flutter_bloc.dart';
part 'bottom_navigation_event.dart';

class BottomNavigationBloc extends Bloc<BottomNavigationEvent, int> {
  BottomNavigationBloc() : super(0) {
    on<BottomNavigationEvent>((event, emit) {
      emit(event.index);
    });
  }
}
