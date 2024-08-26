import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:to_do_list/app/core/notifier/default_change_notifier.dart';
import 'package:to_do_list/app/core/ui/messages.dart';

typedef SuccesVoidCallback = void Function(
  DefaultChangeNotifier changeNotifer,
  DefaultListener listener,
);

typedef ErrorVoidCallback = void Function(
  DefaultChangeNotifier changeNotifer,
  DefaultListener listener,
);

typedef InfoVoidCallback = void Function(
  DefaultChangeNotifier changeNotifer,
  DefaultListener listener,
);

class DefaultListener {
  final DefaultChangeNotifier changeNotifier;

  DefaultListener({
    required this.changeNotifier,
  });

  void listener({
    required BuildContext context,
    required SuccesVoidCallback succesCallback,
    ErrorVoidCallback? errorCallback,
    InfoVoidCallback? infoCallback
  }) {
    changeNotifier.addListener(
      () {
        if (infoCallback != null) {
          infoCallback(changeNotifier, this);
        }

        if (changeNotifier.isLoading) {
          Loader.show(context, progressIndicator: const CircularProgressIndicator());
        } else {
          Loader.hide();
        }

        if (changeNotifier.hasError) {
          Messages.of(context)
              .showError(changeNotifier.error ?? 'Erro interno');
        }

        if (changeNotifier.isSuccess) {
          succesCallback(changeNotifier, this);
        }
      },
    );
  }
}
