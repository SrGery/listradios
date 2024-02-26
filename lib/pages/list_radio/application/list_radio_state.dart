part of 'list_radio_bloc.dart';

sealed class ListRadioState extends Equatable {
  const ListRadioState();

  @override
  List<Object> get props => [];
}

final class HomeInitialState extends ListRadioState {}

final class HomeLoadingState extends ListRadioState {}

class HomeLoadedState extends ListRadioState {
  final List<Radios> radioStations;

  const HomeLoadedState({required this.radioStations});

  @override
  List<Object> get props => [radioStations];
}

class HomeErrorState extends ListRadioState {
  final Fails failure;

  const HomeErrorState({required this.failure});

  @override
  List<Object> get props => [failure];
}
