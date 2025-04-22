import 'package:flutter/material.dart';
import 'package:frontend/data/datasources/auth_local_datasource.dart';

import '../../../../core/core.dart';
import '../../intro/login_page.dart';

class LogoutTicketDialog extends StatefulWidget {
  const LogoutTicketDialog({super.key});

  @override
  State<LogoutTicketDialog> createState() => _LogoutTicketDialogState();
}

class _LogoutTicketDialogState extends State<LogoutTicketDialog> {
  final _local = AuthLocalDatasource();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Logout',
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SpaceHeight(12.0),
          Text(
            'Apakah anda yakin untuk keluar dari aplikasi QuicTix?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              color: AppColors.black.withOpacity(0.65),
            ),
          ),
          const SpaceHeight(20.0),
          Row(
            children: [
              Flexible(
                child: Button.filled(
                  onPressed: () {
                    Navigator.pop(context); // Tutup dialog
                  },
                  label: 'Batalkan',
                  borderRadius: 8.0,
                  color: AppColors.buttonCancel,
                  textColor: AppColors.grey,
                  height: 44.0,
                  fontSize: 14.0,
                ),
              ),
              const SpaceWidth(12.0),
              Flexible(
                child: Button.filled(
                  onPressed: () async {
                    await _local.logout(); // Hapus token
                    if (mounted) {
                      context.pushAndRemoveUntil(const LoginPage(), (route) => false);
                    }
                  },
                  label: 'Logout',
                  borderRadius: 8.0,
                  height: 44.0,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
