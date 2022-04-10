import 'constants.dart';

extension FormzStatusCheck on FormzStatus {
  bool get isInvalid => this == FormzStatus.invalid;
  bool get isValidated => this == FormzStatus.valid;
  bool get isSubmissionInProgress => this == FormzStatus.submissionInProgress;
  bool get isSubmissionSuccess => this == FormzStatus.submissionSuccess;
  bool get isSubmissionFailure => this == FormzStatus.submissionFailure;
  bool get isSubmissionCanceled => this == FormzStatus.submissionCanceled;
}
