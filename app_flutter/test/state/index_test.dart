// Copyright (c) 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:app_flutter/service/google_sign_in.dart';
import 'package:app_flutter/state/index.dart';

void main() {
  group('IndexState', () {
    IndexState indexState;
    MockGoogleSignInService mockSignInService;

    setUp(() {
      mockSignInService = MockGoogleSignInService();
      indexState = IndexState(signInServiceValue: mockSignInService);
    });

    tearDown(() {
      clearInteractions(mockSignInService);
    });

    testWidgets('auth functions forward to google sign in service',
        (WidgetTester tester) async {
      verifyNever(mockSignInService.signIn());
      verifyNever(mockSignInService.signOut());

      await indexState.signIn();

      verify(mockSignInService.signIn()).called(1);
      verifyNever(mockSignInService.signOut());

      await indexState.signOut();
      verify(mockSignInService.signOut()).called(1);
    });
  });
}

/// Mock for testing interactions with [GoogleSignInService].
class MockGoogleSignInService extends Mock implements GoogleSignInService {}
