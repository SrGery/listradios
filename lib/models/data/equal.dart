import 'package:equatable/equatable.dart';
import 'error/fails.dart';

class Equal<T> extends Equatable {
  final T? _value;
  final Fails? _error;

  const Equal._({
    required T? value,
    required Fails? error,
  })  : _value = value,
        _error = error;

  factory Equal.success(T value) => Equal._(
        value: value,
        error: null,
      );
  factory Equal.error(Fails failure) => Equal._(
        value: null,
        error: failure,
      );

  R when<R>({
    required R Function(T value) success,
    required R Function(Fails failure) error,
  }) {
    if (_value != null) {
      return success(_value as T);
    } else if (_error != null) {
      return error(_error!);
    }

    throw StateError('Unhandled case');
  }

  @override
  List<Object?> get props => [_value, _error];
}
