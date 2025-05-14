import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:registration_ieee/const/color.dart';
import 'package:registration_ieee/const/container.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  bool scan = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text("History"),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 336,
              height: 60,
              decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(6)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: InkWell(
                      onTap: () {
                        scan = true;
                        setState(() {});
                      },
                      child: Container(
                        width: 153.62831115722656,
                        height: 47.77000045776367,
                        decoration: BoxDecoration(
                          color: scan ? AppColors.primary : AppColors.black,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(
                            'Scan',
                            style: TextStyle(
                                color: AppColors.secondary, fontSize: 17),
                          ),
                        ),
                      ),

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: InkWell(
                      onTap: () {
                        scan = false;
                        setState(() {});
                      },
                      child: Container(
                        width: 153.62831115722656,
                        height: 47.77000045776367,
                        decoration: BoxDecoration(
                            color: scan ? AppColors.black : AppColors.primary,
                            borderRadius: BorderRadius.circular(6)),
                        child: Center(
                          child: Text(
                            'Attendees',
                            style: TextStyle(
                                color: AppColors.secondary, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: FutureBuilder(
                  future: Hive.openBox('user'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('Error loading data'),
                      );
                    }
                    final box = Hive.box('user');
                    final filteredUsers = box.values.where((user) {
                      return scan ? user.scanned == true : user.scanned == false;
                    }).toList();

                    if (filteredUsers.isEmpty) {
                      return const Center(child: Text('No users to show'));
                    }
                    return ListView.builder(
                      padding:  EdgeInsets.zero,
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = filteredUsers[index];
                        return InfoCard(
                          id: user.id,
                          name: user.name,
                          email: user.email,
                          phone: user.phone,
                          dateTime: user.dateTime.toString(),
                        );
                      },
                    );
                  }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}