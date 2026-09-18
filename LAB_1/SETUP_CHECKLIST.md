# ✅ Checklist Setup - LAB_1 Flutter

Folosește acest checklist pentru a te asigura că poți rula proiectul local.

## 📋 Pre-requisite

- [ ] **Flutter SDK instalat**
  ```bash
  flutter --version
  ```
  Dacă lipsește: `brew install --cask flutter`

- [ ] **Dart SDK disponibil** (vine cu Flutter)
  ```bash
  dart --version
  ```

- [ ] **Git instalat** (pentru clonarea proiectului)
  ```bash
  git --version
  ```

## 🔧 Setup Proiect

- [ ] **Navigat în directorul proiectului**
  ```bash
  cd LAB_1
  ```

- [ ] **Instalat dependențe**
  ```bash
  flutter pub get
  ```
  Status: Dacă vezi `Got dependencies!` → ✅

- [ ] **Verificat setup Flutter**
  ```bash
  flutter doctor
  ```
  Status: Cel puțin un dispozitiv trebuie să fie disponibil

## 📱 Configurare Dispozitiv

Alege cel puțin un dispozitiv pentru rulare:

### Opțiune 1: iOS Simulator (macOS)
- [ ] **Xcode instalat** (din App Store)
- [ ] **Simulatorul pornit**
  ```bash
  open -a Simulator
  ```

### Opțiune 2: Chrome/Web
- [ ] **Chrome instalat**
- [ ] **Suport web activat**
  ```bash
  flutter config --enable-web
  ```

### Opțiune 3: Android Emulator
- [ ] **Android Studio instalat**
- [ ] **AVD (Android Virtual Device) creat**
- [ ] **Emulator pornit** (din Android Studio)

### Opțiune 4: Dispozitiv fizic Android (Samsung S24)
- [ ] **USB Debugging activat pe telefon**
  - Settings → About phone → Apasă 7x pe "Build number"
  - Settings → Developer options → Activează "USB debugging"
  - Settings → Developer options → Activează "Install via USB"

- [ ] **Telefon conectat via USB** (cablu cu transfer de date)

- [ ] **Autorizare acceptată pe telefon**
  - Când conectezi, apare pop-up "Allow USB debugging?"
  - Bifează "Always allow from this computer"
  - Apasă "Allow"

- [ ] **Dispozitiv detectat**
  ```bash
  flutter devices
  ```
  Ar trebui să vezi Samsung-ul în listă

## ✅ Verificare Finală

- [ ] **Rulat scriptul de verificare**
  ```bash
  ./setup_check.sh
  ```
  Toate verificările importante ar trebui să fie ✅

- [ ] **Cel puțin un dispozitiv disponibil**
  ```bash
  flutter devices
  ```
  Output: Ar trebui să vezi cel puțin un dispozitiv

## 🚀 Rulare Aplicație

- [ ] **Aplicația pornește cu succes**
  ```bash
  flutter run
  ```

- [ ] **Aplicația se încarcă pe dispozitiv**
  - Apare ecranul de conversie valutară
  - Poți introduce sume
  - Dropdown-urile funcționează
  - Butonul "Convertește" funcționează

## 🧪 Testare

- [ ] **Testele trec**
  ```bash
  flutter test
  ```
  Status: Ar trebui să vezi `All tests passed!` (19 teste)

---

## ❌ Probleme?

Dacă ceva nu merge:

1. **Consultă secțiunea Troubleshooting** din [README.md](README.md)
2. **Rulează din nou scriptul de verificare**:
   ```bash
   ./setup_check.sh
   ```
3. **Verifică mesajele de eroare** de la `flutter doctor`
4. **Pentru dispozitive fizice Android**:
   ```bash
   adb devices
   adb kill-server && adb start-server
   flutter devices
   ```

---

## 📚 Documente Utile

- [README.md](README.md) - Documentație completă
- [QUICKSTART.md](QUICKSTART.md) - Ghid rapid
- [Flutter Docs](https://docs.flutter.dev) - Documentație oficială

---

## ✨ Totul funcționează?

Dacă ai bifat toate checkmark-urile importante și aplicația rulează → **Felicitări! Setup-ul este complet!** 🎉

Acum poți:
- Dezvolta noi features
- Rula teste: `flutter test`
- Testa pe multiple dispozitive
- Face modificări și hot reload (R în terminal după `flutter run`)
