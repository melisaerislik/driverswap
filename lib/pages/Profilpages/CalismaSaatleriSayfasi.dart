import 'package:driver_swap/Model/randevu_model.dart';
import 'package:driver_swap/Service/randevu_service.dart';
import 'package:flutter/material.dart';

class CalismaSaatleriSayfasi extends StatefulWidget {

  const CalismaSaatleriSayfasi({super.key});

  @override
  State<CalismaSaatleriSayfasi> createState() => _CalismaSaatleriSayfasiState();
}

class _CalismaSaatleriSayfasiState extends State<CalismaSaatleriSayfasi> {
  RandevuService _randevuService = RandevuService();

  @override

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<List<RandevuModel>>(
        stream: _randevuService.randevuListele(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Hata oluştu: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('Hiç randevu bulunamadı.');
          } else {
            List<RandevuModel> appointments = snapshot.data!;
            return ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                RandevuModel appointment = appointments[index];
                return ListTile(
                  title: Text(appointment.guzergah ?? '') ,

                  trailing: Text(appointment.zaman?.toString() ?? ''),
                  subtitle:Text(appointment.hatNo ?? ''),
                  leading: IconButton(
                    onPressed: () {
                      //_appointmentService.deleteAppointment());
                    }, icon: Icon(Icons.cancel),

                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
