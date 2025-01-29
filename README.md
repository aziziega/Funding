# Progress Funding Smart Contract

## Ringkasan
1. **FundMe.sol**: mengirim dana dalam bentuk ETH dan kasi Minimum USD. Untuk fungsi withdrawl atau menarik masih belum berfungsi.
2. **PriceConverter.sol**: Library yang mengambil harga ETH Secara Langsung menggunakan oracle Chainlink dan mengonversi jumlah ETH ke USD.

Kedua kontrak ini dirancang untuk dijalankan di SepoliaETH Testnet.

## Deploy
- **Jaringan:** Sepolia Testnet
- **Alamat Price Feed:** : https://sepolia.etherscan.io/address/0xe2BC6A618bD2C8408769cCed3E9Eb0138fc2CEf9

## Catatan : 
1. Deploy kontrak melalui Remix Ethereum IDE.
2. Pilih Sepolia Testnet untuk deployment.
3. Interaksi dengan fungsi (pendanaan, cek saldo, penarikan) untuk memvalidasi perilaku.

---

## Rekap

### FundMe.sol✅

- **Fungsi Pendanaan dan Withdrawl** ⌛
  - User bisa kasi dana kontrak menggunakan fungsi Fund, tetapi minimal $5 USD Menyesuaikan harga ETH Sekarang.
  - Bisa mengetahui dan melacak adress menggunakan mapping `addressToAmountFunded`.
  - Fungsi Withdrawl untuk mengkosongkan dan ditarik, menggunakan loop untuk mereset saldonya.

### PriceConverter.sol✅
- **Pengambilan Harga, Konversi ETH ke USD dan Cek Version** ⌛
  - Mengambil harga ETH terkini atau secara langsung dari Chainlink menggunakan Address `0x694AA1769357215DE4FAC081bf1f309aDC325306`.
  - Dapat mengkonversi jumlah ETH ke USD menggunakan price feed.
  - Version Chainlink Price Feed Sepolia saat ini yang terbaru adalah `4` menunjukkan versi ini kompatibel untuk digunakan.
    
---

## Catatan untuk Perbaikan kata ChatGPT
- **Efisiensi Gas:** Loop di Solidity dapat mahal; pertimbangkan menggunakan mekanisme penarikan yang lebih hemat gas.
- **Kontrol Akses:** Tambahkan modifier untuk membatasi akses ke fungsi tertentu.
- **Praktik Keamanan:** Implementasikan perlindungan terhadap reentrancy untuk mencegah potensi kerentanan.

---

## Kesimpulan
Proyek smart contract ini masih pengembangan lebih lanjut, mungkin kedepannya ada beberapa fitur yang di tambahkan.
Thanks to Cyfrin Updraft course Solidity.


