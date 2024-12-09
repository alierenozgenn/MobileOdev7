const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const app = express();
app.use(cors());
app.use(express.json());

// MySQL bağlantısı
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root', // MySQL kullanıcı adı
  password: 'alieren', // MySQL şifresi
  database: 'ogrenci_db', // Veritabanı adı
});

db.connect((err) => {
  if (err) {
    console.error('MySQL bağlantı hatası:', err);
    return;
  }
  console.log('MySQL bağlantısı başarılı!');
});

// Öğrenci CRUD işlemleri

// Öğrencileri listele
app.get('/api/ogrenci', (req, res) => {
  db.query('SELECT * FROM ogrenci', (err, results) => {
    if (err) {
      console.error(err);
      return res.status(500).send('Veri alınırken bir hata oluştu.');
    }
    res.json(results);
  });
});

// Öğrenci ekle
app.post('/api/ogrenci', (req, res) => {
  const { ad, soyad, bolumID } = req.body;
  const query = 'INSERT INTO ogrenci (ad, soyad, bolumID) VALUES (?, ?, ?)';
  db.query(query, [ad, soyad, bolumID], (err, result) => {
    if (err) {
      console.error(err);
      return res.status(500).send('Öğrenci eklenirken bir hata oluştu.');
    }
    res.status(201).json({ message: 'Öğrenci başarıyla eklendi.' });
  });
});

// Öğrenci sil
app.delete('/api/ogrenci/:id', (req, res) => {
  const { id } = req.params;
  const query = 'DELETE FROM ogrenci WHERE ogrenciID = ?';
  db.query(query, [id], (err, result) => {
    if (err) {
      console.error(err);
      return res.status(500).send('Öğrenci silinirken bir hata oluştu.');
    }
    res.status(200).json({ message: 'Öğrenci başarıyla silindi.' });
  });
});

// Öğrenci güncelle
app.put('/api/ogrenci/:id', (req, res) => {
  const { id } = req.params;
  const { ad, soyad, bolumID } = req.body;
  const query = 'UPDATE ogrenci SET ad = ?, soyad = ?, bolumID = ? WHERE ogrenciID = ?';
  db.query(query, [ad, soyad, bolumID, id], (err, result) => {
    if (err) {
      console.error(err);
      return res.status(500).send('Öğrenci güncellenirken bir hata oluştu.');
    }
    res.status(200).json({ message: 'Öğrenci başarıyla güncellendi.' });
  });
});

// Sunucu başlatma
const port = 3000;
app.listen(port, () => {
  console.log(`Sunucu http://localhost:${port} adresinde çalışıyor`);
});
