// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:appengine/appengine.dart';
import 'package:gcloud/db.dart';

import 'package:cocoon_scheduler/scheduler.dart';

Future<void> main() async {
  await withAppEngineServices(() async {
    final Config config = Config(dbService, null);
    final AuthenticationProvider authProvider = AuthenticationProvider(config);
    final AuthenticationProvider swarmingAuthProvider = SwarmingAuthenticationProvider(config);
    final BuildBucketClient buildBucketClient = BuildBucketClient(
      accessTokenService: AccessTokenService.defaultProvider(config),
    );
    final ServiceAccountInfo serviceAccountInfo = await config.deviceLabServiceAccount;

    /// LUCI service class to communicate with buildBucket service.
    final LuciBuildService luciBuildService = LuciBuildService(
      config,
      buildBucketClient,
      serviceAccountInfo,
    );

    /// Github status service to update the state of the build
    /// in the Github UI.
    final GithubStatusService githubStatusService = GithubStatusService(
      config,
      luciBuildService,
    );

    /// Github checks api service used to provide luci test execution status on the Github UI.
    final GithubChecksService githubChecksService = GithubChecksService(
      config,
    );

    final Map<String, RequestHandler<dynamic>> handlers = <String, RequestHandler<dynamic>>{
      
    };

    return await runAppEngine((HttpRequest request) async {
      final RequestHandler<dynamic> handler = handlers[request.uri.path];
      if (handler != null) {
        await handler.service(request);
      }
    }, onAcceptingConnections: (InternetAddress address, int port) {
      final String host = address.isLoopback ? 'localhost' : address.host;
      print('Serving requests at http://$host:$port/');
    });
  });
}
