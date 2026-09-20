# LAB_2 — GemStore

Reproducere fidelă în Flutter a două ecrane dintr-un design Figma:
**homepage** și **pagină de produs** pentru un magazin de haine.

---

## 1. Ce s-a realizat

Cele două ecrane nu sunt un mockup static — sunt legate prin navigare, iar pe
pagina de produs se poate selecta mărimea și culoarea și se pot deschide sau
închide secțiunile (Description, Reviews, Similar Product).

**Detaliul esențial:** designul nu a fost copiat vizual. Specificațiile au fost
extrase din Figma prin **REST API** — culori, fonturi, dimensiuni, poziții — iar
codul a fost construit din valorile exacte. Fiecare distanță verticală din cod
este diferența dintre două coordonate Y din design, nu o valoare aleasă din ochi.

---

## 2. Arhitectura

```
lib/
├── main.dart              punctul de intrare, tema aplicației
├── theme/                 culori + fonturi, o singură sursă de adevăr
│   ├── app_colors.dart    30 de culori, denumite după rol
│   └── app_theme.dart     ThemeData + stilurile de text
├── models/                ce ESTE un produs, o recenzie, o categorie
│   └── product.dart
├── data/                  conținutul concret (nume, prețuri, texte)
│   └── demo_data.dart
├── widgets/               9 componente reutilizabile
└── screens/               cele 2 ecrane, care asamblează widget-urile
    ├── home_screen.dart
    └── product_screen.dart
```

Principiul: **separarea a ce e, de cum arată, de unde e pus.**

| Se schimbă | Se editează |
|---|---|
| un preț | doar `data/demo_data.dart` |
| o culoare | doar `theme/app_colors.dart` — se propagă peste tot |
| aspectul unui card | doar `widgets/product_card.dart` — se actualizează în toate cele 3 locuri |

Fără această separare, o culoare ar fi hardcodată în ~40 de locuri.

---

## 3. Cum funcționează

### Navigarea

```
main() → GemStoreApp (MaterialApp, tema) → HomeScreen
                                               │
                    tap pe un card de produs   ▼
                              Navigator.push(ProductScreen)
                                               │
                              back / săgeata    ▼
                                           înapoi la HomeScreen
```

### Ciclul de redesenare

Când se apasă pastila „L" pe ecranul de produs:

```
tap → setState(() => _sizeIndex = 2)
    → Flutter marchează ecranul ca având nevoie de redesenare
    → rulează din nou build()
    → pastila L se desenează închisă, celelalte gri
```

Acesta este modelul **declarativ**: nu se modifică butonul, se modifică o
variabilă și Flutter redesenează pe baza ei.

---

## 4. Ce s-a folosit

### Widget-uri Flutter

| Categorie | Widget-uri |
|---|---|
| Structură | `MaterialApp`, `Scaffold` |
| Layout | `Column`, `Row`, `Stack`, `Positioned`, `Expanded`, `SafeArea`, `SingleChildScrollView`, `ListView.separated`, `SizedBox`, `Padding` |
| Formă | `Container`, `ClipRRect`, `ClipOval`, `Divider`, `BoxDecoration` |
| Conținut | `Text`, `Text.rich`, `Image.asset`, `Icon`, `LinearProgressIndicator` |
| Interacțiune | `GestureDetector`, `Navigator` |
| Animație | `AnimatedCrossFade`, `AnimatedRotation` |

**Trei decizii de layout:**

- **`Stack` + `Positioned`** pentru bannere — în design imaginile ies intenționat
  în afara cardului (o imagine de 229 px într-un card de 141 px). Doar `Stack`
  permite suprapunere; `Column`/`Row` nu.
- **`ListView` orizontal** pentru carusele — randează doar cardurile vizibile.
- **`ClipRRect`** oriunde designul are colțuri rotunjite — taie și imaginea, nu
  doar fundalul.

### Componentele scrise

| Widget | Unde apare |
|---|---|
| `SectionHeader` | „Feature Products / Show all" — de 3 ori |
| `ProductCard` | Feature Products, Similar Product |
| `RecommendedCard` | Recommended (card orizontal, imagine suprapusă) |
| `CategoryItem` | randul de categorii de sus |
| `BannerCaption` | liniuță verticală + etichetă + titlu — de 3 ori |
| `ExpandableSection` | Description, Reviews, Similar Product |
| `RatingBarRow` | cele 5 rânduri din histograma de recenzii |
| `StarRating` | rating produs, rating general, fiecare recenzie |
| `PageDots` | indicatorul de pagină, pe ambele ecrane |
| `MenuIcon`, `BellIcon` | iconițele din header |

Fiecare există pentru că apare de cel puțin două ori — nu de dragul abstracției.

### Pachete externe

**Unul singur: `google_fonts`.** Restul este Flutter pur — fără Provider, fără
Bloc, fără HTTP, fără bază de date. Decizie conștientă: pentru două ecrane cu
stare minimă, un state manager ar fi adăugat trei fișiere ca să rezolve o
problemă inexistentă.

---

## 5. Concepte demonstrate

| Concept | Unde |
|---|---|
| **StatelessWidget** | `ProductCard`, `SectionHeader`, `CategoryItem` — primesc date, desenează, nu țin minte nimic |
| **StatefulWidget + setState** | `HomeScreen` (categoria activă), `ProductScreen` (mărime, culoare, accordion-uri) |
| **Lifting state up** | `CategoryItem` nu decide nimic — primește `active`, trimite `onTap` în sus |
| **Composition over inheritance** | `Scaffold > SafeArea > SingleChildScrollView > Column > [...]` |
| **Design tokens** | `AppColors` / `AppTheme` — definite o singură dată |
| **Assets** | 18 imagini declarate în `pubspec.yaml`, incluse în APK, funcționează offline |
| **Navigare** | `Navigator.push` / `pushReplacement` |
| **Null safety** | `String?` pentru câmpuri opționale, verificate înainte de folosire |

---

## 6. Cum a fost obținut designul

1. Token Figma generat, interogare `api.figma.com` cu `GET` — **doar citiri**,
   zero modificări în fișierul original.
2. Parcurgerea arborelui de noduri și extragerea, pentru fiecare element:
   poziție, dimensiune, culoare (`fill`), font, `fontSize`, `lineHeight`,
   `letterSpacing`, `cornerRadius`.
3. Descărcarea celor 18 imagini prin endpoint-ul de `imageRef`
   (`tools/fetch_assets.py`).
4. Redimensionarea la 3× mărimea de afișare cu Pillow
   (`tools/optimize_assets.py`): **25.3 MB → 2.3 MB**. Un PNG de 12 MB afișat pe
   312×168 px este risipă — încetinește pornirea și umflă APK-ul fără câștig
   vizual.

---

## 7. Compromisuri asumate

| Ce | De ce |
|---|---|
| **Poppins în loc de Product Sans** | Product Sans este font proprietar Google, nedistribuibil legal. Poppins este cel mai apropiat geometric liber. |
| **Selecția de culoare are contur** | În Figma indicatorul este un cerc *alb pe fundal alb* — invizibil. S-a adăugat un contur subțire. |
| **Bara de status reală** | Designul conține un mock „9:41"; aplicația folosește `SafeArea` și bara adevărată a telefonului. |
| **Design pentru 375 px** | Galaxy S24 are ~360 dp. Diferența de 15 px se resimte minim. Soluția scalabilă ar fi un factor `lățime / 375` aplicat global. |

---

## 8. Întrebări frecvente

**De ce `ProductScreen` este Stateful, dar `ProductCard` nu?**
`ProductScreen` ține minte ce este selectat, iar acea stare se schimbă în timp.
`ProductCard` primește un produs prin constructor și doar îl desenează.

**Ce face `setState`?**
Marchează widget-ul ca având nevoie de redesenare. Nu desenează el — programează
rularea lui `build()` la următorul frame. Fără `setState`, variabila se schimbă
dar ecranul nu.

**De ce sunt separate `widgets/` și `screens/`?**
Ca aspectul unui card să se schimbe într-un singur loc, nu în trei.
`ProductCard` apare în „Feature Products" și în „Similar Product".

**De unde vin culorile exacte?**
Din API-ul Figma, nu cu pipeta. Sunt în `theme/app_colors.dart`, denumite după
rol — `AppColors.accent`, nu `AppColors.green`.

**De ce `pushReplacement` la produsele similare?**
Ca să nu se stivuiască zeci de ecrane de produs în memorie la navigare
succesivă. Back-ul se întoarce direct la homepage.

**Merge offline?**
Da. Imaginile sunt în APK. Doar fontul se descarcă la prima pornire, apoi rămâne
în cache.

---

## 9. Rezumat în 30 de secunde

> Am reprodus două ecrane Figma în Flutter, extrăgând specificațiile prin API-ul
> Figma în loc să le aproximez vizual. Arhitectura separă tema, datele,
> componentele reutilizabile și ecranele — 9 widget-uri compun ambele pagini.
> Starea e minimă și locală, gestionată cu `setState`, fără bibliotecă externă,
> pentru că două ecrane statice nu justifică una. Imaginile le-am optimizat de la
> 25 MB la 2.3 MB.

---

## 10. Rulare

```bash
flutter pub get
flutter run                       # pe dispozitivul conectat
flutter analyze                   # verificare statică
flutter test                      # smoke test

./tools/serve_apk.sh              # build APK + server local pentru instalare pe telefon
```

Scripturi auxiliare:

| Script | Ce face |
|---|---|
| `tools/fetch_assets.py` | descarcă imaginile din Figma (`FIGMA_TOKEN=... python3 tools/fetch_assets.py`) |
| `tools/optimize_assets.py` | redimensionează imaginile la 3× mărimea de afișare |
| `tools/serve_apk.sh` | construiește APK-ul și îl servește în rețeaua locală |
