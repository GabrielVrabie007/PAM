# PAM — Lucrarea de laborator 1

**Varianta 4: Conversie monedă**

Aplicație mobilă Flutter care convertește o sumă între mai multe valute,
folosind cursuri valutare fixe introduse direct în aplicație.

## Cerințe și cum sunt acoperite

| Cerință | Implementare |
|---|---|
| Input: suma — `TextField` | `lib/screens/converter_screen.dart` |
| Două `DropdownButton` (sursă / destinație) | `lib/widgets/currency_dropdown.dart` |
| `ElevatedButton` | butonul „Convertește" din ecranul principal |
| Output într-un `Text` | `lib/widgets/conversion_result_card.dart` |
| Cursuri valutare fixe | `lib/data/currency_rates.dart` |

## Structura proiectului

```
lib/
├── main.dart                        # punct de intrare + tema aplicației
├── models/
│   └── currency.dart                # modelul unei valute
├── data/
│   └── currency_rates.dart          # cursurile fixe (EUR, USD, MDL, RON, GBP, UAH)
├── services/                        # logica aplicației, fără dependențe de UI
│   ├── currency_converter.dart      # formula de conversie
│   ├── amount_parser.dart           # validarea sumei introduse
│   └── money_formatter.dart         # formatarea sumelor pentru afișare
├── screens/
│   └── converter_screen.dart        # ecranul principal (stare + layout)
└── widgets/
    ├── currency_dropdown.dart       # dropdown reutilizabil pentru valute
    └── conversion_result_card.dart  # afișarea rezultatului
```

Separarea pe straturi permite testarea logicii independent de interfață:
serviciile nu importă `flutter/material.dart`.

## Cum funcționează conversia

Toate cursurile sunt raportate la o monedă de bază (EUR). Fiecare valută
are `rateToBase` = câți EUR valorează o unitate din ea.

```
suma_convertită = suma × (sursă.rateToBase / destinație.rateToBase)
```

Exemplu: 100 EUR → MDL = 100 × (1.0 / 0.052) ≈ 1923.08 MDL

Avantajul acestei abordări: sunt necesare `N` cursuri în loc de `N×N` perechi.

## Funcționalități suplimentare

- buton de inversare a monedelor (recalculează automat rezultatul)
- validarea sumei: câmp gol, text nenumeric, valori negative
- acceptă atât `.` cât și `,` ca separator zecimal
- afișarea cursului folosit (ex: `1 EUR = 19.2308 MDL`)
- formatare cu separator de mii și 2 zecimale

## Pregătire mediu de dezvoltare

### 🚀 Verificare rapidă setup

Înainte de a începe, poți rula scriptul de verificare:
```bash
cd LAB_1
./setup_check.sh
```

Acest script verifică:
- Dacă Flutter SDK este instalat
- Dacă Dart SDK este disponibil
- Dacă dependențele proiectului sunt instalate
- Starea generală a mediului Flutter (flutter doctor)
- Ce dispozitive sunt disponibile pentru rulare

### Instalare Flutter SDK (macOS)

1. **Instalare prin Homebrew (recomandat)**:
   ```bash
   brew install --cask flutter
   ```

2. **Sau descărcare manuală**:
   - Descarcă Flutter SDK de la: https://docs.flutter.dev/get-started/install/macos
   - Extrage arhiva în `~/development/` (sau alt director la alegere)
   - Adaugă Flutter în PATH editând `~/.zshrc` (sau `~/.bash_profile`):
     ```bash
     export PATH="$PATH:$HOME/development/flutter/bin"
     ```
   - Reîncarcă configurația: `source ~/.zshrc`

3. **Verificare instalare**:
   ```bash
   flutter doctor
   ```
   Acest command verifică toate dependențele și afișează ce lipsește.

4. **Acceptă licențele Android** (dacă lipsesc):
   ```bash
   flutter doctor --android-licenses
   ```

### Configurare pentru iOS (opțional, doar pentru rulare pe iOS)

- Instalează Xcode din App Store
- Instalează CocoaPods:
  ```bash
  sudo gem install cocoapods
  ```

### Configurare pentru Android (opțional, doar pentru rulare pe Android)

- Instalează Android Studio: https://developer.android.com/studio
- Configurează Android SDK prin Android Studio

## Rulare

### Pași pentru prima rulare

1. **Navighează în directorul proiectului**:
   ```bash
   cd LAB_1
   ```

2. **Instalează dependențele**:
   ```bash
   flutter pub get
   ```

3. **Verifică că totul e ok**:
   ```bash
   flutter doctor -v
   ```

4. **Rulează proiectul**:

   **Pe macOS/iOS Simulator**:
   ```bash
   # Deschide simulatorul iOS
   open -a Simulator
   # Rulează aplicația
   flutter run
   ```

   **Pe Chrome (web)**:
   ```bash
   flutter run -d chrome
   ```

   **Pe Android Emulator**:
   ```bash
   # Pornește un emulator Android din Android Studio, apoi
   flutter run
   ```

   **Pe dispozitiv Android fizic (ex: Samsung S24)**:

   a. Activează modul dezvoltator pe telefon:
      - Mergi la Settings → About phone
      - Apasă de 7 ori pe "Build number"
      - Revino la Settings → Developer options

   b. Activează USB Debugging:
      - În Developer options, activează "USB debugging"
      - Activează și "Install via USB" (dacă e disponibil)

   c. Conectează telefonul la calculator via USB
      - Acceptă pe telefon permisiunea "Allow USB debugging"
      - Bifează "Always allow from this computer"

   d. Verifică conexiunea:
      ```bash
      flutter devices
      # Ar trebui să vezi Samsung S24 în listă
      ```

   e. Rulează aplicația:
      ```bash
      flutter run
      # Sau specific pe Samsung:
      flutter run -d <device-id>
      ```

5. **Liste dispozitive disponibile**:
   ```bash
   flutter devices
   ```

### Rulări ulterioare

După instalarea inițială a dependențelor, doar:
```bash
flutter run
```

## Testare

```bash
flutter test
```

19 teste: unitare pentru conversie și validare, plus teste de widget
pentru fluxul complet din interfață.

## Troubleshooting

### `command not found: flutter`

Flutter nu este instalat sau nu este în PATH. Soluții:
1. Instalează Flutter: `brew install --cask flutter`
2. Sau adaugă Flutter în PATH (vezi secțiunea "Instalare Flutter SDK")
3. Reîncarcă terminalul după instalare

### `flutter pub get` eșuează

- Verifică conexiunea la internet
- Șterge cache-ul: `flutter pub cache clean`
- Încearcă din nou: `flutter pub get`

### Nu apar dispozitive disponibile

**Pentru iOS Simulator**:
```bash
# Verifică dacă Xcode este instalat
xcode-select --print-path

# Deschide simulatorul
open -a Simulator
```

**Pentru Android Emulator**:
- Asigură-te că Android Studio este instalat
- Creează un AVD (Android Virtual Device) din Android Studio
- Pornește emulatorul înainte de `flutter run`

**Pentru Chrome/Web**:
```bash
# Activează suport web (dacă nu e deja activ)
flutter config --enable-web
```

### Erori de build pentru iOS

```bash
cd ios
pod install
cd ..
flutter clean
flutter run
```

### Probleme de performanță în debug mode

Aplicația Flutter rulează mai lent în modul debug. Pentru performanță maximă:
```bash
flutter run --release
```

### Dispozitivul Android fizic nu apare în `flutter devices`

**Verificări**:
```bash
# 1. Verifică dacă ADB detectează dispozitivul
# (dacă nu funcționează, instalează Android Studio care include adb)
adb devices

# 2. Dacă apare "unauthorized", revocă autorizările USB pe telefon:
# Settings → Developer options → Revoke USB debugging authorizations
# Apoi reconectează cablul USB

# 3. Încearcă să restartezi ADB server:
adb kill-server
adb start-server
flutter devices
```

**Probleme comune**:
- Cablul USB este doar pentru încărcare → Folosește un cablu USB care suportă transfer de date
- USB debugging nu e activat → Verifică în Developer options
- Calculatorul nu e autorizat → Acceptă dialog-ul pe telefon
- Driver-e lipsă (pe Windows) → Instalează Google USB Driver sau driver-ul producătorului

**Pentru Samsung S24 specific**:
- Asigură-te că ai activat "Install via USB" în Developer options
- Unele Samsung-uri necesită și "USB configuration" setat pe "MTP" sau "PTP"

### Verificare completă setup

```bash
# Afișează informații detaliate despre setup
flutter doctor -v

# Verifică toate dispozitivele conectate
flutter devices
```
