import 'package:flutter_test/flutter_test.dart';
import 'package:stepzero/core/routing/routes.dart';
import 'package:stepzero/core/utils/validators.dart';
import 'package:stepzero/features/contact/domain/contact_submission.dart';

void main() {
  group('AppValidators', () {
    test('name rejects empty and short values', () {
      expect(AppValidators.name(null), isNotNull);
      expect(AppValidators.name(''), isNotNull);
      expect(AppValidators.name('A'), isNotNull);
      expect(AppValidators.name('Ada'), isNull);
    });

    test('email validates format', () {
      expect(AppValidators.email('not-an-email'), isNotNull);
      expect(AppValidators.email('ada@stepzero.studio'), isNull);
    });

    test('message enforces minimum length', () {
      expect(AppValidators.message('too short'), isNotNull);
      expect(
        AppValidators.message(
          'We want to rebuild our clinic brand and booking system.',
        ),
        isNull,
      );
    });

    test('honeypot fails when filled', () {
      expect(AppValidators.honeypot(''), isNull);
      expect(AppValidators.honeypot('http://spam.test'), isNotNull);
    });
  });

  group('AppRoutes.sanitizeSlug', () {
    test('accepts kebab-case', () {
      expect(AppRoutes.sanitizeSlug('northside-clinic'), 'northside-clinic');
    });

    test('rejects traversal and junk', () {
      expect(AppRoutes.sanitizeSlug('../etc/passwd'), isNull);
      expect(AppRoutes.sanitizeSlug('UPPER'), isNull);
      expect(AppRoutes.sanitizeSlug('has spaces'), isNull);
      expect(AppRoutes.sanitizeSlug(''), isNull);
      expect(AppRoutes.sanitizeSlug(null), isNull);
    });
  });

  group('MockContactRepository', () {
    test('returns success for valid payload', () async {
      final repo = MockContactRepository();
      final result = await repo.submit(
        const ContactSubmission(
          name: 'Ada',
          email: 'ada@example.com',
          message: 'We need a premium brand and website system.',
        ),
      );
      expect(result.status, ContactSubmitStatus.success);
    });

    test('honeypot still reports success without leaking detection', () async {
      final repo = MockContactRepository();
      final result = await repo.submit(
        const ContactSubmission(
          name: 'Bot',
          email: 'bot@spam.test',
          message: 'Buy now buy now buy now buy now!!!',
          honeypot: 'filled',
        ),
      );
      expect(result.status, ContactSubmitStatus.success);
    });

    test('can simulate failure', () async {
      final repo = MockContactRepository(simulateFailure: true);
      final result = await repo.submit(
        const ContactSubmission(
          name: 'Ada',
          email: 'ada@example.com',
          message: 'We need a premium brand and website system.',
        ),
      );
      expect(result.status, ContactSubmitStatus.error);
      expect(result.errorMessage, isNotNull);
    });
  });
}
