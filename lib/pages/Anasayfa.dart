import 'package:driver_swap/pages/ChatScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';

import '../Model/randevu_model.dart';
import '../Service/randevu_service.dart';

void main() {
  runApp(Anasayfa());
}

class Anasayfa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> days = ['Pazartesi', 'Salı', 'Çarşamba', 'Perşembe', 'Cuma'];

  DateTime _selectedDate = DateTime.now();
  List<DateTime> _selectedDates = [];

  RandevuService randevuService = RandevuService();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        title: const Center(child: Text('DRİWERSWAP')),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/logo.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Takvim ve saat
              Column(
                children: [
                  TableCalendar(
                    firstDay: DateTime.utc(2021, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: _selectedDate,
                    selectedDayPredicate: (day) {
                      return _selectedDates.contains(day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        if (_selectedDates.contains(selectedDay)) {
                          _selectedDates.remove(selectedDay);
                        } else {
                          _selectedDates.add(selectedDay);
                        }
                      });
                    },
                  ),


                ],
              ),
              SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[200],
                ),
                onPressed: () async {
                  // Randevu ekleme
                  for (DateTime date in _selectedDates) {
                    RandevuModel yeniRandevu = RandevuModel(
                      hatNo: "1/a",
                      zaman: date,
                      guzergah: '',
                    );
                    await randevuService.randevuEkle(yeniRandevu);
                  }
                },
                child: Text('Randevu Oluştur'),
              ),
              // Kategoriler
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Günler',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: days.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 100,
                      margin: EdgeInsets.all(8),
                      color: Colors.green[300],
                      child: Center(
                        child: Text(
                          days[index],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Öne Çıkan Ürünler
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Hat ve Araçlar',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    List<String> saatBilgileri = [
                      'Sanayi 7.00\n' 'Hastane 8.30\n' 'Okul 9.15\n' 'Hastane 10.00\n' 'Sanayi 10.30\n'
                    ];
                    return Container(
                      width: 150,
                      margin: EdgeInsets.all(8),
                      color: Colors.yellow[200],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Araç $index',
                            style: TextStyle(color: Colors.black87),
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: saatBilgileri.map((saat) {
                              return Text(
                                saat,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, 'arama');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: searchUsers(query),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final users = snapshot.data!.docs;
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final userData = users[index].data() as Map<String, dynamic>;
            return ListTile(
              title: Text(userData['ad']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      receiverId: users[index].id,
                      receiverName: userData['ad'],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Arama Önerileri: $query'),
    );
  }

  Future<QuerySnapshot> searchUsers(String query) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('ad', isGreaterThanOrEqualTo: query)
        .where('ad', isLessThanOrEqualTo: query + '\uf8ff')
        .get();
  }
}