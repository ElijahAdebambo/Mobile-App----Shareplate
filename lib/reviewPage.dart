import 'package:flutter/material.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';

// implemented using pub.dev barcode scanner
class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  String? code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Page'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Scan the QR code to leave your feedback!'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
                        context: context,
                        onCode: (scannedCode) {
                          setState(() {
                            code = scannedCode;
                          });
                        },
                      );
                    },
                    child: Text(code ?? "Scan QR/Barcode"),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Community Reviews',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  _buildReviewWidget(
                    title: 'The Trussell Trust Food Bank',
                    reviewer: 'Review by Alex J.',
                    rating: '★★★★★',
                    comment: "I recently visited The Trussell Trust Food Bank, and I was deeply moved by the dedication and warmth of the volunteers there. They not only provided essential food items but also offered a listening ear to those in need. The organization is well-organized, and their efforts to combat hunger are truly commendable. Highly recommended for both donors and those in need of assistance.",

                  ),
                  _buildReviewWidget(
                    title: 'Raleigh Street Food Bank',
                    reviewer: 'Review by Samantha D.',
                    rating: '★★★★☆',
                    comment: "Raleigh Street Food Bank offers a vital service to the community. During my visit, I noticed a wide variety of food items available, ensuring nutritional needs are met. The staff was friendly and respectful, making the process dignified for everyone. A four-star rating only because I believe there's always room for growth, particularly in expanding their reach.",
                  ),
                  _buildReviewWidget(
                    title: 'Himmah Food Bank',
                    reviewer: 'Review by Chris L.',
                    rating: '★★★★★',
                    comment: "Himmah Food Bank is a beacon of hope in tough times. Their commitment to serving everyone, regardless of background, is admirable. The food parcels are well-packed, and they even include fresh produce, which is a big plus. The volunteers make a significant effort to ensure privacy and respect during the distribution process.",
                  ),
                  _buildReviewWidget(
                    title: 'Rushcliffe Food Bank/Church',
                    reviewer: 'Review by Jordan K.',
                    rating: '★★★★☆',
                    comment: "Rushcliffe Food Bank/Church plays a crucial role in supporting the local community. The volunteers are genuinely caring and go above and beyond to help. My visit was met with kindness and efficiency. The reason for a four-star review is the occasional shortage of certain items, but given the demand, the bank does an incredible job.",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewWidget({required String title, required String reviewer, required String rating, required String comment}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.account_circle, size: 24), // User icon
              SizedBox(width: 8),
              Text(reviewer, style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
            ],
          ),
          SizedBox(height: 4),
          Text(rating, style: const TextStyle(fontSize: 16)),
          SizedBox(height: 4),
          Text(comment),
          const Divider(),
        ],
      ),
    );
  }
}
