// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: always_specify_types, implicit_dynamic_parameter

part of 'schedule_prod.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleProdTasksRequest _$ScheduleProdTasksRequestFromJson(
    Map<String, dynamic> json) {
  return ScheduleProdTasksRequest(
    commits: (json['commits'] as List)
        ?.map((e) => e == null
            ? null
            : SerializableCommit.fromJson(e as Map<String, dynamic>))
        ?.toSet(),
  );
}

Map<String, dynamic> _$ScheduleProdTasksRequestToJson(
        ScheduleProdTasksRequest instance) =>
    <String, dynamic>{
      'commits': instance.commits?.toList(),
    };
