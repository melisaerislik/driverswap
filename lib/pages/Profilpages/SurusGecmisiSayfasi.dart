import 'package:flutter/material.dart';
import 'dart:math';

class SurusGecmisSayfasi extends StatelessWidget {
  const SurusGecmisSayfasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<WorkDay> workHistory = generateRandomWorkHistory();

    return Scaffold(
      appBar: AppBar(
        title: Text('Sürüş Geçmişi'),
      ),
      body: ListView.builder(
        itemCount: workHistory.length,
        itemBuilder: (context, index) {
          final workDay = workHistory[index];
          return ListTile(
            title: Text('Tarih: ${workDay.date.day}/${workDay.date.month}/${workDay.date.year}'),
            subtitle: Text('Çalışıldı: ${workDay.worked ? 'Evet' : 'Hayır'}'),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SurusGecmisSayfasi(),
  ));
}

class WorkDay {
  final DateTime date;
  final bool worked;

  WorkDay({required this.date, required this.worked});
}

List<WorkDay> generateRandomWorkHistory() {
  final List<WorkDay> workHistory = [];
  final Random random = Random();

  // Simülasyon amacıyla son 30 günü kapsayan rastgele bir çalışma geçmişi oluşturuyoruz.
  final DateTime currentDate = DateTime.now();
  for (int i = 0; i < 30; i++) {
    final DateTime randomDate = currentDate.subtract(Duration(days: i));
    final bool randomWorked = random.nextBool();
    workHistory.add(WorkDay(date: randomDate, worked: randomWorked));
  }

  return workHistory;
}
