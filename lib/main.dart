import 'package:flutter/material.dart';
import 'package:driver_swap/pages/Profilpages/loginpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  runApp(MyApp());
}

//logo da pixel boyutlandırma düzenlemesi
//giriş düzenlemesi
//lokasyon izni alımı

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App Title',
      theme: ThemeData(
        // Your theme data
      ),
      home: LocationScreen(), // LocationScreen burada başlangıç ekranı olarak belirlendi
    );
  }
}

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }
  _getCurrentLocation() async {
    final GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
    try {
      // Konum izni kontrolü yapılıyor
      var locationStatus = await Permission.location.status;
      var cameraStatus = await Permission.camera.status;

      if (locationStatus.isGranted && cameraStatus.isGranted) {
        Position position = await geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        setState(() {
          _currentPosition = position;
        });
      } else {
        // Konum veya kamera izni verilmemişse, izin isteniyor
        if (!locationStatus.isGranted) {
          await Permission.location.request();
        }
        if (!cameraStatus.isGranted) {
          await Permission.camera.request();
        }
      }
    } catch (e) {
      print("Konum alınamadı: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
           WelcomeScreen() // Konum alındıktan sonra WelcomeScreen'e geçiş yapılıyor

    );
  }
}


class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffFED93E),
              Color(0xff4CAF50),
            ],
          ),
        ),
        child: Column(
          children: [
             Padding(
              padding: EdgeInsets.only(top: 100.0),
              child: Image.asset('assets/logom.png'),
            ),
            const SizedBox(
              height: 100,
            ),
            const Text(
              'HOŞGELDİNİZ',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const loginScreen()),
                );
              },
              child: Container(
                height: 53,
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white),
                ),
                child: const Center(
                  child: Text(
                    'GİRİŞ YAP',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                // Here, you can navigate to your login screen or any other screen you want
                // Just replace the code inside MaterialPageRoute
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
              child: Container(
                height: 53,
                width: 320,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white),
                ),
                child: const Center(
                  child: Text(
                    'KAYIT OL',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            const Text(
              'Sosyal Medya İle Giriş',
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                width: 50,
                height: 50,
                child: Image.asset(
                  'assets/sociall.png',
                  fit: BoxFit.cover, // Ölçekleme yöntemini belirler
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
