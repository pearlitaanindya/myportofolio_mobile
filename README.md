# My Portofolio Mobile

## Nama: Pearlita Anindya Prameswari
## NPM: 2506547670
## Kelas: PBP C

### Deskripsi Proyek
My Portofolio Mobile adalah aplikasi portofolio berbasis Flutter. Aplikasi ini merupakan pengembangan lanjutan dari website portofolio berbasis Django. Proyek portofolio yang berbasis website dikembangkan melalui Flutter menjadi aplikasi dengan antarmuka. 

Pada tahap pengembangan sekarang, aplikasi telah menampilkan informasi identitas dan menyediakan lima menu fitur utama, yaitu My Experiences (untuk melihat experiences), Add Experience, My Education (untuk melihat education), Add Education, dan Logout. Tiap menu memiliki ikon dan warna yang berbeda sesuai fungsinya. Pengguna dapat mengakses formulir Add Experience dan Add Education melalui *card menu* pada halaman utama maupun melalui *Drawer*. Kedua formulir juga dilengkapi dengan validasi input, dialog ringkasan data, serta tombol save. Aplikasi ini juga dilengkapi dengan *SnackBar* sebagai umpan balik tiap kali pengguna menekan beberapa tombol. Namun, saat ini data yang dikirim melalui formulir belum disimpan ke database atau terhubung langsung dengan *baceknd* Django.

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