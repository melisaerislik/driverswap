import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;

  ChatScreen({required this.receiverId, required this.receiverName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user;


  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // Seçilen fotoğrafın dosya yolu
      final imageFile = File(pickedImage.path);

      // Fotoğrafı mesaj olarak gönderme işlemi burada yapılabilir.
      // Örneğin, Firebase Storage'a yükleme yapılabilir ve yükleme tamamlandığında
      // elde edilen URL'i Firestore'a kaydedebilirsiniz.
    }
  }

  Future<void> _sendLocation() async {
    Position position = await _determinePosition();
    String locationUrl = '${position.latitude},${position.longitude}';

    _firestore.collection('messages').add({
      'text': locationUrl,
      'latitude': position.latitude,
      'longitude': position.longitude,
      'senderId': user?.uid,
      'receiverId': widget.receiverId,
      'timestamp': FieldValue.serverTimestamp(),
    });
    _messageController.clear();
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      _firestore.collection('messages').add({
        'text': _messageController.text,
        'senderId': user?.uid,
        'receiverId': widget.receiverId,
        'timestamp': FieldValue.serverTimestamp(),
      });
      _messageController.clear();
    }
  }

  Stream<List<Map<String, dynamic>>> _getMessages() {
    var sentMessages = _firestore
        .collection('messages')
        .where('senderId', isEqualTo: user?.uid)
        .where('receiverId', isEqualTo: widget.receiverId)
        .orderBy('timestamp', descending: true)
        .snapshots();

    var receivedMessages = _firestore
        .collection('messages')
        .where('senderId', isEqualTo: widget.receiverId)
        .where('receiverId', isEqualTo: user?.uid)
        .orderBy('timestamp', descending: true)
        .snapshots();

    return Rx.combineLatest2(
      sentMessages,
      receivedMessages,
          (QuerySnapshot sentSnapshot, QuerySnapshot receivedSnapshot) {
        var messages = <Map<String, dynamic>>[];

        for (var doc in sentSnapshot.docs) {
          messages.add(doc.data() as Map<String, dynamic>);
        }

        for (var doc in receivedSnapshot.docs) {
          messages.add(doc.data() as Map<String, dynamic>);
        }

        messages.sort((a, b) {
          return (b['timestamp'] as Timestamp).compareTo(a['timestamp'] as Timestamp);
        });

        return messages;
      },
    );
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.receiverName} ile görüşüyorsunuz'),

      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _getMessages(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                var messages = snapshot.data!;
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];
                    var messageText = message['text'];
                    var latitude = message['latitude'];
                    var longitude = message['longitude'];
                    var messageSender = message['senderId'];
                    return ListTile(
                      title: Text(messageSender == user?.uid ? 'Siz' : widget.receiverName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(messageText),
                          if (latitude != null && longitude != null)
                            Container(
                              height: 200,
                              child: FlutterMap(
                                options: MapOptions(
                                  center: LatLng(latitude, longitude),
                                  zoom: 15.0,
                                ),
                                children: [
                                  TileLayer(
                                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                    subdomains: ['a', 'b', 'c'],
                                  ),
                                  MarkerLayer(
                                    markers: [
                                      Marker(
                                        width: 80.0,
                                        height: 80.0,
                                        point: LatLng(latitude, longitude),
                                        builder: (ctx) => Container(
                                          child: Icon(Icons.location_on, color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Type Message Here...',
                      hintStyle: TextStyle(
                        color: Colors.black12,
                      ),
                      prefixIcon: Icon(Icons.emoji_emotions),
                      suffixIcon: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: InkWell(
                              onTap: _sendLocation,
                              child: Icon(Icons.location_city),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: InkWell(
                              onTap: _pickImage,
                              child: Icon(Icons.camera_alt),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: InkWell(
                              onTap: () {
                                print('Mic Icon Pressed');
                              },
                              child: Icon(Icons.mic),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
