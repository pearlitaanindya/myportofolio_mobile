# My Portofolio Mobile

## Nama: Pearlita Anindya Prameswari
## NPM: 2506547670
## Kelas: PBP C

### Deskripsi Proyek
My Portofolio Mobile adalah aplikasi portofolio berbasis Flutter. Aplikasi ini merupakan pengembangan lanjutan dari website portofolio berbasis Django. Proyek portofolio yang berbasis website dikembangkan melalui Flutter menjadi aplikasi dengan antarmuka. 

Pada tahap pengembangan sekarang, aplikasi telah menampilkan informasi identitas dan menyediakan 3 tombol fitur utama, yaitu My Experiences (untuk melihat experiences), Add Experience, dan Logout. Tiap menu memiliki warna yang berbeda dan dilengkapi dengan *SnackBar* sebagai umpan balik tiap kali pengguna menekan sebuah tombol. Namun, saat ini ketiga tombol tersebut masih berupa antarmuka interaktif sederhana dan belum terhubung dengan navigasi halaman ataupun backend Django.

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
