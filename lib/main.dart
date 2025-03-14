import 'package:flutter/material.dart';
import 'widgets/reusable_card.dart';

void main() {
  runApp(const BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const BMICalculatorScreen(),
    );
  }
}

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({Key? key}) : super(key: key);

  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  double? bmi;
  String bmiCategory = '';
  String errorMessage = '';

  void calculateBMI() {
    setState(() {
      errorMessage = '';
    });
    final String heightText = heightController.text;
    final String weightText = weightController.text;
    if (heightText.isEmpty || weightText.isEmpty) {
      setState(() {
        errorMessage = 'Vui lòng nhập đầy đủ dữ liệu!';
      });
      return;
    }
    final double? height = double.tryParse(heightText);
    final double? weight = double.tryParse(weightText);
    if (height == null || weight == null || height <= 0 || weight <= 0) {
      setState(() {
        errorMessage = 'Dữ liệu không hợp lệ. Vui lòng nhập số dương!';
      });
      return;
    }
    setState(() {
      bmi = weight / (height * height);
      bmiCategory = getBMICategory(bmi!);
    });
  }

  String getBMICategory(double bmiValue) {
    if (bmiValue < 18.5) {
      return 'Gầy';
    } else if (bmiValue < 24.9) {
      return 'Bình thường';
    } else if (bmiValue < 29.9) {
      return 'Thừa cân';
    } else {
      return 'Béo phì';
    }
  }

  void resetFields() {
    heightController.clear();
    weightController.clear();
    setState(() {
      bmi = null;
      bmiCategory = '';
      errorMessage = '';
    });
  }

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8E24AA), Color(0xFFD81B60)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: heightController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          labelText: 'Chiều cao (m)',
                          prefixIcon: Icon(Icons.height),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: weightController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          labelText: 'Cân nặng (kg)',
                          prefixIcon: Icon(Icons.fitness_center),
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (errorMessage.isNotEmpty)
                        Text(
                          errorMessage,
                          style: const TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              ReusableCard(
                color: Colors.deepOrangeAccent,
                onTap: calculateBMI,
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'Tính BMI',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              if (bmi != null)
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          'Chỉ số BMI: ${bmi!.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Phân loại: $bmiCategory',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 30),

              ElevatedButton.icon(
                onPressed: resetFields,
                icon: const Icon(Icons.refresh),
                label: const Text('Làm mới'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}