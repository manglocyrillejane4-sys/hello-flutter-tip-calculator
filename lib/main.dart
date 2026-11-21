
import 'package:flutter/material.dart';

void main() {
  runApp(const TipApp());
}

double? parseBill(String input) =>
    double.tryParse(input.trim());

({double tip, double total}) computeTip(
    double bill, int percent) {
  final tip = bill * percent / 100;
  return (tip: tip, total: bill + tip);
}

class TipApp extends StatelessWidget {
  const TipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const TipPage(),
    );
  }
}

class TipPage extends StatefulWidget {
  const TipPage({super.key});

  @override
  State<TipPage> createState() => _TipPageState();
}

class _TipPageState extends State<TipPage> {
  final TextEditingController billController =
      TextEditingController();

  int selectedPercent = 15;

  @override
  void dispose() {
    billController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bill = parseBill(billController.text);
    final validBill =
        bill != null && bill.isFinite && bill >= 0;

    final result = validBill
        ? computeTip(bill, selectedPercent)
        : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tip Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter Bill Amount',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: billController,
              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                prefixText: '₱ ',
                hintText: 'Enter amount',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 25),
            const Text(
              'Select Tip Percentage',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: [10, 15, 20].map((percent) {
                return ChoiceChip(
                  label: Text('$percent%'),
                  selected: selectedPercent == percent,
                  onSelected: (selected) {
                    setState(() {
                      selectedPercent = percent;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            if (!validBill)
              const Text(
                'Enter a valid amount',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              )
            else ...[
              Text(
                'Tip: ₱${result!.tip.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 15),
              Text(
                'Total: ₱${result.total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
