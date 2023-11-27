import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const BorderRadiusApp());
}

class BorderRadiusApp extends StatelessWidget {
  const BorderRadiusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BorderRadius Previewer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BorderRadiusScreen(),
    );
  }
}

class BorderRadiusScreen extends StatefulWidget {
  const BorderRadiusScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BorderRadiusScreenState createState() => _BorderRadiusScreenState();
}

class _BorderRadiusScreenState extends State<BorderRadiusScreen> {
  double topLeftRadius = 0.0;
  double topRightRadius = 0.0;
  double bottomLeftRadius = 0.0;
  double bottomRightRadius = 0.0;

  void _updateBorderRadius(double newValue, String position) {
    setState(() {
      switch (position) {
        case 'topLeft':
          topLeftRadius = newValue;
          break;
        case 'topRight':
          topRightRadius = newValue;
          break;
        case 'bottomLeft':
          bottomLeftRadius = newValue;
          break;
        case 'bottomRight':
          bottomRightRadius = newValue;
          break;
      }
    });
  }

  String _getCssCode() {
    return """
      border-radius: ${topLeftRadius}px ${topRightRadius}px ${bottomLeftRadius}px ${bottomRightRadius}px;
    """;
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _getCssCode()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('CSS code copied to clipboard'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BorderRadius Previewer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(topLeftRadius),
                  topRight: Radius.circular(topRightRadius),
                  bottomLeft: Radius.circular(bottomLeftRadius),
                  bottomRight: Radius.circular(bottomRightRadius),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSlider('topLeft', topLeftRadius),
                _buildSlider('topRight', topRightRadius),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSlider('bottomLeft', bottomLeftRadius),
                _buildSlider('bottomRight', bottomRightRadius),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _copyToClipboard,
              child: const Text('Copy CSS to Clipboard'),
            ),
            const SizedBox(height: 20),
            const Text('CSS Code:'),
            SelectableText(
              _getCssCode(),
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider(String position, double value) {
    return Column(
      children: [
        Text(position),
        Slider(
          value: value,
          onChanged: (newValue) {
            _updateBorderRadius(newValue, position);
          },
          min: 0.0,
          max: 100.0, // You can adjust the max value as needed
        ),
        Text(value.toStringAsFixed(2)),
      ],
    );
  }
}
