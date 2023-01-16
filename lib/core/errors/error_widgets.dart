import 'package:flutter/material.dart';

abstract class ErrorViewer {
  static void showConnectionError(key, VoidCallback callback) {
    final snackbar = SnackBar(
      content: const Text(
        'connection_err',
      ),
      action: SnackBarAction(
        label: 'retry',
        onPressed: () {
          callback();
        },
      ),
    );
    key.currentState.showSnackBar(snackbar);
  }

  static void showCustomError(key, String message) {
    final snackbar = SnackBar(
      content: Text(
        message,
      ),
    );
    key.currentState.showSnackBar(snackbar);
  }

  static void showUnexpectedError(key) {
    const snackbar = SnackBar(
      content: Text(
        'unexpected_err',
      ),
    );
    key.currentState.showSnackBar(snackbar);
  }
}
