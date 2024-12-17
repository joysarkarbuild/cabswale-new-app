// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionModelImpl _$$TransactionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionModelImpl(
      amount: json['amount'] as num,
      createdAt: _timestampToDateTime(json['createdAt']),
      docId: json['docId'] as String,
      msg: json['msg'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$$TransactionModelImplToJson(
        _$TransactionModelImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'createdAt': _dateTimeToTimestamp(instance.createdAt),
      'docId': instance.docId,
      'msg': instance.msg,
      'type': instance.type,
    };
