import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => RgbColorProvider(),
      child: const MyApp(),
    ),
  );
}

class RgbColorProvider extends ChangeNotifier {
  int _red = 50;
  int _green = 203;
  int _blue = 230;

  int get red => _red;
  int get green => _green;
  int get blue => _blue;

  Color get currentColor => Color.fromRGBO(_red, _green, _blue, 1.0);

  void setRed(double value) {
    _red = value.round();
    notifyListeners();
  }

  void setGreen(double value) {
    _green = value.round();
    notifyListeners();
  }

  void setBlue(double value) {
    _blue = value.round();
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RGB Color Picker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RgbPickerScreen(),
    );
  }
}

class RgbPickerScreen extends StatelessWidget {
  const RgbPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Andrii Moisiiuk KN-32 Lab12'),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColorPreviewContainer(),
            SizedBox(height: 60),
            RgbSlidersSection(),
          ],
        ),
      ),
    );
  }
}

class ColorPreviewContainer extends StatelessWidget {
  const ColorPreviewContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentColor = context.watch<RgbColorProvider>().currentColor;

    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: currentColor,
      ),
    );
  }
}

class RgbSlidersSection extends StatelessWidget {
  const RgbSlidersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorProvider = context.watch<RgbColorProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSingleSlider(
          label: 'Red',
          value: colorProvider.red,
          onChanged: (val) => context.read<RgbColorProvider>().setRed(val),
        ),
        const SizedBox(height: 12),
        _buildSingleSlider(
          label: 'Green',
          value: colorProvider.green,
          onChanged: (val) => context.read<RgbColorProvider>().setGreen(val),
        ),
        const SizedBox(height: 12),
        _buildSingleSlider(
          label: 'Blue',
          value: colorProvider.blue,
          onChanged: (val) => context.read<RgbColorProvider>().setBlue(val),
        ),
      ],
    );
  }

  Widget _buildSingleSlider({
    required String label,
    required int value,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black87, fontSize: 14),
              children: [
                TextSpan(text: '$label: '),
                TextSpan(
                  text: '$value',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        Slider(
          value: value.toDouble(),
          min: 0,
          max: 255,
          onChanged: onChanged,
        ),
      ],
    );
  }
}