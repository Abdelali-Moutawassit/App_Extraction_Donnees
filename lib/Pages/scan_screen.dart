import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:adria_kyc_integration/adria_kyc_integration.dart';

class ScanScreen extends StatefulWidget {
  final String method; // Méthode choisie par l'utilisateur : 'old', 'new'

  const ScanScreen({super.key, required this.method});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final AdriaKycIntegration kyc = AdriaKycIntegration();
  Map<String, dynamic>? scanResult;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _startScan();
  }

  Future<void> _startScan() async {
    Map<String, dynamic>? result;

    if (widget.method == 'old') {
      result = await kyc.scanOldCin();
    } else if (widget.method == 'new') {
      result = await kyc.scanNewCin();
    }

    setState(() {
      scanResult = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'images/image.png',
              fit: BoxFit.cover,
            ),
          ),

          // Glassmorphism overlay
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.4),
          ),

          // Back button
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

          // Result card
          SafeArea(
            child: Center(
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : scanResult != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 15,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(Icons.perm_identity,
                                          color: Colors.white, size: 28),
                                      SizedBox(width: 10),
                                      Text(
                                        'Carte d\'Identité',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.white54,
                                    thickness: 1,
                                    height: 25,
                                  ),
                                  ...scanResult!.entries.map((entry) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              "${entry.key}",
                                              style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Text(
                                              "${entry.value}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const Text(
                          'Échec du scan',
                          style: TextStyle(color: Colors.white),
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
