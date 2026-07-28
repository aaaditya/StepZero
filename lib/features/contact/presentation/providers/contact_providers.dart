import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/contact_repository.dart';
import '../../domain/contact_submission.dart';

final contactRepositoryProvider = Provider<ContactRepository>(
  (ref) => ContactRepositoryImpl(),
);
