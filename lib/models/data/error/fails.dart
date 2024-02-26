import 'package:equatable/equatable.dart';

abstract class Fails extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Fails {}

class NetworkFailure extends Fails {}
