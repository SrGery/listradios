import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listradios/models/data/error/fails.dart';
import 'package:listradios/models/data/radio.dart';
import '../../../services/repositories/radio_repository.dart';

part 'list_radio_event.dart';
part 'list_radio_state.dart';

class ListRadioBloc extends Bloc<ListRadioEvent, ListRadioState> {
  final RadioRepository _repository;

  ListRadioBloc({
    required RadioRepository repository,
  })  : _repository = repository,
        super(HomeInitialState()) {
    on<GetRadioEvent>(_onGetRadioStationsEvent);
  }

  Future<void> _onGetRadioStationsEvent(
    GetRadioEvent event,
    Emitter<ListRadioState> emit,
  ) async {
    emit(HomeLoadingState());

    final result = await _repository.getRadioStations();

    result.when(
      success: (radioStations) {
        emit(HomeLoadedState(radioStations: radioStations));
      },
      error: (failure) {
        emit(HomeErrorState(failure: failure));
      },
    );
  }
}
