

class BarcodeDetailsScreen extends StatelessWidget {
  final String barcodeValue;
  final Uint8List? capturedImage;

  BarcodeDetailsScreen({
    required this.barcodeValue,
    required this.capturedImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Barcode Details')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Barcode Value: $barcodeValue'),
            if (capturedImage != null)
              Image.memory(
                capturedImage!,
                width: 200,
                height: 200,
              ),
          ],
        ),
      ),
    );
  }
}