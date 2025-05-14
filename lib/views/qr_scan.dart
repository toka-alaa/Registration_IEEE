import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'package:registration_ieee/api_logic/api_logic.dart';
import 'package:registration_ieee/const/color.dart';

import '../user_model/user_model.dart';

class QRScanPage extends StatefulWidget {
  const QRScanPage({super.key});

  @override
  State<QRScanPage> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  final ApiService api = ApiService();
  bool scanned = false;
  MobileScannerController scannerController = MobileScannerController();
  bool torch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.secondary,

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              SizedBox(
                height: 250,
                width: 250,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),

                  child: Builder(
                    builder: (context) {
                      return Stack(
                        children: [ MobileScanner(
                          controller: scannerController,
                          onDetect: (result) async {
                            if (scanned) return;
                            scanned = true;
                            String? userId = result.barcodes.first.rawValue;
                            if (userId == null || userId.isEmpty) {
                              return;
                            }
                            await scannerController.stop();

                            String message = await api.register(userId);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                            if (message.contains("Registered successfully")) {
                              final userBox = Hive.box<UserModel>('users');
                              userBox.add(
                                UserModel(
                                  id: userId,
                                  name: "Name",
                                  email: "Email",
                                  phone: "Phone",
                                  date: DateTime.now(),
                                ),
                              );
                            }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                            if (!context.mounted) {
                              return;
                            }
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(message),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        scannerController.start();
                                      },
                                      child: const Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            ).then((onValue) {
                              scanned = false;
                            });
                          },
                        ),

                          QRScannerOverlay(
                            borderColor: AppColors.primary,
                            borderStrokeWidth: 18,
                            borderRadius: 22,
                            scanAreaWidth: 250,
                            scanAreaHeight: 250,
                          )
                      ],
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 120),
              Container(
                width: 180,
                height: 40,
                decoration: BoxDecoration(
                    color: AppColors.success,
                    borderRadius: BorderRadius.circular(6)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          scannerController.toggleTorch();
                          setState(() {
                            torch = !torch;
                          });
                        },
                        icon: Icon(
                          torch ? Icons.flash_on : Icons.flash_off,
                          color: AppColors.secondary,
                        )),
                    SizedBox(width: 50),
                    IconButton(
                        onPressed: () {
                          scannerController.switchCamera();
                        },
                        icon: Icon(
                          Icons.cameraswitch_sharp,
                          color: AppColors.secondary,
                        ))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
