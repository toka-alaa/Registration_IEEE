import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:registration_ieee/const/color.dart';
import 'package:registration_ieee/const/container.dart';

class Absentees extends StatelessWidget {
  const Absentees({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        title: const Text("Absent Users"),
      ),
      body: FutureBuilder(
        future: Hive.openBox('user'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          }

          final box = Hive.box('user');
          final absentUsers = box.values.where((user) => user.scanned == false).toList();

          if (absentUsers.isEmpty) {
            return const Center(child: Text('No absent users'));
          }

          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: absentUsers.length,
            itemBuilder: (context, index) {
              final user = absentUsers[index];
              return InfoCard(
                id: user.id,
                name: user.name,
                email: user.email,
                phone: user.phone,
                dateTime: user.dateTime.toString(),
              );
            },
          );
        },
      ),
    );
  }
}
