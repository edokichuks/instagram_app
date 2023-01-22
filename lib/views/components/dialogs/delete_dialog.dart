import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';
import 'package:instagram_app/views/components/dialogs/alert_dialog_model.dart';
import 'package:instagram_app/views/constants/string.dart';

@immutable
class DeleteDialog extends AlertDialogModel<bool> {
  const DeleteDialog({required String titleOfObjectToDelete})
      : super(
          title: '${Strings.delete} $titleOfObjectToDelete?',
          message:
              '${Strings.areYouSureWantToDeleteThis} $titleOfObjectToDelete?',
          buttons: const {
            Strings.cancel: false,
            Strings.delete: true,
          },
        );

}
