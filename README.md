Öğrenci CRUD Uygulaması


Bu proje, Flutter kullanarak oluşturulmuş bir Öğrenci CRUD (Create, Read, Update, Delete) uygulamasıdır. Uygulama, bir backend API ile etkileşime girerek öğrencileri eklemeyi, listelemeyi, güncellemeyi ve silmeyi sağlar. Backend, Node.js ve MySQL kullanılarak geliştirilmiştir ve Flutter uygulaması bu API'ye HTTP istekleri gönderir.

    Özellikler
Öğrenci listeleme

Yeni öğrenci ekleme

Öğrenci güncelleme

Öğrenci silme

Veritabanına yapılan işlemlerle senkronize olarak kullanıcı arayüzünü güncelleme

    Teknolojiler
Frontend: Flutter

Backend: Node.js, Express

Veritabanı: MySQL

API İletişimi: HTTP İstekleri (GET, POST, PUT, DELETE)

    Başlangıç

Bu projeyi yerel bilgisayarınızda çalıştırmak için aşağıdaki adımları takip edebilirsiniz:

    Gereksinimler
Flutter kurulmuş olmalıdır.

Node.js ve MySQL kurulmuş olmalıdır.

Backend Kurulumu

Node.js API'yi Kurun:

backend klasörüne gidin ve gerekli paketleri yükleyin:


    cd backend
    npm install

MySQL Veritabanı Ayarları:

MySQL'de bir veritabanı oluşturun:

    CREATE DATABASE ogrenci_db;

Backend API'nizdeki config.js dosyasını düzenleyerek veritabanı bağlantı bilgilerinizi girin.
Backend Sunucusunu Başlatın:

Sunucuyu başlatmak için:

    npm start
Sunucu, varsayılan olarak http://localhost:3000 adresinde çalışacaktır.

Flutter Uygulaması Kurulumu

Flutter Uygulamasını Kurun:

flutter_ogrenci_app klasörüne gidin.

Flutter bağımlılıklarını yükleyin:

    flutter pub get
API URL'sini Yapılandırın:

Flutter uygulamasında, backend API'sine yapılan isteklerde kullanılan URL'yi güncelleyin:

    final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/ogrenci'));

Burada 10.0.2.2, Android emülatörüne yönelik özel bir IP adresidir. Gerçek cihaz kullanıyorsanız, bu URL'yi http://<your_ip>:3000 olarak değiştirin.


Uygulamayı Çalıştırın:

Uygulamayı başlatmak için:

    flutter run


Kullanım

Uygulama açıldığında, mevcut öğrencilerin listesi gösterilecektir. Aşağıdaki işlemleri yapabilirsiniz:

Yeni Öğrenci Ekleme: Sağ altta yer alan artı butonuna tıklayarak yeni bir öğrenci ekleyebilirsiniz.

Öğrenci Silme: Öğrencinin yanındaki çöp kutusu simgesine tıklayarak öğrenciyi silebilirsiniz.

Öğrenci Güncelleme: Bir öğrencinin bilgilerini güncellemek için, öğeye tıklayarak düzenleme yapabilirsiniz.


Proje Yapısı

    flutter_ogrenci_app/
    lib/
    main.dart             # Flutter uygulaması ana dosyası
    backend/
    app.js                 # Node.js uygulaması
    config.js              # Veritabanı bağlantı ayarları
    routes/
    ogrenciRoutes.js      # Öğrenci CRUD API yönlendirmeleri
    models/
    ogrenciModel.js       # Öğrenci model yapısı


Katkıda Bulunma
Bu projeye katkıda bulunmak isterseniz, lütfen aşağıdaki adımları izleyin:

Bu repo'yu fork edin.

Yeni bir branch oluşturun (git checkout -b feature-branch).

Değişikliklerinizi yapın ve commit edin (git commit -am 'Add new feature').

Branch'ınızı push edin (git push origin feature-branch).

Bir pull request oluşturun.
