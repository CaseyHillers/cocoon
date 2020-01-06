// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:app_flutter/service/google_sign_in.dart';

import '../utils/fake_google_account.dart';

void main() {
  group('GoogleSignInService not signed in', () {
    GoogleSignInService signInService;
    GoogleSignIn mockGoogleSignInPlugin;

    setUp(() {
      mockGoogleSignInPlugin = MockGoogleSignIn();
      when(mockGoogleSignInPlugin.onCurrentUserChanged)
          .thenAnswer((_) => const Stream<GoogleSignInAccount>.empty());
      when(mockGoogleSignInPlugin.isSignedIn())
          .thenAnswer((_) => Future<bool>.value(false));
      signInService = GoogleSignInService(googleSignIn: mockGoogleSignInPlugin);
    });

    test('not authenticated', () async {
      expect(await signInService.isAuthenticated, false);
    });

    test('no user information', () {
      expect(signInService.user, null);
      expect(signInService.idToken, null);
    });
  });

  group('GoogleSignInService sign in', () {
    GoogleSignInService signInService;
    GoogleSignIn mockGoogleSignInPlugin;

    final GoogleSignInAccount testAccount = FakeGoogleSignInAccount();

    setUp(() {
      mockGoogleSignInPlugin = MockGoogleSignIn();
      when(mockGoogleSignInPlugin.signIn())
          .thenAnswer((_) => Future<GoogleSignInAccount>.value(testAccount));
      when(mockGoogleSignInPlugin.currentUser).thenReturn(testAccount);
      when(mockGoogleSignInPlugin.isSignedIn())
          .thenAnswer((_) => Future<bool>.value(true));
      when(mockGoogleSignInPlugin.onCurrentUserChanged)
          .thenAnswer((_) => const Stream<GoogleSignInAccount>.empty());

      signInService = GoogleSignInService(googleSignIn: mockGoogleSignInPlugin);
    });

    test('is authenticated after successful sign in', () async {
      await signInService.signIn();

      expect(await signInService.isAuthenticated, true);
      expect(signInService.user, testAccount);
    });

    test('there is user information after successful sign in', () async {
      await signInService.signIn();

      expect(signInService.user.displayName, 'Dr. Test');
      expect(signInService.user.email, 'test@flutter.dev');
      expect(signInService.user.id, 'test123');
      expect(signInService.user.photoUrl,
          'https://lh3.googleusercontent.com/-ukEAtRyRhw8/AAAAAAAAAAI/AAAAAAAAAAA/ACHi3rfhID9XACtdb9q_xK43VSXQvBV11Q.CMID');
    });

    test('id token available with logged in user', () async {
      final GoogleSignInAccount testAccountWithAuthentication =
          FakeGoogleSignInAccount()
            ..authentication = Future<GoogleSignInAuthentication>.value(
                FakeGoogleSignInAuthentication());
      signInService.user = testAccountWithAuthentication;

      expect(await signInService.idToken, 'id123');
    });

    test('is not authenticated after failure in sign in', () async {
      when(mockGoogleSignInPlugin.signInSilently())
          .thenAnswer((_) => Future<GoogleSignInAccount>.value(null));
      when(mockGoogleSignInPlugin.signIn())
          .thenAnswer((_) => Future<GoogleSignInAccount>.value(null));

      await signInService.signIn();

      expect(signInService.user, null);
      expect(signInService.idToken, null);
    });
  });
}

/// Mock [GoogleSignIn] for testing interactions.
class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class FakeGoogleSignInAuthentication implements GoogleSignInAuthentication {
  @override
  String get accessToken => 'access123';

  @override
  String get idToken => 'id123';
}
