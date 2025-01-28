# Progress

## Ringkasan
1. **FundMe.sol**: mengirim dana dalam bentuk ETH dan kasi Minimum USD. Untuk fungsi withdrawl atau menarik masih belum berfungsi.
2. **PriceConverter.sol**: Library yang mengambil harga ETH Secara Langsung menggunakan oracle Chainlink dan mengonversi jumlah ETH ke USD.

Kedua kontrak ini dirancang untuk dijalankan di SepoliaETH Testnet.
address Deploy transaksi : 0xe2BC6A618bD2C8408769cCed3E9Eb0138fc2CEf9

---

## Tujuan Proyek
- Memungkinkan donasi ETH dengan nilai minimum setara $5 USD.
- Melacak dan mengelola dana dari berbagai alamat.
- Mengimplementasikan fungsionalitas penarikan dana.
- Menggunakan price feed Chainlink untuk memvalidasi jumlah ETH dalam USD.

---

## Fitur Saat Ini

### FundMe.sol
- **Fungsionalitas Pendanaan**
  - Pengguna dapat mendanai kontrak jika kontribusi mereka memenuhi atau melebihi nilai minimum USD (saat ini ditetapkan $5 USD).
  - Kontribusi dilacak menggunakan mapping `addressToAmountFunded` untuk menjaga akuntabilitas.

- **Fungsionalitas Penarikan Dana**
  - Dana dapat dikosongkan dan ditarik, dengan loop yang mengiterasi semua kontributor untuk mereset saldo mereka.

### PriceConverter.sol
- **Pengambilan Harga**
  - Mengambil harga ETH terkini dari Chainlink menggunakan alamat `0x694AA1769357215DE4FAC081bf1f309aDC325306`.

- **Informasi Versi**
  - Memungkinkan pengambilan versi price feed.

- **Konversi ETH ke USD**
  - Mengonversi jumlah ETH ke ekuivalen USD menggunakan price feed terkini.

---

## Tonggak Kemajuan

### Tonggak 1: Persiapan Awal ✅
- [x] Membuat dan mengompilasi FundMe.sol dan PriceConverter.sol.
- [x] Mengimpor antarmuka Chainlink.

### Tonggak 2: Fungsionalitas Dasar ✅
- [x] Mengimplementasikan fungsionalitas pendanaan.
- [x] Mengimplementasikan logika konversi harga.
- [x] Menyiapkan fungsi penarikan sederhana.

### Tonggak 3: Optimalisasi ⌛
- [ ] Menambahkan kontrol akses hanya untuk pemilik pada fungsi penarikan.
- [ ] Merapikan fungsi penarikan agar lebih hemat gas.
- [ ] Mengoptimalkan pelacakan pendanaan.

### Tonggak 4: Pengujian ⌛
- [ ] Deploy ke Sepolia Testnet.
- [ ] Menguji semua fungsi (pendanaan, konversi, penarikan).
- [ ] Menangani edge case (misalnya, dana tidak mencukupi, banyak kontributor).

### Tonggak 5: Peningkatan Keamanan ⌛
- [ ] Mengimplementasikan perlindungan reentrancy.
- [ ] Menambahkan validasi input dan penanganan kesalahan.
- [ ] Melakukan pengujian keamanan secara menyeluruh.

---

## Catatan untuk Perbaikan
- **Efisiensi Gas:** Loop di Solidity dapat mahal; pertimbangkan menggunakan mekanisme penarikan yang lebih hemat gas.
- **Kontrol Akses:** Tambahkan modifier untuk membatasi akses ke fungsi tertentu.
- **Praktik Keamanan:** Implementasikan perlindungan terhadap reentrancy untuk mencegah potensi kerentanan.

---

## Deploy
- **Jaringan:** Sepolia Testnet
- **Alamat Price Feed:** `0x694AA1769357215DE4FAC081bf1f309aDC325306`

---

## Cara Menjalankan
1. Deploy kontrak melalui Remix Ethereum IDE.
2. Pilih Sepolia Testnet untuk deployment.
3. Interaksi dengan fungsi (pendanaan, cek saldo, penarikan) untuk memvalidasi perilaku.

---

## Kesimpulan
Proyek smart contract ini masih dalam pengembangan dengan fokus untuk menciptakan cara yang andal dan aman dalam menangani donasi dan penarikan dana sambil memanfaatkan teknologi blockchain untuk konversi harga. Peningkatan di masa depan bertujuan untuk mengoptimalkan efisiensi, meningkatkan keamanan, dan menyediakan fitur yang lebih lengkap.

