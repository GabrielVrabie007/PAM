#!/usr/bin/env bash
# Construieste APK-ul (daca lipseste) si il serveste pe reteaua locala,
# ca sa-l descarci din browserul telefonului. Fara cloud, fara cablu.
#
#   ./tools/serve_apk.sh            # construieste doar daca lipseste
#   ./tools/serve_apk.sh --rebuild  # forteaza reconstruirea
#
# Telefonul si Mac-ul trebuie sa fie pe aceeasi retea WiFi.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APK_DIR="$ROOT/build/app/outputs/flutter-apk"
APK="app-arm64-v8a-release.apk"
PORT=8000

cd "$ROOT"

if [ "${1:-}" = "--rebuild" ] || [ ! -f "$APK_DIR/$APK" ]; then
  echo "==> Construiesc APK-ul release (dureaza 1-3 minute)..."
  flutter build apk --release --split-per-abi
fi

if [ ! -f "$APK_DIR/$APK" ]; then
  echo "Build-ul nu a produs $APK. Verifica output-ul de mai sus."
  exit 1
fi

IP=""
for iface in en0 en1 en2; do
  IP="$(ipconfig getifaddr "$iface" 2>/dev/null || true)"
  [ -n "$IP" ] && break
done
if [ -z "$IP" ]; then
  echo "Nu am putut determina IP-ul local. Esti conectat la WiFi?"
  exit 1
fi

URL="http://$IP:$PORT/$APK"
SIZE="$(du -h "$APK_DIR/$APK" | cut -f1)"

echo
echo "  Deschide pe telefon, in Chrome:"
echo
echo "      $URL"
echo
echo "  ($SIZE)"

# Cod QR, daca ai una dintre unelte instalata - altfel doar linkul de mai sus.
if command -v qrencode >/dev/null 2>&1; then
  echo
  qrencode -t ANSIUTF8 "$URL"
elif python3 -c "import qrcode" >/dev/null 2>&1; then
  echo
  python3 -c "import qrcode,sys; qrcode.QRCode().add_data(sys.argv[1]) or None" 2>/dev/null || true
  python3 - "$URL" <<'PY' 2>/dev/null || true
import sys, qrcode
q = qrcode.QRCode(border=1)
q.add_data(sys.argv[1])
q.print_ascii(invert=True)
PY
fi

echo
echo "  Ctrl+C opreste serverul dupa ce s-a descarcat."
echo

cd "$APK_DIR"
python3 -m http.server "$PORT" --bind 0.0.0.0
