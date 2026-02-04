import 'package:flutter/material.dart';

class LeftMenu extends StatelessWidget {
  const LeftMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      color: Colors.grey.shade100,
      child: SafeArea(
        child: ListView(
          children: const [
            _MenuHeader(),
            _MenuItem(icon: Icons.account_balance, label: 'Bancos'),
            _MenuItem(icon: Icons.payments, label: 'Cheques'),
            _MenuItem(icon: Icons.credit_card, label: 'Tarjetas'),
            _MenuItem(icon: Icons.receipt_long, label: 'Cobros'),
            _MenuItem(icon: Icons.book, label: 'Contabilidad'),
          ],
        ),
      ),
    );
  }
}

class _MenuHeader extends StatelessWidget {
  const _MenuHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        'Menú',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MenuItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () {
        // En el futuro: cambiar dashboard por intent
        Navigator.of(context).maybePop();
      },
    );
  }
}
