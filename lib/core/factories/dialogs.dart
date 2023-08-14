import 'dialog_factory.dart';

class ShowAndHideDialogs {
  void showProgressIndicator() => DialogFactory.showProgressIndicator();

  void showToastMessage(String content) =>
      DialogFactory.showToastMessage(content);

  void disposeProgressIndicator() => DialogFactory.disposeProgressIndicator();
}
