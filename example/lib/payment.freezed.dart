// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Payment {
  String? get id;
  String? get pk;
  String? get paymentMethod;
  String? get paymentStatus;
  double? get amount;
  double? get baseAmount;
  double? get fee;
  double? get cashback;
  String? get description;
  DateTime? get createdAt;
  DateTime? get updatedAt;
  @APaymentType()
  WPaymentType? get paymentType;
  @AListPaymentType()
  List<WPaymentType?>? get paymentTypes;

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PaymentCopyWith<Payment> get copyWith =>
      _$PaymentCopyWithImpl<Payment>(this as Payment, _$identity);

  /// Serializes this Payment to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Payment &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pk, pk) || other.pk == pk) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.baseAmount, baseAmount) ||
                other.baseAmount == baseAmount) &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.cashback, cashback) ||
                other.cashback == cashback) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.paymentType, paymentType) ||
                other.paymentType == paymentType) &&
            const DeepCollectionEquality()
                .equals(other.paymentTypes, paymentTypes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      pk,
      paymentMethod,
      paymentStatus,
      amount,
      baseAmount,
      fee,
      cashback,
      description,
      createdAt,
      updatedAt,
      paymentType,
      const DeepCollectionEquality().hash(paymentTypes));

  @override
  String toString() {
    return 'Payment(id: $id, pk: $pk, paymentMethod: $paymentMethod, paymentStatus: $paymentStatus, amount: $amount, baseAmount: $baseAmount, fee: $fee, cashback: $cashback, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, paymentType: $paymentType, paymentTypes: $paymentTypes)';
  }
}

/// @nodoc
abstract mixin class $PaymentCopyWith<$Res> {
  factory $PaymentCopyWith(Payment value, $Res Function(Payment) _then) =
      _$PaymentCopyWithImpl;
  @useResult
  $Res call(
      {String? id,
      String? pk,
      String? paymentMethod,
      String? paymentStatus,
      double? amount,
      double? baseAmount,
      double? fee,
      double? cashback,
      String? description,
      DateTime? createdAt,
      DateTime? updatedAt,
      @APaymentType() WPaymentType? paymentType,
      @AListPaymentType() List<WPaymentType?>? paymentTypes});
}

/// @nodoc
class _$PaymentCopyWithImpl<$Res> implements $PaymentCopyWith<$Res> {
  _$PaymentCopyWithImpl(this._self, this._then);

  final Payment _self;
  final $Res Function(Payment) _then;

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? pk = freezed,
    Object? paymentMethod = freezed,
    Object? paymentStatus = freezed,
    Object? amount = freezed,
    Object? baseAmount = freezed,
    Object? fee = freezed,
    Object? cashback = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? paymentType = freezed,
    Object? paymentTypes = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      pk: freezed == pk
          ? _self.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentMethod: freezed == paymentMethod
          ? _self.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentStatus: freezed == paymentStatus
          ? _self.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      baseAmount: freezed == baseAmount
          ? _self.baseAmount
          : baseAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      fee: freezed == fee
          ? _self.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as double?,
      cashback: freezed == cashback
          ? _self.cashback
          : cashback // ignore: cast_nullable_to_non_nullable
              as double?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      paymentType: freezed == paymentType
          ? _self.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as WPaymentType?,
      paymentTypes: freezed == paymentTypes
          ? _self.paymentTypes
          : paymentTypes // ignore: cast_nullable_to_non_nullable
              as List<WPaymentType?>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Payment implements Payment {
  const _Payment(
      {this.id,
      this.pk,
      this.paymentMethod,
      this.paymentStatus,
      this.amount,
      this.baseAmount,
      this.fee,
      this.cashback,
      this.description,
      this.createdAt,
      this.updatedAt,
      @APaymentType() this.paymentType,
      @AListPaymentType() final List<WPaymentType?>? paymentTypes})
      : _paymentTypes = paymentTypes;
  factory _Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);

  @override
  final String? id;
  @override
  final String? pk;
  @override
  final String? paymentMethod;
  @override
  final String? paymentStatus;
  @override
  final double? amount;
  @override
  final double? baseAmount;
  @override
  final double? fee;
  @override
  final double? cashback;
  @override
  final String? description;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  @APaymentType()
  final WPaymentType? paymentType;
  final List<WPaymentType?>? _paymentTypes;
  @override
  @AListPaymentType()
  List<WPaymentType?>? get paymentTypes {
    final value = _paymentTypes;
    if (value == null) return null;
    if (_paymentTypes is EqualUnmodifiableListView) return _paymentTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PaymentCopyWith<_Payment> get copyWith =>
      __$PaymentCopyWithImpl<_Payment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PaymentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Payment &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pk, pk) || other.pk == pk) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.baseAmount, baseAmount) ||
                other.baseAmount == baseAmount) &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.cashback, cashback) ||
                other.cashback == cashback) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.paymentType, paymentType) ||
                other.paymentType == paymentType) &&
            const DeepCollectionEquality()
                .equals(other._paymentTypes, _paymentTypes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      pk,
      paymentMethod,
      paymentStatus,
      amount,
      baseAmount,
      fee,
      cashback,
      description,
      createdAt,
      updatedAt,
      paymentType,
      const DeepCollectionEquality().hash(_paymentTypes));

  @override
  String toString() {
    return 'Payment(id: $id, pk: $pk, paymentMethod: $paymentMethod, paymentStatus: $paymentStatus, amount: $amount, baseAmount: $baseAmount, fee: $fee, cashback: $cashback, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, paymentType: $paymentType, paymentTypes: $paymentTypes)';
  }
}

/// @nodoc
abstract mixin class _$PaymentCopyWith<$Res> implements $PaymentCopyWith<$Res> {
  factory _$PaymentCopyWith(_Payment value, $Res Function(_Payment) _then) =
      __$PaymentCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? id,
      String? pk,
      String? paymentMethod,
      String? paymentStatus,
      double? amount,
      double? baseAmount,
      double? fee,
      double? cashback,
      String? description,
      DateTime? createdAt,
      DateTime? updatedAt,
      @APaymentType() WPaymentType? paymentType,
      @AListPaymentType() List<WPaymentType?>? paymentTypes});
}

/// @nodoc
class __$PaymentCopyWithImpl<$Res> implements _$PaymentCopyWith<$Res> {
  __$PaymentCopyWithImpl(this._self, this._then);

  final _Payment _self;
  final $Res Function(_Payment) _then;

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? pk = freezed,
    Object? paymentMethod = freezed,
    Object? paymentStatus = freezed,
    Object? amount = freezed,
    Object? baseAmount = freezed,
    Object? fee = freezed,
    Object? cashback = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? paymentType = freezed,
    Object? paymentTypes = freezed,
  }) {
    return _then(_Payment(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      pk: freezed == pk
          ? _self.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentMethod: freezed == paymentMethod
          ? _self.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentStatus: freezed == paymentStatus
          ? _self.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      baseAmount: freezed == baseAmount
          ? _self.baseAmount
          : baseAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      fee: freezed == fee
          ? _self.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as double?,
      cashback: freezed == cashback
          ? _self.cashback
          : cashback // ignore: cast_nullable_to_non_nullable
              as double?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      paymentType: freezed == paymentType
          ? _self.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as WPaymentType?,
      paymentTypes: freezed == paymentTypes
          ? _self._paymentTypes
          : paymentTypes // ignore: cast_nullable_to_non_nullable
              as List<WPaymentType?>?,
    ));
  }
}

// dart format on
