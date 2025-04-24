import 'package:flutter/material.dart';
import 'package:adria_app_styles/Pages/scan_screen.dart';
import 'package:adria_app_styles/Pages/scan_face_screen.dart';
import '../Widgets/build_scan_button.dart';

class MethodChoiceScreen extends StatelessWidget {
  const MethodChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Center(
              child: Image.asset(
                'images/image.png',
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Dark Overlay
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.5),
          ),

          Positioned(
            top: 45,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child:
                    const Icon(Icons.arrow_back, color: Colors.white, size: 24),
              ),
            ),
          ),

          // Content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BuildScanButton(
                  context,
                  label: 'Ancienne carte d\'identité',
                  icon: Icons.credit_card, // ou autre selon ta logique
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScanScreen(method: 'old'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                BuildScanButton(
                  context,
                  label: 'Nouvelle carte d\'identité',
                  icon: Icons.contact_mail, // ou un autre qui représente bien
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScanScreen(method: 'new'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                BuildScanButton(
                  context,
                  label: 'Reconnaissance faciale',
                  icon: Icons.face,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScanFaceScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  }
