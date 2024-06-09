import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkDay {
  final DateTime date;
  final bool worked;

  WorkDay({required this.date, required this.worked});
}

class KazanilanUcret extends StatelessWidget {
  final List<WorkDay> workHistory = generateRandomWorkHistory();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kazanç Hesaplama'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              // Tıklanıldığında kazanç sayfasına geçiş yapılacak.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KazancSayfasi(workHistory: workHistory),
                ),
              );
            },
            child: Text('Günlük Kazancı Göster'),
          ),
        ),
      ),
    );
  }
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
class KazancSayfasi extends StatelessWidget {
  final List<WorkDay> workHistory;

  KazancSayfasi({required this.workHistory});

  @override
  Widget build(BuildContext context) {
    double toplamKazanc = 0;

    // Günlük kazancı hesapla
    for (var workDay in workHistory) {
      if (workDay.worked) {
        toplamKazanc += 600; // 600 lira ücret
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Günlük Kazanç'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Günlük Kazanç: $toplamKazanc Lira'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Kazanç sayfasından çıkış yap
              },
              child: Text('Geri Dön'),
            ),
          ],
        ),
      ),
    );
  }
}

