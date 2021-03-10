// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

import '../commit.dart';

part 'schedule_prod.g.dart';

/// RPC to scheduler microservice to trigger tasks against [commits].
@JsonSerializable()
class ScheduleProdTasksRequest {
  /// Creates a new [Task].
  const ScheduleProdTasksRequest({
    this.commits,
  });

  factory ScheduleProdTasksRequest.fromJson(Map<String, dynamic> json) => _$ScheduleProdTasksRequestFromJson(json);

  final Set<Commit> commits;

  Map<String, dynamic> toJson() => _$ScheduleProdTasksRequestToJson(this);
}