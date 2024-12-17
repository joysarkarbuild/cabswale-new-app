import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
class TransactionModel with _$TransactionModel {
  factory TransactionModel({
    required num amount,
    // ignore: invalid_annotation_target
    @JsonKey(
      fromJson: _timestampToDateTime,
      toJson: _dateTimeToTimestamp,
    )
    required DateTime createdAt,
    required String docId,
    required String msg,
    required String type,
  }) = _TransactionModel;

  /// Factory constructor for JSON deserialization.
  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  /// Factory constructor for creating an instance from a Map with null handling.
  factory TransactionModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError('TransactionModel: map is null');
    }

    return TransactionModel(
      amount: map['amount'] as num? ?? 0,
      createdAt: _timestampToDateTime(map['createdAt']),
      docId: map['docId'] as String? ?? '',
      msg: map['msg'] as String? ?? '',
      type: map['type'] as String? ?? '',
    );
  }
}

/// Converts a Firestore `Timestamp` to `DateTime`.
DateTime _timestampToDateTime(dynamic timestamp) {
  if (timestamp is Timestamp) {
    return timestamp.toDate();
  } else if (timestamp is DateTime) {
    return timestamp;
  }
  return DateTime.now(); // Default value for invalid types
}

/// Converts a `DateTime` to a Firestore `Timestamp`.
Timestamp _dateTimeToTimestamp(DateTime date) => Timestamp.fromDate(date);
