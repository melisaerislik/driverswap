import 'package:flutter/material.dart';

class AdreslerSayfasi extends StatelessWidget {
  const AdreslerSayfasi({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adresler Sayfası'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Otobüs Hatları ve Saatleri',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  buildBusScheduleTile('Hat 1/a', '10:00 - 11:30'),
                  buildBusScheduleTile('Hat 2/b', '12:00 - 13:30'),
                  buildBusScheduleTile('Hat 3/c', '14:00 - 15:30'),
                  buildBusScheduleTile('Hat 4/a', '10:00 - 11:30'),
                  buildBusScheduleTile('Hat 3/a', '10:00 - 11:30'),
                  buildBusScheduleTile('Hat 2/a', '10:00 - 11:30'),
                  // Eklemek istediğiniz diğer hatlar ve saatler buraya eklenebilir.
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBusScheduleTile(String hat, String saat) {
    return ListTile(
      title: Text(hat),
      subtitle: Text('Saat: $saat'),
      leading: Icon(Icons.directions_bus),
      onTap: () {
        // Eğer tıklanabilir bir işlem eklemek istiyorsanız buraya ekleyebilirsiniz.
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AdreslerSayfasi(),
  ));
}
