# 🕒 Auto Clock-In / Clock-Out (Auto COCI)

Otomatisasi absensi PeoplesHR via browser Microsoft Edge.

---

## 🧰 Tools yang Dibutuhkan

1. **Microsoft Edge** – sebagai browser utama.
2. **WebDriver Microsoft Edge** – untuk mengotomatisasi browser.
3. **Python** – untuk menjalankan script automation.

---

## 🚀 Cara Menggunakan

1. Clone atau download repo ini.
2. **Pindahkan folder repo ke `C:\`**  
   → Supaya kamu cukup isi username dan password saja (tidak perlu isi path Python script).
3. Buka folder repo tersebut, lalu **buat shortcut file `run_auto_coci.bat`** ke lokasi mana pun (misalnya: Desktop).  
   ⚠️ *Ingat, **buat shortcut** ya, jangan di-*copy*!
4. Klik dua kali file shortcut `run_auto_coci.bat`.
5. Masukkan username dan password akun PeoplesHR.
6. Masukkan path direktori `auto_coci.py` (misal: `C:\Users\ASUS-ROG\Desktop\coci`)  
   → *Kalau kamu sudah simpan repo di `C:\`, bagian ini akan otomatis dilewati.*
7. Tunggu proses selesai. Aplikasi akan menutup otomatis.

---

## 📝 Catatan

- Menggunakan browser Microsoft Edge.
- Harus menginstall `msedgedriver.exe` agar automation bisa berjalan.
- Jika ingin memindahkan `run_auto_coci.bat`, **wajib buat shortcut**, bukan di-*copy* ke tempat lain.
- Shortcut bisa kamu taruh di mana saja, bahkan bisa diatur agar auto-start saat laptop dinyalakan (belum dites 😅).
- Masih ada beberapa validasi yang perlu ditambahkan.
- Kalo mau ubah username dan pass peopleshr bisa di file .env ya (sementara)
- File null tergenerate karena `chcp 65001 >null` di file bat
- Di masa depan, akan dicoba tambahkan fitur auto-install Python (biar makin praktis).
- Untuk saat ini, cukup segini dulu ya... Udah ngantuk banget, baru sadar ternyata udah jam setengah 3 pagi coy hahaha

---

## ❓ FAQ

### Kenapa selalu muncul instalasi `python-dotenv` meskipun sudah diinstall sebelumnya?

Biasanya terjadi jika kamu menginstall Python lewat **Microsoft Store**.

#### Kenapa bisa begitu?

Karena Python dari Microsoft Store:
- Terisolasi di direktori khusus.
- Pip menginstall ke user site-packages (`--user` mode), bukan global.
- Beberapa alat Python (termasuk `__import__`) dan `PYTHONPATH` tidak sinkron dengan site-packages user.

### Solusi?

Install Python dari website resminya: https://www.python.org/downloads/

---

## 🔗 Referensi

- [📥 Download Python](https://www.python.org/downloads/)
- [🌐 Download Microsoft Edge](https://www.microsoft.com/id-id/edge/download?form=MA13FJ)
- [📦 Download Edge WebDriver](https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/?form=MA13LH#installation)
- [📚 Dokumentasi Edge WebDriver](https://learn.microsoft.com/en-us/microsoft-edge/webdriver-chromium/?tabs=c-sharp&form=MA13LH)
