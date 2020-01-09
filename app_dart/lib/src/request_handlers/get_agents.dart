// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:gcloud/db.dart';
import 'package:meta/meta.dart';

import '../datastore/cocoon_config.dart';
import '../model/appengine/agent.dart';
import '../model/proto/internal/agent.dart' as AgentProto;
import '../model/proto/internal/commit.pb.dart' as proto;

import '../request_handling/body.dart';
import '../request_handling/request_handler.dart';
import '../service/datastore.dart';

@immutable
class GetAgents extends RequestHandler<Body> {
  const GetAgents(
    Config config, {
    @visibleForTesting
        this.datastoreProvider = DatastoreService.defaultProvider,
  }) : super(config: config);

  final DatastoreServiceProvider datastoreProvider;

  @override
  Future<Body> get() async {
    final DatastoreService datastore = datastoreProvider();
    final Query<Agent> agentQuery = datastore.db.query<Agent>()
      ..order('agentId');
    final List<Agent> agents =
        await agentQuery.run().where(_isVisible).toList();
    // sort these by healthy
    agents.sort((Agent a, Agent b) =>
        compareAsciiLowerCaseNatural(a.agentId, b.agentId));

    final List<List<int>> protoBytes = agents.map((Agent agent) => agent.toProto().writeToBuffer()).toList();

    final proto.Commit protobuf = proto.Commit();
    protobuf.writeToBuffer()   

    return Body.forStream(protos.by)
  }

  static bool _isVisible(Agent agent) => !agent.isHidden;
}
