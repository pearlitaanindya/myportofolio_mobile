# My Portofolio Mobile
[![CI](https://github.com/pearlitaanindya/myportofolio_mobile/actions/workflows/main.yaml/badge.svg?branch=main)](https://github.com/pearlitaanindya/myportofolio_mobile/actions/workflows/main.yaml)

## Nama: Pearlita Anindya Prameswari
## NPM: 2506547670
## Kelas: PBP C

### Deskripsi Proyek
My Portofolio Mobile adalah aplikasi portofolio berbasis Flutter. Aplikasi ini merupakan pengembangan lanjutan dari website portofolio berbasis Django. Proyek portofolio yang berbasis website dikembangkan melalui Flutter menjadi aplikasi dengan antarmuka. 

Pada tahap pengembangan sekarang, aplikasi telah terintegrasi dengan backend Django REST Framework. Pengguna dapat melihat daftar dan detail Experience dan Education tanpa login. Akan tetapi, penambahan data melalui formulir tetap memerlukan autentikasi berbasis token.

Aplikasi juga telah dilengkapi validasi input, indikator loading, *pull-to-refresh*, penanganan error, dan mekanisme login kembali saat token sudah tidak valid. Selain itu, telah digunakan pula GitHub Actions sebagai pipeline CI/CD untuk menjalankan pemeriksaan kualitas kode, pengujian otomatis, dan menghasilkan APK release.

### Setup dan Cara Menjalankan Aplikasi
#### Prasyarat
- Flutter SDK (stable channel)
- Dart SDK
- Git
- Android Emulator, perangkat Android, atau Google Chrome

#### Instalasi
1. Clone repositori aplikasi.

   ```bash
   git clone https://github.com/pearlitaanindya/myportofolio_mobile.git
   cd myportofolio_mobile
   ```

2. Instal dependencies.

   ```bash
   flutter pub get
   ```

3. Generate file serialisasi JSON.

   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

   Perintah ini menghasilkan file `experience.g.dart` dan `education.g.dart` yang diperlukan untuk proses serialisasi dan deserialisasi JSON.

#### Menjalankan Aplikasi
Untuk menjalankan aplikasi menggunakan backend Django yang telah di-deploy:

```bash
flutter run --dart-define=API_BASE_URL=https://pearlita-anindya-myportofolio.pws.cs.ui.ac.id
```

Untuk menjalankan aplikasi melalui Chrome dengan backend Django lokal:

```bash
flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:8000
```

Pastikan server Django lokal sudah berjalan dengan `python manage.py runserver`.

#### Backend Django dan API
- **Deployed Backend:** https://pearlita-anindya-myportofolio.pws.cs.ui.ac.id
- **Repository Backend:** [(https://github.com/pearlitaanindya/myportofolio)]
- **Experience API:** https://pearlita-anindya-myportofolio.pws.cs.ui.ac.id/api/v1/experience/
- **Education API:** https://pearlita-anindya-myportofolio.pws.cs.ui.ac.id/api/v1/education/

| Method | Endpoint | Autentikasi |
|---|---|---|
| GET | `/api/v1/experience/` | Publik |
| POST | `/api/v1/experience/` | Token |
| GET | `/api/v1/education/` | Publik |
| POST | `/api/v1/education/` | Token |
| POST | `/api/v1/auth/token/` | Username dan password |
| POST | `/api/v1/auth/logout/` | Token |

Operasi penambahan data hanya dapat dilakukan oleh pengguna yang memiliki token valid dan memenuhi permission yang ditetapkan pada backend.

#### Automated Testing

Pada Tugas 9, telah ditambahkan lima unit test dengan `MockClient` untuk menguji integrasi API Education, meliputi:

1. Pengambilan daftar Education tanpa autentikasi dan deserialisasi JSON.
2. Penanganan respons berupa daftar kosong.
3. Pengiriman POST dengan token dan struktur JSON yang sesuai dengan serializer Django.
4. Penanganan HTTP 401 melalui `ApiException`.
5. Penanganan HTTP 500 melalui `ApiException`.

Pengujian dapat dilakukan tanpa menjalankan server Django karena respons HTTP disimulasikan menggunakan `MockClient`.

```bash
flutter test test/education_api_test.dart
```

Untuk menjalankan seluruh pengujian dan pemeriksaan kualitas kode:

```bash
dart format --set-exit-if-changed lib test
flutter analyze
flutter test
```

#### CI/CD dan Release APK
Pipeline CI/CD menggunakan GitHub Actions dan `very_good_workflows` untuk menjalankan pemeriksaan kualitas kode serta pengujian otomatis. Setelah pemeriksaan berhasil, job `build_apk` akan menghasilkan APK release yang dapat diunduh melalui bagian Artifacts pada halaman GitHub Actions dengan nama `app-release-apk`.

**GitHub Actions:** https://github.com/pearlitaanindya/myportofolio_mobile/actions

### Tugas 7
1. *Widget tree* adalah struktur berbentuk hierarki yang menggambarkan susunan widget dalam aplikasi Flutter. Tiap widget dapat memiliki widget lain di dalamnya sehingga dapat membentuk hubungan antara *parent widget* dan *child widget*. Parent widget berperan sebagai wadah yang mengukur struktur, tata letak, ataupun karakteristik di dalamnya. *Child widget* adalah widget yang ditempatkan di dalam parent widget. Dengan struktur ini, antarmuka dapat dibangun dengan lebih sistematis karena menggunakan komponen-komponen yang saling terhubung.

Pada aplikasi ini, MaterialApp memuat `MyHomePage` sebagai halaman utama. Kemudian `MyHomePage` membangun `Scaffold` yang terdiri atas `AppBar` dan `body`. Di dalam `body`, terdapat `Column`, `Row`, `InfoCard`, dan `GridView` yang menyusun informasi profil dan tombol menu. Hubungan tersebut menunjukkan bagaimana widget saling bersarang untuk membentuk satu antarmuka aplikasi.

2. Digunakan berbagai widget bawaan Flutter, yaitu:
- `MaterialApp`: konfigurasi aplikasi
- `Scaffold`: struktur halaman
- `AppBar`: menampilkan header
- `Text`: menampilkan tulisan
- `Padding` dan `SizedBox`: mengatur jarak 
- `Row` dan `Column`: menyusun widget secara vertikal dan horizontal
- `Center`: memusatkan konten yang ditampilkan
- `Card`: menampilkan informasi profil
- `GridView`: menyusun tombol menu dalam grid
- `Material`: menyediakan permukaan tombol
- `InkWell`: menangani interaksi pengguna
- `Icon`: menampilkan simbol menu
- `SnackBar`: memberikan umpan balik ketika tombol ditekan

Widget khusus yang dibuat:
- `MyApp`: konfigurasi utama
- `MyHomePage`: halaman utama
- `InfoCard`: menampilkan identitas pengguna
- `ItemCard`: menampilkan tombol menu secara konsisten

3. `MaterialApp` adalah widget yang menyediakan konfigurasi utama aplikasi berbasis Material Design, seperti tema, navigasi, judul aplikasi, serta halaman awal aplikasi. `MaterialApp` memungkinkan berbagai komponen untuk menggunakan konfigurasi yang konsisten dan menyediakan fasilitas yang dibutuhkan widget Material lain. Pada aplikasi ini, `MaterialApp` digunakan dalam `MyApp` dengan properti `title`, `theme`, dan `home`. Properti `title` menentukan judul, `theme` mengatur tema/tampilan dengan `ThemeData` dan `ColorScheme`. Properti `home` menetapkan `MyHomePage` sebagai halaman utama. Dengan menggunakan properti-properti tersebut, warna pada komponen seperti `AppBar` dapat mengikuti konfigurasi tema aplikasi melalui `Theme.of(context)`.

4. `StatelessWidget` adalah widget yang tidak menyimpan/mengatur perubahan data secara langsung. Widget ini digunakan untuk menampilkan informasi yang tidak membutuhkan adanya perubahan kondisi selama pengguna berinteraksi. Sedangkan `StatefulWidget` digunakan ketika sebuah widget perlu menyimpan/meng-update kondisi atau data selama aplikasi berjalan. Perubahan tersebut dapat digunakan/dilakukan dengan `setState()` agar tampilan ikut di-update. Pada aplikasi ini, `MyApp`, `MyHomePage`, `InfoCard`, dan `ItemCard` menggunakan `StatelessWidget` karena informasi dari profil dan menu tidak memerlukan perubahan secara langsung. Saat tombol ditekan, aplikasi hanya menampilkan `SnackBar` tanpa mengubah informasi pada halaman. Apabila suatu saat aplikasi memiliki fitur yang membutuhkan perubahan kondisi, `StatefulWidget` dapat digunakan untuk mengelola perubahan tersebut.

5. `BuildContext` adalah objek yang merepresentasikan posisi suatu widget dalam widget tree. Objek ini membuat widget dapat mengakses informasi, layanan, serta konfigurasi yang telah disediakan oleh widget di atasnya (dalam susunan hierarki). Umumnya, `BuildContext` digunakan sebagai parameter pada *method* `build(BuildContent context)`. Pada aplikasi ini, `BuildContext` digunakan melalui `Theme.of(context)` untuk memperoleh warna dari tema aplikasi, `MediaQuery.of(context)` untuk akses ukuran layar dalam menentukan lebar `InfoCard`, dan `ScaffoldMessenger.of(context)` untuk menampilkan `SnackBar` ketika pengguna menekan tombol menu. `BuildContext` membantu tiap widget berinteraksi dengan lingkungan tempatnya berada.

6. *Hot reload* digunakan untuk menerapkan perubahan kode Dart pada aplikasi yang telah berjalan tanpa menghilangkan *state* yang telah tersimpan. Mekanisme *hot reload* biasanya digunakan untuk perubahan tampilan. *Hot restart* menjalankan ulang aplikasi pada tingkat Dart dan menghapus *state* sebelumnya sehingga inisialisasi akan diproses serta dijalankan kembali. *Full restart* adalah menghentikan aplikasi dan kembali menjalaninya dari awal termasuk proses peluncuran pada platform yang sedang digunakan. Mekanisme ini biasanya diperlukan untuk perubahan yang tidak dapat diterapkan dengan *hot reload* dan *hot restart*. Dalam aplikasi ini, *hot reload* digunakan dalam melihat perubahan tampilan tema (perubahan warna dan teks) secara langsung. *Hot restart* atau *full restart* akan digunakan saat aplikasi membutuhkan inisialisasi ulang.

#### AI Disclosure
- **Tool yang digunakan:** ChatGPT

- **Sesi percakapan:** https://chatgpt.com/share/6af425a9-1444-83ec-ab30-2ada5848f5ee

- **Strategi prompting:** Saya menggunakan Generative AI ChatGPT untuk mengidentifikasi sumber referensi dan memahami materi dasar Flutter yang diperlukan untuk menjawab 6 pertanyaan refleksi. Saya memberikan daftar pertanyaan yang mencakup konsep widget tree, jenis-jenis widget, MaterialApp, StatelessWidget dan StatefulWidget, BuildContext, serta hot reload dan hot restart. Selanjutnya, saya meminta AI untuk merekomendasikan sumber pembelajaran yang relevan, khususnya dokumentasi resmi Flutter, disertai gambaran singkat mengenai materi yang perlu dipahami dari setiap sumber.

- **Bagian spesifik yang dibantu:**
1. Rekomendasi dokumentasi resmi `Flutter` sebagai sumber referensi untuk memahami konsep *widget tree* dan hubungan *parent-child* antar-widget.
2. Identifikasi sumber untuk mempelajari fungsi widget, `MaterialApp`, serta perbedaan `StatelessWidget` dan `StatefulWidget`.
3. Rekomendasi dokumentasi mengenai `BuildContext` dan penggunaannya dalam *method* `build`.
4. Pemberian gambaran mengenai perbedaan *hot reload, hot restart,* dan *full restart* beserta kondisi penggunaannya.

- **Keterbatasan AI & Perbaikan Mandiri:**
1. Referensi dan penjelasan yang diberikan AI masih berupa panduan awal sehingga belum mencakup pembahasan mendalam dari setiap topik. Oleh karena itu, saya membaca dan memverifikasi informasi melalui dokumentasi resmi `Flutter` agar penjelasan yang digunakan lebih akurat.
2. AI tidak dapat mengidentifikasi seluruh widget yang digunakan dalam karena AI tidak dapat mengakses *source code* aplikasi saya. Oleh karena itu, identifikasi widget yang benar-benar digunakan perlu dilakukan secara mandiri dengan memeriksa kode program, kemudian mencocokkan fungsi masing-masing widget dengan dokumentasi resmi Flutter.

### Tugas 8
1. `Navigator.push()`, `Navigator.pushReplacement()`, dan `Navigator.pop()` digunakan untuk mengatur navigasi antarhalaman dengan sistem *navigation stack*. `Navigator.push()` digunakan untuk menambahkan halaman baru tanpa menghapus halaman sebelumnya sehingga pengguna tetap dapat menggunakan tombol Back. Sementara itu, `Navigator.pushReplacement()` menggantikan halaman yang sedang aktif dengan halaman baru dan `Navigator.pop()` menghapus halaman teratas dari stack untuk kembali ke halaman sebelumnya. Pada tahap pengembangan ini, saya menggunakan `Navigator.push()` pada `ItemCard` untuk membuka formulir Add Experience dan Add Education. Sementara itu, opsi Home pada `LeftDrawer` menggunakan `Navigator.pushReplacement()` untuk mengganti halaman yang sedang ditampilkan dengan `MyHomePage()`. Metode `Navigator.pop()` juga digunakan untuk menutup drawer dan dialog setelah pengguna memencet OK.

2. `Scaffold` adalah kerangka dasar halaman yang menyediakan tempat untuk `AppBar`, `Drawer`, dan `body`. `Appbar` digunakan untuk menampilkan judul halaman dan akses navigasi, `Drawer` digunakan untuk menyediakan menu untuk berpindah antarhalaman. Penggunaan ketiga widget tersebut membantu menjaga struktur aplikasi tetap konsisten karena pengguna menemukan susunan tampilan dan navigasi serupa pada tiap halaman. 

Pada tahap pengembangan ini, digunakan `Scaffold` serta komponen `LeftDrawer` yang sama pad halaman Home, Add Experience, dan Add Education. Dari segi konsistensi warna, digunakan satu warna ungu yang sama (Color(0xFF8D70B5)) pada `AppBar` untuk formulir Add Experience dan Add Education serta pada *header* `Drawer`. Sementara itu, `AppBar` halaman Home mengambil warna melalui `Theme.of(context).colorScheme.primary`.

3. Pada tahap pengembangan ini, saya menggunakan `Column` untuk menyusun input formulir secara vertikal agar pengguna dapat mengisi data secara berurut ke bawah. Susunan ini dipilih karena formulir Add Experience dan Add Education memiliki field yang lebih mudah dibaca saat ditampilkan dalam satu kolom. Selain itu, tata letak layar vertikal juga sesuai untuk layar perangkat mobile.

Dari segi pengaturan jarak, saya menggunakan `Padding` agar formulir tak terlalu dekat dengan tepi layar dan `SizedBox` untuk memberikan jarak antarelemen input. Saya juga menggunakan `SingleChildScrollView` agar formulir dapat digulir ketika seluruh inpur tidak muat untuk berada di dalam layar, misalnya saat keyboard muncul atau aplikasi dijalankan pada perangkat dengan layar kecil. Dengan sistem ini, pengguna dapat menjangkau field dan tombol Save tanpa mengalami masalah konten yang terpotong.

4. `GlobalKey<FormState>` digunakan untuk mengakses dan mengelola kondisi formulir termausk proses validasinya. Fungsi `validator` pada tiap input digunakan untuk memeriksa apakah nilai yang di-input sudah sesuai dengan aturan validasi. Ketika tombol Save ditekan, `_formKey.currentState!.validate()` akan menjalankan seluruh validator dan mengembalikan nilai `true` jika semua input valid atau `false` apabila masih ada kesalahan.Jika validasi berhasi, aplikasi akan menampilkan `AlertDialog` yang berisi ringkasan data yang telah di-input.

Hal ini dapat ditemukan pada formulir Add Education dan Add Experience. Sebagai contoh, pada formulir Add Education, field *Degree* yang hanya berisi spasi akan ditolak karena validator menggunakan `value.trim().isEmpty` untuk memeriksa input kosong. Selain itu, tanggal selesai yang lebih awal dari pada tanggal mulai juga akan ditolak. Pemilihan jenis input seperti `TextInputType.numberWithOptions(decimal: true)` pada field GPA hanya membantu menampilkan keyboard yang sesuai. Akan tetapi, hal ini tidak menjamin bahwa nilai yan di-input merupakan nilai yang valid. Oleh karena itu, validasi tetap diperlukan untuk memeriksa nilai dan memastikan data memenuhi aturan formulir.

#### AI Disclosure
- **Tool yang digunakan:** ChatGPT

- **Sesi percakapan:** https://chatgpt.com/share/6b02ca4e-74dc-83ec-99d5-0f95eb2693f1?ogimg=plain

- **Strategi prompting:** Saya menggunakan Generative AI ChatGPT untuk membantu mengidentifikasi sumber referensi yang relevan dalam menjawab empat pertanyaan reflektif Tugas 8. Saya memberikan daftar pertanyaan yang mencakup navigasi antarhalaman menggunakan Navigator, penggunaan `Scaffold`, `AppBar`, dan `Drawer`, pengaturan tata letak formulir, serta validasi input menggunakan `GlobalKey<FormState>` dan validator. Selanjutnya, saya meminta AI untuk merekomendasikan sumber pembelajaran, terutama dokumentasi resmi Flutter, beserta penjelasan singkat mengenai materi yang dibahas dalam setiap sumber.

- **Bagian spesifik yang dibantu:**
1. Rekomendasi dokumentasi resmi Flutter untuk memahami perbedaan `Navigator.push()`, `Navigator.pushReplacement()`, dan `Navigator.pop()` dalam navigasi antarhalaman.
2. Identifikasi referensi mengenai fungsi `Scaffold`, `AppBar`, `Drawer`, dan penggunaan tema untuk menjaga konsistensi tampilan aplikasi.
3. Rekomendasi dokumentasi mengenai penggunaan `Column`, `Padding`, `SizedBox`, dan `SingleChildScrollView` dalam mengatur tata letak formulir.
4. Identifikasi sumber untuk memahami fungsi `GlobalKey<FormState>`, validator, validate(), dan keyboardType dalam proses validasi input.

- **Keterbatasan AI & Perbaikan Mandiri:**
1. Referensi dan penjelasan yang diberikan AI masih bersifat umum sehingga belum sepenuhnya menjelaskan penerapan setiap konsep pada aplikasi saya. Oleh karena itu, saya menggunakan dokumentasi resmi Flutter sebagai acuan untuk memahami fungsi widget dan metode yang dibahas.
2. AI memberikan beberapa alternatif implementasi navigasi dan contoh validasi yang belum tentu sesuai dengan kode aplikasi saya. Oleh karena itu, saya mencocokkan penjelasan tersebut dengan implementasi pada aplikasi My Portofolio Mobile, seperti penggunaan `Navigator.push()` pada kartu aksi, `Navigator.pushReplacement()` pada opsi `Home` di drawer, serta validasi input pada formulir Add Education.

### Tugas 9
1. `@JsonSerializable(fieldRename: FieldRename.snake)` berfungsi untuk mempermudah konversi antar objek Dart dan data JSOn yang akan dikirim dan diterima melalui API. Penamaan field pada Dart umumnya dengan camelCase, sedangkan DRF menggunakan snake_case. Dengan anotasi tersebut, proses pemetaan nama field dapat dilakukan otomatis tanpa menuliskan tiap pasangan key-value secara manual. Di sisi lain, `@JsonKey(includeToJson: false)` digunakan agar field tertentu tetap dapat diterima dari backend tetapi tak ikut dikirim saat objek diubah menjadi JSON. Pada model `Education`, contoh penerapannya ada pada field `startedAt` yang secara otomatis dikonversi menjadi `started_at`. Jika menggunakan `Map<String, dynamic>` secara manual, terdapat kemungkinan terjadinya kesalahan penulisan key. Kesalahan ini dapat menyebabkan backend menganggap field tanggal mulai belum diisi dan mengembalikan respons HTTP 400. Selain itu, field `id, isOngoing, starCount, isStarred,` dan `starredByNames` menggunakan `includeToJson: false` karena nilai dari field tersebut ditentukan backend. Penggunaan model juga membantu memisahkan representasi data dari widget sehingga kode lebih terstruktur dan mudah dipelihara.

2. `Future` yang diteruskan menuju `FutureBuilder` perlu diinisialisasi di dalam `initState()` karena metode tersebut hanya dijalankan satu kali ketika satte widget pertama kali dibuat sedangkan `build()` dapat menyebabkan request HTTP berulang dan pemborosan penggunaan jaringan. Pada `EducationListPage`, `_educationsFuture` diinisialisasi melalui `getEducations()` di dalam `initState()`, sedangkan pemanggilan ulang API dilakukan melalui `_reload()` saat pengguna melakukan *pull-to-request* atau menekan tombol Retry. `ApiException` digunakan agar aplikasi dapat membedakan kegagalan request dengan kondisi data kosong. Jika `ApiClient` hanya mengembalikan `null`, penyebab kegagalan akan lebih sulit diidentifikasi. Dengan menyimpan *status code* dan pesan respons dalam `ApiException`, aplikasi dapat memberi penanganan yang sesuai. 

3. `SessionAuthentication` menggunakan *session cookied* untuk mengidentifikasi pengguna yang telah login dan perlindungan CSRF pada operasi yang mengubah data. Sementara itu, `TokenAuthentication` dengan token yang diperoleh setelah pengguna berhasil login. Token tersebut disertakan pada header `Authorization` tiap kali pengguna melakukan request yang perlu autentikasi. My Portofolio Mobile menggunakan `TokenAuthentication` karena aplikasi dapat berkomunikasi dengan backend tanpa bergantung pada *session cookie* yang dimiliki browser. Token disimpan sementara dalam `AuthState` dan digunakan sata melakukan `POST` Education melalui header `Authorization: Token <key>`. Di sisi lain, `SessionAuthentication` tetap diaktufkan agar autentikasi pada aplikasi web Django dapat berjalan seperti sebelumnya. `TokenAuthentication` ditempatkan sebelum `SessionAuthentication` agar request yang perlu autentikasi dengan token tidak valid atau tanpa autentikasi memperoleh respons HTTP 401.

4. Job `build` memiliki peran dalam *Continuous Integration (CI)* dengan *reusable workflow* dari `very_good_workflows`. Langkahnya mencakup instalasi *dependencies*, *code generation*, pemeriksaan format, analisis statis, pengujian otomatis, dan pemeriksaan *coverage*. Pada konfigurasi aplikasi, `min_coverage` ditetapkan sebesar 0 dan file `*.g.dart` dikecualikan dari perhitungan coverage. Di sisi lain, job `build_apk` berperan dalam *Continuous Delivery (CD)* dan hanya akan dijalankan setelah job `build` berhasil melalui konfigurasi `needs: build.` Job ini melakukan *code generation*, membangun *APK release* dengan konfigurasi `API_BASE_URL`, dan mengunggah sebagai artefak `app-release.apk`. File `*.g.dart` dimasukkan ke `.gitignore` karena hasil *code generation*. Hal ini membantu menjaga *repository* tetap rapi, emngurangi konflik Git, dan mencegah ketidaksesuaian antara model dan file hasil generasi. File ini tetap tersedia saat dibutuhkan meski tidak disimpan pada *repository* karena kedua job CI/CD menjalankan `build_runner` untuk menghasilkannya kembali sebelum proses pemeriksaan ataupun build APK.

#### AI Disclosure
- **Tool yang digunakan:** ChatGPT

- **Sesi percakapan:** https://chatgpt.com/share/6b06f266-3a08-83ec-9bc1-0565cbb7bbeb?ogimg=plain

- **Strategi prompting:** Saya menggunakan Generative AI ChatGPT untuk membantu menyusun strategi pengerjaan Assignment 9, khususnya dalam menentukan struktur branching, urutan implementasi, serta waktu dan pesan commit yang sesuai. Saya memberikan deskripsi tugas beserta checklist pengerjaan kepada AI, kemudian menjelaskan bahwa integrasi backend pada bagian Experience telah dilakukan sebelumnya sehingga pengerjaan Assignment 9 berfokus pada bagian Education. Selanjutnya, saya meminta rekomendasi tahapan pengerjaan dengan memanfaatkan kembali pola implementasi Experience yang telah tersedia.

- **Bagian spesifik yang dibantu:**
1. Rekomendasi strategi branching menggunakan satu feature branch, yaitu feat/education-integration, untuk mengelola seluruh proses integrasi Education.
2. Rekomendasi pembagian commit berdasarkan tahapan pengerjaan serta penggunaan conventional commits agar riwayat perubahan kode lebih terstruktur.
3. Rekomendasi pemeriksaan sebelum pengumpulan, termasuk pengecekan file hasil code generation, konfigurasi API_BASE_URL, keberhasilan CI/CD, dan ketersediaan artefak APK.

- **Keterbatasan AI & Perbaikan Mandiri:**
1. Rekomendasi awal AI masih bersifat umum karena belum mempertimbangkan bahwa integrasi `Experience` telah dilakukan pada Tutorial 10. Oleh karena itu, saya memberikan konteks tambahan agar strategi *branching* dan tahapan pengerjaan disesuaikan dengan integrasi `Education`.
2. Pembagian tahapan dan commit yang disarankan AI tidak sepenuhnya sesuai dengan kebutuhan aktual selama pengerjaan. Oleh karena itu, saya menyesuaikan pembagian commit berdasarkan perubahan kode yang saling berkaitan dan hasil pengujian pada setiap tahapan.
3. AI tidak dapat memverifikasi secara langsung kondisi *repository* maupun keberhasilan integrasi pada lingkungan pengembangan lokal saya. Oleh karena itu, saya melakukan pemeriksaan melalui `flutter analyze`, `flutter test`, pengujian langsung pada aplikasi, serta pengecekan hasil GitHub Actions.