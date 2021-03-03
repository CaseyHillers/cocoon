///
//  Generated code. Do not modify.
//  source: lib/src/model/proto/internal/requests/schedule_postsubmit.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../commit.pb.dart' as $0;

class SchedulePostsubmitRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SchedulePostsubmitRequest', createEmptyInstance: create)
    ..pc<$0.Commit>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'commits', $pb.PbFieldType.PM, subBuilder: $0.Commit.create)
    ..hasRequiredFields = false
  ;

  SchedulePostsubmitRequest._() : super();
  factory SchedulePostsubmitRequest({
    $core.Iterable<$0.Commit> commits,
  }) {
    final _result = create();
    if (commits != null) {
      _result.commits.addAll(commits);
    }
    return _result;
  }
  factory SchedulePostsubmitRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SchedulePostsubmitRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SchedulePostsubmitRequest clone() => SchedulePostsubmitRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SchedulePostsubmitRequest copyWith(void Function(SchedulePostsubmitRequest) updates) => super.copyWith((message) => updates(message as SchedulePostsubmitRequest)) as SchedulePostsubmitRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SchedulePostsubmitRequest create() => SchedulePostsubmitRequest._();
  SchedulePostsubmitRequest createEmptyInstance() => create();
  static $pb.PbList<SchedulePostsubmitRequest> createRepeated() => $pb.PbList<SchedulePostsubmitRequest>();
  @$core.pragma('dart2js:noInline')
  static SchedulePostsubmitRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SchedulePostsubmitRequest>(create);
  static SchedulePostsubmitRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$0.Commit> get commits => $_getList(0);
}

