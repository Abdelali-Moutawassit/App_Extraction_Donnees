import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:adria_kyc_integration/adria_kyc_integration.dart';

class ScanScreen extends StatefulWidget {
  final String method;

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
    setState(() {
      isLoading = true;
      scanResult = null;
    });

    Map<String, dynamic>? result;

    try {
      if (widget.method == 'old') {
        result = await kyc.scanOldCin();
      } else if (widget.method == 'new') {
        result = await kyc.scanNewCin();
      }
    } catch (e) {
      result = null;
    }

    setState(() {
      scanResult = result;
      isLoading = false;
    });

    if (result == null) {
      _showScanErrorDialog();
    }
  }

  void _showScanErrorDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red, size: 28),
                        SizedBox(width: 10),
                        Text(
                          'Échec du scan',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Une erreur est survenue lors du scan de la carte. Veuillez réessayer.',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _startScan();
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blueAccent.withOpacity(0.8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                          ),
                          child: const Text(
                            'Réessayer',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .pop();
                          },
                          child: const Text(
                            'Annuler',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'images/image.png',
              fit: BoxFit.cover,
            ),
          ),

          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.4),
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
                child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
              ),
            ),
          ),

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
                                      padding: const EdgeInsets.symmetric(vertical: 6),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
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
                      : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}