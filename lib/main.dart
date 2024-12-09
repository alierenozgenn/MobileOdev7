import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(OgrenciApp());

class OgrenciApp extends StatelessWidget {
  const OgrenciApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Öğrenci CRUD',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const OgrenciListesi(),
    );
  }
}

class OgrenciListesi extends StatefulWidget {
  const OgrenciListesi({Key? key}) : super(key: key);

  @override
  _OgrenciListesiState createState() => _OgrenciListesiState();
}

class _OgrenciListesiState extends State<OgrenciListesi> {
  List ogrenciler = [];

  @override
  void initState() {
    super.initState();
    fetchOgrenciler();
  }

  // Öğrencileri Getir
  Future<void> fetchOgrenciler() async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:3000/api/ogrenci')); // 10.0.2.2 kullanıldı
    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          ogrenciler = json.decode(response.body);
        });
      }
    } else {
      // Hata durumunda kullanıcıya bilgi ver
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Öğrenciler alınırken hata oluştu')));
      }
    }
  }

  // Öğrenci Sil
  Future<void> deleteOgrenci(int id) async {
    final response = await http.delete(Uri.parse(
        'http://10.0.2.2:3000/api/ogrenci/$id')); // 10.0.2.2 kullanıldı
    if (response.statusCode == 200) {
      fetchOgrenciler(); // Öğrencileri tekrar getir
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Öğrenci silinirken hata oluştu')));
      }
    }
  }

  // Öğrenci Ekle
  Future<void> addOgrenci(String ad, String soyad, int bolumID) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/api/ogrenci'), // 10.0.2.2 kullanıldı
      headers: const {'Content-Type': 'application/json'},
      body: json.encode({
        'ad': ad,
        'soyad': soyad,
        'bolumID': bolumID,
      }),
    );
    if (response.statusCode == 201) {
      fetchOgrenciler(); // Öğrencileri tekrar getir
      Navigator.pop(context); // Dialogu kapat
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Öğrenci eklenirken hata oluştu')));
      }
    }
  }

  // Öğrenci Güncelle
  Future<void> updateOgrenci(
      int id, String ad, String soyad, int bolumID) async {
    final response = await http.put(
      Uri.parse('http://10.0.2.2:3000/api/ogrenci/$id'), // 10.0.2.2 kullanıldı
      headers: const {'Content-Type': 'application/json'},
      body: json.encode({
        'ad': ad,
        'soyad': soyad,
        'bolumID': bolumID,
      }),
    );
    if (response.statusCode == 200) {
      fetchOgrenciler(); // Öğrencileri tekrar getir
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Öğrenci güncellenirken hata oluştu')));
      }
    }
  }

  // Öğrenci ekleme dialogu
  void showAddOgrenciDialog() {
    String ad = '', soyad = '';
    int bolumID = 1; // Varsayılan bölüm ID
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Yeni Öğrenci Ekle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => ad = value,
                decoration: const InputDecoration(labelText: 'Ad'),
              ),
              TextField(
                onChanged: (value) => soyad = value,
                decoration: const InputDecoration(labelText: 'Soyad'),
              ),
              TextField(
                onChanged: (value) => bolumID = int.tryParse(value) ?? 1,
                decoration: const InputDecoration(labelText: 'Bölüm ID'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                addOgrenci(ad, soyad, bolumID);
              },
              child: const Text('Ekle'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('İptal'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Öğrenci Listesi')),
      body: ListView.builder(
        itemCount: ogrenciler.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
                '${ogrenciler[index]['ad']} ${ogrenciler[index]['soyad']}'),
            subtitle: Text('Bölüm ID: ${ogrenciler[index]['bolumID']}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => deleteOgrenci(ogrenciler[index]['ogrenciID']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            showAddOgrenciDialog, // Öğrenci ekleme butonuna tıklandığında dialog açılır
        child: const Icon(Icons.add),
      ),
    );
  }
}
