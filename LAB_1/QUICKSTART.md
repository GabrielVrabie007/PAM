# 🚀 Ghid Rapid de Rulare

## TL;DR - Dacă ai deja Flutter instalat

```bash
cd LAB_1
flutter pub get
flutter run
```

---

## Dacă nu ai Flutter instalat încă

### 1. Instalare Flutter (macOS)

```bash
brew install --cask flutter
```

### 2. Verificare instalare

```bash
flutter doctor
```

### 3. Acceptă licențele Android (dacă ai Android Studio)

```bash
flutter doctor --android-licenses
```

---

## Rulare Proiect

### Pasul 1: Navighează în proiect
```bash
cd LAB_1
```

### Pasul 2: Instalează dependențele
```bash
flutter pub get
```

### Pasul 3: Verifică setup-ul (opțional)
```bash
./setup_check.sh
```

### Pasul 4: Rulează aplicația

**Opțiunea 1 - iOS Simulator (cel mai rapid pe macOS)**:
```bash
open -a Simulator
flutter run
```

**Opțiunea 2 - Chrome/Web**:
```bash
flutter run -d chrome
```

**Opțiunea 3 - Android Emulator**:
```bash
# Pornește un emulator din Android Studio, apoi:
flutter run
```

**Opțiunea 4 - Dispozitiv fizic Android (Samsung S24, etc.)**:
```bash
# 1. Activează USB Debugging pe telefon (Settings → Developer options)
# 2. Conectează telefonul via USB
# 3. Acceptă permisiunea pe telefon
# 4. Verifică dacă e detectat:
flutter devices

# 5. Rulează:
flutter run
```

> **Note**: Pentru pași detaliați de activare USB debugging, vezi [README.md](README.md)

---

## Verificare Dispozitive

Pentru a vedea ce dispozitive sunt disponibile:
```bash
flutter devices
```

---

## Probleme?

1. Rulează scriptul de verificare:
   ```bash
   ./setup_check.sh
   ```

2. Consultă secțiunea **Troubleshooting** din [README.md](README.md)

3. Verifică documentația Flutter: https://docs.flutter.dev

---

## Ce face aplicația?

Aplicația convertește sume între 6 valute (EUR, USD, MDL, RON, GBP, UAH) folosind cursuri fixe.

**Features**:
- Input pentru sumă
- 2 dropdown-uri pentru alegerea valutelor
- Buton de inversare valute
- Afișare rezultat + curs valutar folosit
- Validare input

**Testare**:
```bash
flutter test
```

19 teste disponibile (unitare + widget tests).
