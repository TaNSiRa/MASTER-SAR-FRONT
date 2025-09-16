// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ConfirmationDialog {
  static Future<bool?> show(
    BuildContext context, {
    String? title,
    String? content,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool barrierDismissible = false,
    Color? confirmButtonColor,
    Color? cancelButtonColor,
    IconData? icon,
    Color? iconColor,
    TextStyle? titleStyle,
    TextStyle? contentStyle,
  }) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: iconColor ?? Theme.of(context).primaryColor,
                  size: 24,
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  title ?? 'ยืนยันการดำเนินการ',
                  style: titleStyle ??
                      Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                ),
              ),
            ],
          ),
          content: content != null
              ? Text(
                  content,
                  style: contentStyle ?? Theme.of(context).textTheme.bodyMedium,
                )
              : null,
          contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
          actionsPadding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: cancelButtonColor ?? Theme.of(context).textTheme.bodyMedium?.color,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(cancelText ?? 'ยกเลิก'),
              onPressed: () {
                onCancel?.call();
                Navigator.of(context).pop(false);
              },
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: confirmButtonColor ?? Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 2,
              ),
              child: Text(confirmText ?? 'ยืนยัน'),
              onPressed: () {
                onConfirm?.call();
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  static Future<bool?> showDelete(
    BuildContext context, {
    String? title,
    String? content,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return show(
      context,
      title: title ?? 'ลบข้อมูล',
      content: content ?? 'คุณต้องการลบข้อมูลนี้หรือไม่?',
      confirmText: 'ลบ',
      cancelText: 'ยกเลิก',
      confirmButtonColor: Colors.red,
      icon: Icons.delete_outline,
      iconColor: Colors.red,
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }

  static Future<bool?> showSave(
    BuildContext context, {
    String? title,
    String? content,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return show(
      context,
      title: title ?? 'บันทึกข้อมูล',
      content: content ?? 'คุณต้องการบันทึกข้อมูลนี้หรือไม่?',
      confirmText: 'บันทึก',
      cancelText: 'ยกเลิก',
      confirmButtonColor: Colors.green,
      icon: Icons.save_outlined,
      iconColor: Colors.green,
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }

  static Future<bool?> showLogout(
    BuildContext context, {
    String? title,
    String? content,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return show(
      context,
      title: title ?? 'ออกจากระบบ',
      content: content ?? 'คุณต้องการออกจากระบบหรือไม่?',
      confirmText: 'ออกจากระบบ',
      cancelText: 'ยกเลิก',
      confirmButtonColor: Colors.orange,
      icon: Icons.logout,
      iconColor: Colors.orange,
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }

  static Future<bool?> showWarning(
    BuildContext context, {
    String? title,
    String? content,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return show(
      context,
      title: title ?? 'คำเตือน',
      content: content ?? 'คุณแน่ใจหรือไม่ที่จะดำเนินการต่อ?',
      confirmText: 'ดำเนินการต่อ',
      cancelText: 'ยกเลิก',
      confirmButtonColor: Colors.amber,
      icon: Icons.warning_amber_outlined,
      iconColor: Colors.amber,
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }
}
