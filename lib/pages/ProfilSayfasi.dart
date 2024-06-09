import 'package:flutter/material.dart';
import 'Profilpages/AdreslerSayfasi.dart';
import 'Profilpages/AyarlarSayfasi.dart';
import 'Profilpages/CalismaSaatleriSayfasi.dart';
import 'Profilpages/KazanilanUcretSayfasi.dart';
import 'Profilpages/SurusGecmisiSayfasi.dart';

class ProfilSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: MyProfilePage(),
    );
  }
}

class MyProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[100],
        title: const Text('Profil'),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/images/logo.png'),
                fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Kullanıcı Bilgileri
              InkWell(
                onTap: () {
                  // Kullanıcı bilgileri sayfasına git
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilSayfasi(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(''),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Kullanıcı Adı',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'kullanici@mail.com',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              // Sürüş Geçmişi
              ListTile(
                title: const Text('Sürüş Geçmişi'),
                leading: const Icon(Icons.drive_eta_outlined),
                onTap: () {
                  // Sürüş geçmişi sayfasına git
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SurusGecmisSayfasi(),
                    ),
                  );
                },
              ),
              // Çalışma Saatleri
              ListTile(
                title: const Text('Çalışma Saatleri'),
                leading: const Icon(Icons.work),
                onTap: () {
                  // Çalışma saatleri sayfasına git
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CalismaSaatleriSayfasi(),
                    ),
                  );
                },
              ),
              // Adresler
              ListTile(
                title: const Text('Adresler'),
                leading: const Icon(Icons.location_on),
                onTap: () {
                  // Adresler sayfasına git
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdreslerSayfasi(),
                    ),
                  );
                },
              ),
              // Kazanılan Ücret
              ListTile(
                title: const Text('Kazanılan Ücret'),
                leading: const Icon(Icons.money),
                onTap: () {
                  // Kazanılan ücret sayfasına git
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KazancSayfasi(workHistory: [],),
                    ),
                  );
                },
              ),
              // Ayarlar
              ListTile(
                title: const Text('Ayarlar'),
                leading: const Icon(Icons.settings),
                onTap: () {
                  // Ayarlar sayfasına git
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AyarlarVeTemaSayfasi(),
                    ),
                  );
                },
              ),
              // Çıkış Yap
              ListTile(
                title: const Text('Çıkış Yap'),
                leading: const Icon(Icons.exit_to_app),
                onTap: () {
                  // Çıkış yap
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
