part of 'list_radio_bloc.dart';

sealed class ListRadioEvent extends Equatable {
  const ListRadioEvent();

  @override
  List<Object> get props => [];
}

class GetRadioEvent extends ListRadioEvent {}
