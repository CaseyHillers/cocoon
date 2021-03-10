// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:meta/meta.dart';

import 'package:cocoon_service/cocoon_service.dart';
import 'package:cocoon_service/models.dart';

import '../service/scheduler.dart';

/// Schedule tasks from a [ScheduleProdRequest].
@immutable
class ScheduleProd extends ApiRequestHandler<Body> {
  const ScheduleProd(
    Config config,
    AuthenticationProvider authenticationProvider, {
    @visibleForTesting this.datastoreProvider = DatastoreService.defaultProvider,
    @visibleForTesting this.httpClientProvider = Providers.freshHttpClient,
    @visibleForTesting this.gitHubBackoffCalculator = twoSecondLinearBackoff,
  })  : assert(datastoreProvider != null),
        assert(httpClientProvider != null),
        super(config: config, authenticationProvider: authenticationProvider);

  final DatastoreServiceProvider datastoreProvider;
  final GitHubBackoffCalculator gitHubBackoffCalculator;
  final HttpClientProvider httpClientProvider;

  @override
  Future<Body> post() async {
    final DatastoreService datastore = datastoreProvider(config.db);
    final ScheduleProdTasksRequest request = ScheduleProdTasksRequest.fromJson(requestData);
    final List<Commit> commits = request.commits.map((SerializableCommit serialized) => serialized.commit);

    final Scheduler scheduler = Scheduler(
        config: config,
        datastore: datastore,
        httpClient: httpClientProvider(),
        gitHubBackoffCalculator: gitHubBackoffCalculator,
        log: log);
    await scheduler.addCommits(commits);

    return Body.empty;
  }
}
