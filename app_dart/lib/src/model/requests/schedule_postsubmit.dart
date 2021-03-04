// Copyright 2020 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

import '../appengine/commit.dart';

@JsonSerializable()
class SchedulePostsubmitRequest {
  SchedulePostsubmitRequest({
    this.commits,
  });

  factory SchedulePostsubmitRequest.fromJson(Map<String, dynamic> input) => _$SchedulePostsubmitRequest(input);
  final List<SerializableCommit> commits;

  Map<String, dynamic> toJson() => _$SchedulePostsubmitRequest(this);
}
