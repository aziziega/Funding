# Progress Funding Smart Contract

## Ringkasan
1. **FundMe.sol**: mengirim dana dalam bentuk ETH dan kasi Minimum USD. Untuk fungsi withdrawl sudah berfungsi dan sudah menggunakan modifier agar terhindar dari serangan reetrancy.
2. **PriceConverter.sol**: Library yang mengambil harga ETH Secara Langsung menggunakan oracle Chainlink dan mengonversi jumlah ETH ke USD.

Kedua kontrak ini dirancang untuk dijalankan di SepoliaETH Testnet.

## Deploy
- **Jaringan:** Sepolia Testnet dan zksync Sepolia Testnet
- **Alamat Price Feed:** : https://sepolia.etherscan.io/address/0xe2BC6A618bD2C8408769cCed3E9Eb0138fc2CEf9

## Catatan : 
1. Deploy kontrak melalui Remix Ethereum IDE.
2. Pilih Sepolia Testnet dan zysync sepolia Testnet untuk deployment.
3. Interaksi dengan fungsi (pendanaan, cek saldo, penarikan) untuk memvalidasi perilaku.
4. Pada penarikan sudah menyesuaikan address dari kontrak yang membuatnya menvalidasi menggunakan modifier `onlyOwner`

---

## Rekap

### FundMe.sol✅

- **Fungsi Pendanaan dan Withdrawl** ⌛
  - User bisa kasi dana kontrak menggunakan fungsi Fund, tetapi minimal $5 USD Menyesuaikan harga ETH Sekarang.
  - Bisa mengetahui dan melacak adress menggunakan mapping `addressToAmountFunded`.
  - Fungsi Withdrawl untuk mengkosongkan dan ditarik, menggunakan loop untuk mereset saldonya dan menggunakan fungsi call().
  - Menghemat gas fee menggunakan immutable dan constant
    - **Perbandingan Gas Fee**
    - constant biasanya lebih hemat gas dibandingkan immutable
    - Namun, jika nilainya hanya diketahui saat runtime, immutable tetap jauh lebih hemat gas daripada variabel biasa.
  - menggunakan 2 spesial function dari solidity yaitu fallback() dan receice() dan satu lagi contructor() yang di tandai warna pink.

### PriceConverter.sol✅
- **Pengambilan Harga, Konversi ETH ke USD dan Cek Version** ⌛
  - Mengambil harga ETH terkini atau secara langsung dari Chainlink menggunakan Address
    - ETH sepolia testnet : `0x694AA1769357215DE4FAC081bf1f309aDC325306`.
    - zksync sepolia testnet : `0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF`
  - Dapat mengkonversi jumlah ETH ke USD menggunakan price feed.
  - Version Chainlink Price Feed Sepolia dan zksync saat ini yang terbaru adalah `4` menunjukkan versi ini kompatibel untuk digunakan.
    
    
---

## Catatan untuk Perbaikan kata ChatGPT
- **Efisiensi Gas:** Loop di Solidity dapat mahal; pertimbangkan menggunakan mekanisme penarikan yang lebih hemat gas.
- **Kontrol Akses:** Tambahkan modifier untuk membatasi akses ke fungsi tertentu.
- **Praktik Keamanan:** Implementasikan perlindungan terhadap reentrancy untuk mencegah potensi kerentanan.


**Solusi keamanan** 
  
  - Mengenai efesiensi gas sudah di benahi, menggunakan immutable dan constant untuk memangkas gasfee atau menghemat gasfee
  - Sudah menggunakan modifier `onlyOwner` agar membatasi address dari user yang lain agar tidak rentan saldo yang sudah ada pada address pembuat kontrak. 
  - Sudah menggunakan 3 fungsi untuk withdrawl agar terlindungi dari reentrancy, yang kali ini menggunakan fungsi call(), yang mengembalikan 2 parameter boolean.
  - 
---

## Kesimpulan
Proyek smart contract ini masih pengembangan lebih lanjut, mungkin kedepannya ada beberapa fitur yang di tambahkan.
(beberapa fitur sudah di tambahkan seperti immutable, constant, dan fungsi spesial dari solidity fallback() dan receive())
Thanks to Cyfrin Updraft course Solidity.


