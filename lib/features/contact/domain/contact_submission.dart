/// Contact lead submission contract.
class ContactSubmission {
  const ContactSubmission({
    required this.name,
    required this.email,
    required this.message,
    this.company,
    this.honeypot,
  });

  final String name;
  final String email;
  final String message;
  final String? company;
  final String? honeypot;
}

enum ContactSubmitStatus { idle, submitting, success, error }

class ContactSubmitResult {
  const ContactSubmitResult.success()
      : status = ContactSubmitStatus.success,
        errorMessage = null;

  const ContactSubmitResult.error(this.errorMessage)
      : status = ContactSubmitStatus.error;

  final ContactSubmitStatus status;
  final String? errorMessage;
}

/// Abstract contact repository — swap for Formspree / API / CRM.
abstract class ContactRepository {
  Future<ContactSubmitResult> submit(ContactSubmission submission);
}

/// In-memory / simulated repository for v1 — ready to replace.
class MockContactRepository implements ContactRepository {
  MockContactRepository({this.simulateFailure = false});

  final bool simulateFailure;

  @override
  Future<ContactSubmitResult> submit(ContactSubmission submission) async {
    // Spam honeypot triggered — pretend success without processing.
    if (submission.honeypot != null && submission.honeypot!.trim().isNotEmpty) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      return const ContactSubmitResult.success();
    }

    await Future<void>.delayed(const Duration(milliseconds: 900));

    if (simulateFailure) {
      return const ContactSubmitResult.error(
        'Something went wrong. Please email hello@stepzero.studio.',
      );
    }

    return const ContactSubmitResult.success();
  }
}
