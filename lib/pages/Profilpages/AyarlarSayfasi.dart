import 'package:flutter/material.dart';


class AyarlarVeTemaSayfasi extends StatefulWidget {
  @override
  _AyarlarVeTemaSayfasiState createState() => _AyarlarVeTemaSayfasiState();
}

class _AyarlarVeTemaSayfasiState extends State<AyarlarVeTemaSayfasi> {
  bool bildirimlerAcik = true; // Bildirimler için anahtarlama
  bool koyuMod = false; // Koyu mod için anahtarlama

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayarlar ve Tema'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: Text('Bildirimler'),
              subtitle: Text('Uygulama bildirimlerini aç/kapat'),
              value: bildirimlerAcik,
              onChanged: (newValue) {
                setState(() {
                  bildirimlerAcik = newValue;
                });
                // Bildirim ayarları burada güncellenebilir.
              },
            ),
            SwitchListTile(
              title: Text('Koyu Mod'),
              subtitle: Text('Uygulama temasını koyu moda çevir'),
              value: koyuMod,
              onChanged: (newValue) {
                setState(() {
                  koyuMod = newValue;
                });

                // Tema modunu güncelle
                ThemeMode yeniTemaModu =
                koyuMod ? ThemeMode.dark : ThemeMode.light;
              },
            ),
            ListTile(
              title: Text('Hesap Ayarları'),
              subtitle: Text('Hesap bilgilerinizi yönetin'),
              leading: Icon(Icons.account_circle),
              onTap: () {
                // Hesap ayarları sayfasına yönlendirme eklemek için kullanılabilir.
              },
            ),
            // Eklemek istediğiniz diğer ayarlar buraya eklenebilir.
          ],
        ),
      ),
    );
  }
}
