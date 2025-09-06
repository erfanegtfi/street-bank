class FormValidationState {
  String? errorMessage;
  bool valid = true;

  FormValidationState.init() : valid = false;
  FormValidationState.errorMessage(this.errorMessage) : valid = false;
  FormValidationState.isValid() : valid = true;
}
