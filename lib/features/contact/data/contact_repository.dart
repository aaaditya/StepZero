import '../domain/contact_submission.dart';

/// Data layer entry — replace [MockContactRepository] with HTTP/CRM later.
class ContactRepositoryImpl implements ContactRepository {
  ContactRepositoryImpl({ContactRepository? delegate})
      : _delegate = delegate ?? MockContactRepository();

  final ContactRepository _delegate;

  @override
  Future<ContactSubmitResult> submit(ContactSubmission submission) {
    return _delegate.submit(submission);
  }
}
