// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'alarm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AlarmTearOff {
  const _$AlarmTearOff();

  _Alarm call(
      {required DateTime datetime,
      required String createdBy,
      required String description,
      required int numberOfPeople}) {
    return _Alarm(
      datetime: datetime,
      createdBy: createdBy,
      description: description,
      numberOfPeople: numberOfPeople,
    );
  }
}

/// @nodoc
const $Alarm = _$AlarmTearOff();

/// @nodoc
mixin _$Alarm {
  DateTime get datetime => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get numberOfPeople => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AlarmCopyWith<Alarm> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlarmCopyWith<$Res> {
  factory $AlarmCopyWith(Alarm value, $Res Function(Alarm) then) =
      _$AlarmCopyWithImpl<$Res>;
  $Res call(
      {DateTime datetime,
      String createdBy,
      String description,
      int numberOfPeople});
}

/// @nodoc
class _$AlarmCopyWithImpl<$Res> implements $AlarmCopyWith<$Res> {
  _$AlarmCopyWithImpl(this._value, this._then);

  final Alarm _value;
  // ignore: unused_field
  final $Res Function(Alarm) _then;

  @override
  $Res call({
    Object? datetime = freezed,
    Object? createdBy = freezed,
    Object? description = freezed,
    Object? numberOfPeople = freezed,
  }) {
    return _then(_value.copyWith(
      datetime: datetime == freezed
          ? _value.datetime
          : datetime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: createdBy == freezed
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfPeople: numberOfPeople == freezed
          ? _value.numberOfPeople
          : numberOfPeople // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$AlarmCopyWith<$Res> implements $AlarmCopyWith<$Res> {
  factory _$AlarmCopyWith(_Alarm value, $Res Function(_Alarm) then) =
      __$AlarmCopyWithImpl<$Res>;
  @override
  $Res call(
      {DateTime datetime,
      String createdBy,
      String description,
      int numberOfPeople});
}

/// @nodoc
class __$AlarmCopyWithImpl<$Res> extends _$AlarmCopyWithImpl<$Res>
    implements _$AlarmCopyWith<$Res> {
  __$AlarmCopyWithImpl(_Alarm _value, $Res Function(_Alarm) _then)
      : super(_value, (v) => _then(v as _Alarm));

  @override
  _Alarm get _value => super._value as _Alarm;

  @override
  $Res call({
    Object? datetime = freezed,
    Object? createdBy = freezed,
    Object? description = freezed,
    Object? numberOfPeople = freezed,
  }) {
    return _then(_Alarm(
      datetime: datetime == freezed
          ? _value.datetime
          : datetime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: createdBy == freezed
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfPeople: numberOfPeople == freezed
          ? _value.numberOfPeople
          : numberOfPeople // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_Alarm implements _Alarm {
  const _$_Alarm(
      {required this.datetime,
      required this.createdBy,
      required this.description,
      required this.numberOfPeople});

  @override
  final DateTime datetime;
  @override
  final String createdBy;
  @override
  final String description;
  @override
  final int numberOfPeople;

  @override
  String toString() {
    return 'Alarm(datetime: $datetime, createdBy: $createdBy, description: $description, numberOfPeople: $numberOfPeople)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Alarm &&
            (identical(other.datetime, datetime) ||
                const DeepCollectionEquality()
                    .equals(other.datetime, datetime)) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality()
                    .equals(other.createdBy, createdBy)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.numberOfPeople, numberOfPeople) ||
                const DeepCollectionEquality()
                    .equals(other.numberOfPeople, numberOfPeople)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(datetime) ^
      const DeepCollectionEquality().hash(createdBy) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(numberOfPeople);

  @JsonKey(ignore: true)
  @override
  _$AlarmCopyWith<_Alarm> get copyWith =>
      __$AlarmCopyWithImpl<_Alarm>(this, _$identity);
}

abstract class _Alarm implements Alarm {
  const factory _Alarm(
      {required DateTime datetime,
      required String createdBy,
      required String description,
      required int numberOfPeople}) = _$_Alarm;

  @override
  DateTime get datetime => throw _privateConstructorUsedError;
  @override
  String get createdBy => throw _privateConstructorUsedError;
  @override
  String get description => throw _privateConstructorUsedError;
  @override
  int get numberOfPeople => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AlarmCopyWith<_Alarm> get copyWith => throw _privateConstructorUsedError;
}
