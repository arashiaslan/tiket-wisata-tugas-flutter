import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../dialogs/add_ticket_dialog.dart';
import '../models/product_model.dart';
import '../widgets/ticket_card.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Tiket'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const AddTicketDialog(),
              );
            },
            icon: Assets.icons.plus.svg(),
          ),
          const SpaceWidth(8.0),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        itemCount: products.length,
        separatorBuilder: (context, index) => const SpaceHeight(20.0),
        itemBuilder: (context, index) => TicketCard(
          item: products[index],
        ),
      ),
    );
  }
}
