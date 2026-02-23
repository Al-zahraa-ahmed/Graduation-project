
import 'package:flutter/material.dart';

class buildListTile extends StatelessWidget {
  const buildListTile({super.key, required this.icon, required this.title, this.ontap});
  final IconData icon;
  final String title;
  final void Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      leading: Icon(icon),
      title: Text(title, style: TextStyle(fontSize: 16)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xff666666),
      ),
      onTap: ontap,
    );
  }
}
