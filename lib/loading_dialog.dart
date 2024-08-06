import 'dart:developer';

import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({
    super.key,
    String? text,
  }) : _text = text;
  final String? _text;

  static const String routePath = '/loading';

  static const String routePathWithParam = '/loadingWithParam';

  @override
  Widget build(BuildContext context) {
    log('print Loading');
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_text == null) {
        return;
      }
      if (!context.mounted) {
        return;
      }
    });
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: 180,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            12,
          ),
        ),
        child: Center(
          child: Text(
            'Loading...${_text ?? ''}',
            style: const TextStyle(
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
