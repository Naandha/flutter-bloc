import 'package:bloc/bloc.dart';


part 'count_event.dart';
part 'count_state.dart';

class CountBloc extends Bloc<CountEvent, CountState> {
  CountBloc() : super(CountInitial(count: 0)) {
    on<increment>((event, emit) {
      var s=state.count;
      s++;
      emit(CountState(count: s));
    });
    on<decrement>((event, emit) {
      var s=state.count;
      s--;
      emit(CountState(count: s));
    });
  }
}
