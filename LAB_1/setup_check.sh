#!/bin/bash

# Script de verificare setup Flutter pentru LAB_1
# Verifică dacă toate dependențele sunt instalate și configurate corect

echo "╔════════════════════════════════════════════════════════════╗"
echo "║  Verificare Setup Flutter - PAM LAB_1                      ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Culori pentru output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Contor pentru probleme
ISSUES=0

# 1. Verifică dacă Flutter este instalat
echo "1️⃣  Verificare Flutter SDK..."
if command -v flutter &> /dev/null; then
    FLUTTER_VERSION=$(flutter --version | head -n 1)
    echo -e "${GREEN}✓${NC} Flutter este instalat: $FLUTTER_VERSION"
else
    echo -e "${RED}✗${NC} Flutter NU este instalat!"
    echo "   Instalează Flutter cu: brew install --cask flutter"
    echo "   Sau urmează ghidul: https://docs.flutter.dev/get-started/install/macos"
    ISSUES=$((ISSUES + 1))
fi
echo ""

# 2. Verifică Dart SDK
echo "2️⃣  Verificare Dart SDK..."
if command -v dart &> /dev/null; then
    DART_VERSION=$(dart --version 2>&1 | head -n 1)
    echo -e "${GREEN}✓${NC} Dart este instalat: $DART_VERSION"
else
    echo -e "${RED}✗${NC} Dart NU este instalat!"
    echo "   (De obicei vine cu Flutter)"
    ISSUES=$((ISSUES + 1))
fi
echo ""

# 3. Verifică dependențele proiectului
echo "3️⃣  Verificare dependențe proiect..."
if [ -d ".dart_tool/package_config.json" ] || [ -f "pubspec.lock" ]; then
    echo -e "${GREEN}✓${NC} Dependențele par a fi instalate"
    echo "   Pentru a re-instala: flutter pub get"
else
    echo -e "${YELLOW}⚠${NC} Dependențele nu sunt instalate"
    echo "   Rulează: flutter pub get"
    ISSUES=$((ISSUES + 1))
fi
echo ""

# 4. Rulează flutter doctor
if command -v flutter &> /dev/null; then
    echo "4️⃣  Verificare configurație Flutter (flutter doctor)..."
    echo "────────────────────────────────────────────────────────────"
    flutter doctor
    echo "────────────────────────────────────────────────────────────"
    echo ""
fi

# 5. Verifică ADB pentru dispozitive Android fizice
echo "5️⃣  Verificare ADB (pentru dispozitive Android fizice)..."
if command -v adb &> /dev/null; then
    echo -e "${GREEN}✓${NC} ADB este instalat"
    ADB_DEVICES=$(adb devices | grep -v "List" | grep "device$" | wc -l | tr -d ' ')
    if [ "$ADB_DEVICES" -gt 0 ]; then
        echo -e "${GREEN}✓${NC} Dispozitive Android conectate: $ADB_DEVICES"
        adb devices
    else
        echo -e "${YELLOW}⚠${NC} Niciun dispozitiv Android conectat via USB"
        echo "   Pentru a conecta un dispozitiv fizic (ex: Samsung S24):"
        echo "   1. Activează USB Debugging pe telefon"
        echo "   2. Conectează via USB"
        echo "   3. Acceptă permisiunea pe telefon"
    fi
else
    echo -e "${YELLOW}⚠${NC} ADB nu este instalat (necesar pentru dispozitive Android fizice)"
    echo "   Instalează Android Studio pentru a obține ADB"
fi
echo ""

# 6. Verifică dispozitivele disponibile
if command -v flutter &> /dev/null; then
    echo "6️⃣  Dispozitive disponibile pentru rulare..."
    echo "────────────────────────────────────────────────────────────"
    flutter devices
    echo "────────────────────────────────────────────────────────────"
    echo ""
fi

# Rezumat final
echo "╔════════════════════════════════════════════════════════════╗"
echo "║  Rezumat                                                   ║"
echo "╚════════════════════════════════════════════════════════════╝"
if [ $ISSUES -eq 0 ]; then
    echo -e "${GREEN}✓ Totul pare OK!${NC}"
    echo ""
    echo "Pentru a rula proiectul:"
    echo "  1. flutter pub get      (dacă nu ai făcut deja)"
    echo "  2. flutter run          (pornește aplicația)"
    echo ""
    echo "Pentru a rula testele:"
    echo "  flutter test"
else
    echo -e "${YELLOW}⚠ Au fost găsite $ISSUES probleme.${NC}"
    echo "Urmează pașii de mai sus pentru a le rezolva."
fi
echo ""
