import 'package:flutter/material.dart';
import 'color.dart';

class InfoCard extends StatelessWidget {

  final String id;
  final String name;
  final String email;
  final String phone;
  final String dateTime;

  const InfoCard({super.key, required this.id, required this.name, required this.email, required this.phone, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.qr_code,
            size: 40,
            color: AppColors.secondary,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("ID: 1223456789",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary)),
                const SizedBox(height: 8),
                const Text("Name:", style: TextStyle(color: AppColors.success)),
                const Text("Email:",
                    style: TextStyle(color: AppColors.success)),
                const Text("Phone:",
                    style: TextStyle(color: AppColors.success)),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "16 Dec 2022, 9:30 pm",
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}