# Ghid complet al proiectului — LAB_1, Conversie monedă

Document de studiu pentru prezentare. Explică structura, limbajul Dart
(prin comparație cu Python) și fiecare fișier din proiect.

---

## Cuprins

1. [Structura proiectului](#1-structura-proiectului)
2. [Dart pentru un programator Python](#2-dart-pentru-un-programator-python)
3. [Cele două idei mari din Flutter](#3-cele-două-idei-mari-din-flutter)
4. [Fiecare fișier, pe rând](#4-fiecare-fișier-pe-rând)
5. [Librăriile folosite](#5-librăriile-folosite)
6. [Testele](#6-testele)
7. [Întrebări probabile la prezentare](#7-întrebări-probabile-la-prezentare)

---

## 1. Structura proiectului

### Ce e impus și ce am ales

Distincția asta contează — profesorul te poate întreba de ce ai organizat așa.

#### Foldere din rădăcină

| Folder | Cine îl impune | Ce conține |
|---|---|---|
| `lib/` | **Dart, obligatoriu** | Tot codul sursă |
| `test/` | **Flutter, obligatoriu** | `flutter test` caută exclusiv aici |
| `android/` | Flutter | Proiect Android nativ (Gradle, AndroidManifest) |
| `ios/` | Flutter | Proiect Xcode |
| `docs/` | Tu | Cerința temei + acest ghid |
| `build/` | Generat automat | Rezultatul compilării (APK). Ca `dist/` în Python |
| `.dart_tool/` | Generat automat | Cache. Ca `__pycache__/` |
| `.idea/` | Android Studio | Setări IDE, nu ține de Flutter |

`lib/` nu e o alegere estetică. Când scrii
`import 'package:lab1_currency_converter/models/currency.dart'`,
cuvântul `package:` se traduce literal în „caută în `lib/`". Dacă redenumești
folderul, tot proiectul crapă.

#### Fișiere din rădăcină

| Fișier | Echivalent Python |
|---|---|
| `pubspec.yaml` | `requirements.txt` + `setup.py` — nume, versiune, dependențe |
| `pubspec.lock` | `poetry.lock` — versiunile exacte, pentru reproductibilitate |
| `analysis_options.yaml` | `.flake8` / `ruff.toml` — regulile linterului |
| `.metadata` | Intern Flutter — versiunea cu care s-a creat proiectul |
| `.gitignore` | Identic |
| `lab1_currency_converter.iml` | Fișier IntelliJ, ignorabil |

### Structura din `lib/` — alegerea mea

```
lib/
├── main.dart          ← numele e convenție puternică (flutter run îl caută)
├── models/
├── data/
├── services/
├── screens/
└── widgets/
```

Subfolderele le-am ales **eu**. Flutter nu impune nimic — ai putea pune toate
cele 9 fișiere direct în `lib/` și ar funcționa identic.

Dar nu e arbitrar: e tiparul **layer-first architecture**, cel mai răspândit
în comunitatea Flutter. Regula:

> Fiecare folder = un nivel de responsabilitate, iar dependențele merg
> într-o singură direcție.

```
screens/ + widgets/    ← UI (importă Flutter)
        ↓ folosește
services/              ← logică pură (NU importă Flutter)
        ↓ folosește
models/ + data/        ← date brute
```

Săgețile merg doar în jos. `services/currency_converter.dart` nu importă
niciodată `flutter/material.dart` — de asta poate fi testat fără interfață.

**Motivul real, într-o frază:** ca logica să fie testabilă independent de UI.

### Numele fișierelor

`snake_case.dart`, ca în Python. Diferența: în Dart linterul dă **eroare**
dacă scrii `CurrencyConverter.dart`. Regula se numește `file_names` și e
activă implicit. Nu e opțional ca în Python.

---

## 2. Dart pentru un programator Python

Dart seamănă mai mult cu Java/C# decât cu Python.

### Sintaxă de bază

| Python | Dart | Observație |
|---|---|---|
| indentare | `{ }` | indentarea e doar cosmetică |
| (nimic) | `;` obligatoriu | uiți unul → eroare de compilare |
| `# comentariu` | `// comentariu` | `///` = docstring |
| `def f(x):` | `void f(int x) { }` | tipul de retur vine **înainte** de nume |
| `x = 5` | `int x = 5;` / `var x = 5;` | `var` deduce tipul |
| `f"{a} - {b}"` | `'$a - $b'` | `${expresie}` pentru ceva complex |
| `[f(x) for x in l]` | `l.map((x) => f(x)).toList()` | fără list comprehension |
| `lambda x: x*2` | `(x) => x * 2` | `=>` = return o singură expresie |
| `None` | `null` | |
| `raise` | `throw` | |
| `ValueError` | `ArgumentError` | aproximativ |
| `.strip()` | `.trim()` | |
| `isinstance(x, T)` | `x is T` | |

### Tipuri — diferența cea mai mare

În Python, type hints sunt decorative:

```python
def add(a: int, b: int) -> int:   # poți trimite string, merge
    return a + b
```

În Dart sunt **obligatorii și verificate la compilare**. Programul nu rulează
dacă tipurile nu se potrivesc. De asta `flutter analyze` prinde erorile
înainte de rulare.

### `final` / `const` / `var`

| Cuvânt | Sens |
|---|---|
| `var` | valoarea se poate schimba |
| `final` | se setează o dată, la rulare, apoi e blocată |
| `const` | valoare cunoscută la **compilare**, „bătută în cuie" în binar |

Python n-are echivalent real. `final` ≈ variabilă pe care promiți să n-o
reatribui.

De ce contează `const` în Flutter: un widget `const` **nu se reconstruiește
niciodată**. E optimizare de performanță. De asta apare
`const SizedBox(height: 16)` peste tot.

### Null safety — `?` și `!`

Conceptul care încurcă cel mai mult la început.

```dart
String name;    // NU poate fi null — compilatorul refuză
String? name;   // POATE fi null — trebuie verificat înainte de folosire
```

```dart
double? value;
print(value.toString());   // ❌ eroare — poate fi null
print(value!.toString());  // ✅ „garantez că nu e null" (crapă dacă greșești)
if (value != null) {
  print(value.toString()); // ✅ compilatorul vede verificarea
}
```

În Python orice poate fi `None` și afli abia la rulare, prin `AttributeError`.
În Dart afli la compilare. **Ăsta e cel mai mare avantaj practic al Dart.**

### Parametri cu nume

```dart
double convert({
  required double amount,
  required Currency from,
  required Currency to,
})
```

Acoladele `{ }` fac parametrii **numiți**:

```dart
converter.convert(amount: 100, from: eur, to: mdl);   // ✅
converter.convert(100, eur, mdl);                     // ❌ nu compilează
```

Echivalentul lui `def convert(*, amount, from, to)` din Python.

Am făcut asta intenționat: `convert(100, eur, mdl)` e ambiguu (care e sursa?),
pe când varianta cu nume se citește singură.

`required` = obligatoriu. Fără el, parametrul e opțional și trebuie să fie
nullable.

### Clase — comparație directă

```python
# Python
class Currency:
    def __init__(self, code, name):
        self.code = code
        self.name = name

    @property
    def label(self):
        return f"{self.code} - {self.name}"

    def __eq__(self, other):
        return self.code == other.code

    def __hash__(self):
        return hash(self.code)

    def __str__(self):
        return self.code
```

```dart
// Dart — exact același lucru
class Currency {
  final String code;
  final String name;

  const Currency({required this.code, required this.name});

  String get label => '$code - $name';

  @override
  bool operator ==(Object other) => other is Currency && other.code == code;

  @override
  int get hashCode => code.hashCode;

  @override
  String toString() => code;
}
```

| Python | Dart |
|---|---|
| `__init__` | constructorul (are numele clasei) |
| `self` | `this` (adesea se poate omite) |
| `@property` | `get` |
| `__eq__` | `operator ==` |
| `__hash__` | `hashCode` |
| `__str__` | `toString()` |
| `@staticmethod` | `static` |
| `_privat` (convenție) | `_privat` (**impus de compilator**) |

Ultima linie e importantă: în Python `_x` e o înțelegere între programatori,
poți accesa oricum. În Dart `_x` e **inaccesibil din alt fișier**. De asta
clasa `_ConverterScreenState` e privată.

`@override` = declari explicit că înlocuiești o metodă din clasa părinte.
Dacă greșești numele, compilatorul te oprește.

---

## 3. Cele două idei mari din Flutter

### Ideea 1: Totul este un Widget

Nu există „ferestre", „butoane" și „texte" ca obiecte diferite. Totul e widget
— inclusiv spațiul gol, padding-ul, centrarea.

Widget-urile se compun într-un **arbore**:

```
Scaffold                     (structura ecranului)
├── AppBar                   (bara de sus)
│   └── Text                 ("Conversie moneda")
└── SingleChildScrollView    (permite scroll)
    └── Column               (aranjează pe verticală)
        ├── TextField        ← suma
        ├── SizedBox         ← spațiu gol de 20px
        ├── CurrencyDropdown ← widget propriu
        ├── IconButton       ← swap
        ├── CurrencyDropdown
        ├── ElevatedButton   ← Convertește
        └── ConversionResultCard
```

Când citești `build()`, citești literal acest arbore. Indentarea codului =
structura vizuală de pe ecran.

### Ideea 2: UI = funcție de stare

Formula de reținut:

```
UI = build(state)
```

Nu modifici niciodată butonul sau textul direct. În schimb:

1. Modifici o variabilă
2. Anunți Flutter că s-a schimbat
3. Flutter reapelează `build()` și redesenează

De asta există două tipuri de widget:

| Tip | Când îl folosești |
|---|---|
| `StatelessWidget` | Nu se schimbă nimic. Primește date, le afișează. |
| `StatefulWidget` | Are date care se schimbă în timp. |

În proiect: `ConverterScreen` e Stateful (suma și valutele se schimbă).
`CurrencyDropdown` și `ConversionResultCard` sunt Stateless.

**`setState()`** e mecanismul de anunțare:

```dart
setState(() {
  _result = 'ceva nou';
});
```

Fără `setState`, variabila se schimbă dar **ecranul rămâne neschimbat**.
E greșeala numărul 1 a începătorilor în Flutter.

---

## 4. Fiecare fișier, pe rând

### `lib/models/currency.dart` — ce ESTE o valută

Container de date. În Python ar fi `@dataclass(frozen=True)`.

```dart
final String code;        // "EUR"
final String name;        // "Euro"
final String symbol;      // "€"
final double rateToBase;  // 1.0
```

Toate `final` → obiectul e **imutabil**. Odată creată, o valută nu se mai
schimbă. Previne bug-uri.

Partea importantă:

```dart
@override
bool operator ==(Object other) => other is Currency && other.code == code;
```

**De ce?** Fără asta, Dart compară obiectele după adresa din memorie.
`DropdownButton` compară valuta selectată cu cele din listă — fără `==`,
dropdown-ul n-ar ști care element e selectat.

Când suprascrii `==`, ești **obligat** să suprascrii și `hashCode` — regulă
identică cu Python.

### `lib/data/currency_rates.dart` — cursurile fixe

Aici e cerința „cursuri valutare fixe introduse direct în aplicație".

```dart
class CurrencyRates {
  const CurrencyRates._();
```

`._()` e un **constructor privat fără corp**. Efectul: nimeni nu poate scrie
`CurrencyRates()`. Clasa devine container de constante — echivalentul unui
modul Python cu variabile globale. Dart nu are module cu variabile libere,
deci se folosește acest tipar.

```dart
static const Currency eur = Currency(code: 'EUR', ..., rateToBase: 1.0);
static const List<Currency> all = [eur, usd, mdl, ron, gbp, uah];
```

`static` = aparține clasei, nu unei instanțe.

#### Decizia de design: moneda de bază

Toate cursurile sunt raportate la **o singură monedă de bază** (EUR).

Alternativa naivă — tabel cu toate perechile:

```
EUR→USD, EUR→MDL, EUR→RON, EUR→GBP, EUR→UAH,
USD→EUR, USD→MDL, ...
```

Pentru 6 valute = **30 de valori** de întreținut. Dacă greșești una, obții
inconsistențe: poți converti EUR→USD→EUR și să nu revii la suma inițială.

Cu monedă de bază: **6 valori**. Formula: `N` în loc de `N×(N-1)`.
Consistența e garantată matematic.

### `lib/services/currency_converter.dart` — formula

```dart
double exchangeRate(Currency from, Currency to) {
  return from.rateToBase / to.rateToBase;
}
```

Derivarea, pentru tablă:

```
1 EUR = 1.0    unități de bază      (rateToBase = 1.0)
1 MDL = 0.052  unități de bază      (rateToBase = 0.052)

Deci:  1 EUR = 1.0 / 0.052 MDL = 19.23 MDL
```

Generalizat: `curs(A→B) = A.rateToBase / B.rateToBase`

Verificare rapidă: dacă `A == B`, atunci `A.rate / A.rate = 1`. Cursul unei
valute față de ea însăși e 1. ✓ (există test exact pentru asta)

```dart
if (amount < 0) {
  throw ArgumentError.value(amount, 'amount', 'Suma nu poate fi negativa');
}
```

Clasa **nu importă `flutter/material.dart`**, doar `models/currency.dart`.
De asta poate fi testată fără interfață.

### `lib/services/amount_parser.dart` — validarea

Cel mai interesant fișier sintactic.

```dart
class ParsedAmount {
  final double? value;
  final String? error;

  const ParsedAmount.valid(double this.value) : error = null;
  const ParsedAmount.invalid(String this.error) : value = null;
}
```

Trei elemente noi:

1. **Constructori numiți.** Dart permite mai mulți constructori dacă le dai
   nume. Python n-are asta direct — ai folosi `@classmethod`.
2. **`: error = null`** — *initializer list*, rulează **înainte** de corpul
   constructorului.
3. **`double this.value`** — scurtătură: „ia parametrul și pune-l direct în
   câmp". Echivalentul lui `self.value = value`, dar automat.

**De ce clasa asta în loc de excepție?** Input invalid de la utilizator **nu e
o situație excepțională** — e normal ca cineva să apese butonul cu câmpul gol.
Excepțiile sunt pentru bug-uri, nu pentru fluxul normal.

```dart
final text = input.trim().replaceAll(',', '.');
```

Înlocuiesc virgula cu punct pentru că `double.tryParse` înțelege doar punctul,
dar tastatura poate pune virgulă.

```dart
final value = double.tryParse(text);
```

`tryParse` returnează `null` în loc să arunce excepție. În Python:
`try: float(x) except ValueError:`.

### `lib/services/money_formatter.dart` — afișarea

```dart
final NumberFormat _amountFormat = NumberFormat('#,##0.00', 'en_US');
```

Singura librărie externă. `#,##0.00` e un șablon:

- `#,##` → separator de mii
- `0.00` → exact 2 zecimale, cu zerouri dacă e nevoie

`1923.0769...` → `1,923.08`

Fără asta ai afișa `1923.076923076923` pe ecran.

### `lib/widgets/currency_dropdown.dart` — dropdown reutilizabil

`StatelessWidget` — primește totul din exterior.

```dart
final ValueChanged<Currency> onChanged;
```

`ValueChanged<Currency>` e un **tip de funcție**: „primește un `Currency`, nu
returnează nimic". În Python: `Callable[[Currency], None]`.

Ăsta e tiparul **callback**: widget-ul copil nu știe ce se întâmplă când
alegi o valută. Doar strigă „s-a ales X" și părintele decide. De asta îl pot
folosi de **două ori**, cu comportamente diferite.

```dart
currencies.map((c) => DropdownMenuItem<Currency>(
  value: c,
  child: Text(c.label),
)).toList()
```

În Python: `[DropdownMenuItem(value=c, child=Text(c.label)) for c in currencies]`

```dart
onChanged: (selected) {
  if (selected != null) {
    onChanged(selected);
  }
}
```

Flutter poate trimite `null` dacă utilizatorul închide meniul fără să aleagă.
Filtrez acel caz.

### `lib/screens/converter_screen.dart` — creierul aplicației

```dart
class ConverterScreen extends StatefulWidget {         // configurația (imutabilă)
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {  // starea (mutabilă)
  // aici trăiesc variabilele care se schimbă
}
```

**De ce două clase?** Widget-ul e distrus și recreat des (la fiecare
redesenare). Starea trebuie să supraviețuiască. Flutter le ține separate.

#### Starea

```dart
final _amountController = TextEditingController();

Currency _from = CurrencyRates.eur;
Currency _to = CurrencyRates.mdl;

String? _amountError;
String? _result;
String? _rateInfo;
```

`TextEditingController` ține textul din `TextField`. Îl citești cu `.text`.

Cele trei `String?` sunt nullable — `null` înseamnă „nimic de afișat încă".
De asta la pornire nu vezi cardul cu rezultat.

```dart
@override
void dispose() {
  _amountController.dispose();
  super.dispose();
}
```

`dispose()` = curățenie la închiderea ecranului. Controller-ul ocupă memorie;
fără eliberare ai **memory leak**. Echivalentul lui `__exit__` / `close()`.

**Regulă absolută în Flutter: orice controller creat trebuie eliberat.**

#### Metoda `_convert()` — aici se leagă straturile

```dart
void _convert() {
  final parsed = _parser.parse(_amountController.text);   // 1. validez

  if (!parsed.isValid) {                                  // 2. eroare?
    setState(() {
      _amountError = parsed.error;
      _result = null;
    });
    return;                                               //    ies devreme
  }

  final converted = _converter.convert(                   // 3. calculez
    amount: parsed.value!, from: _from, to: _to,
  );
  final rate = _converter.exchangeRate(_from, _to);

  setState(() {                                           // 4. actualizez
    _amountError = null;
    _result = _formatter.formatAmount(converted, _to);
    _rateInfo = _formatter.formatRate(rate, _from, _to);
  });
}
```

Observă cât e de scurtă. Toată logica grea e în servicii. Metoda doar
orchestrează: validează → calculează → afișează. Asta înseamnă „separare pe
straturi" în practică.

`parsed.value!` — `!` spune „știu că nu e null". E sigur pentru că tocmai am
verificat `isValid`.

#### Metoda `build()`

```dart
TextField(
  controller: _amountController,
  keyboardType: const TextInputType.numberWithOptions(decimal: true),
  inputFormatters: [
    FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
  ],
  decoration: InputDecoration(
    labelText: 'Suma',
    errorText: _amountError,
  ),
)
```

- `keyboardType` → de asta apare tastatura numerică, nu cea alfabetică
- `inputFormatters` → blochează fizic tastarea literelor (validare preventivă)
- `errorText: _amountError` → dacă e `null` nu apare nimic; dacă are text,
  chenarul devine roșu **automat**

```dart
if (_result != null)
  ConversionResultCard(result: _result!, rateInfo: _rateInfo),
```

`if` direct în lista de widget-uri — sintaxă specifică Dart (*collection if*).
Adaugă cardul în arbore doar dacă există rezultat.

### `lib/main.dart` — punctul de intrare

```dart
void main() {
  runApp(const CurrencyConverterApp());
}
```

`main()` = `if __name__ == "__main__":`. `runApp()` pornește Flutter cu
widget-ul dat ca rădăcină a arborelui.

```dart
theme: ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
  useMaterial3: true,
),
```

`fromSeed` generează o **paletă completă** dintr-o singură culoare, după
algoritmul Material 3. De asta cardul are exact nuanța potrivită fără s-o fi
ales manual.

---

## 5. Librăriile folosite

Patru, dintre care **una singură externă**:

| Librărie | Sursă | Ce am folosit |
|---|---|---|
| `flutter/material.dart` | Flutter SDK | `Scaffold`, `TextField`, `DropdownButtonFormField`, `ElevatedButton`, `Text`, `Card`, `Column`, `Theme` |
| `flutter/services.dart` | Flutter SDK | `FilteringTextInputFormatter`, `TextInputType` |
| `intl` | **externă** (pub.dev) | `NumberFormat` |
| `flutter_test` | Flutter SDK | doar în `test/` |

`material.dart` implementează **Material Design**, sistemul de design Google.
De asta aplicația arată nativ pe Android fără să fi desenat nimic manual.

În `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  intl: ^0.20.3
```

`^0.20.3` = „acceptă de la 0.20.3 până sub 0.21.0". Ca `intl~=0.20.3`.

**Punct forte:** o singură dependență externă. Proiectul nu e umflat cu
pachete pentru ceva ce se rezolvă în 20 de linii.

---

## 6. Testele

19 teste în trei fișiere:

| Fișier | Ce testează |
|---|---|
| `currency_converter_test.dart` | Formula de conversie (8 teste) |
| `amount_parser_test.dart` | Validarea input-ului (7 teste) |
| `widget_test.dart` | Interfața completă (4 teste) |

```dart
test('converteste din moneda de baza (EUR -> MDL)', () {
  final result = converter.convert(amount: 1, from: eur, to: mdl);
  expect(result, closeTo(19.2308, 0.001));
});
```

`expect(x, matcher)` = `assert` din pytest.

**`closeTo` în loc de egalitate** — `double` are erori de rotunjire binară.
`0.1 + 0.2 != 0.3` e adevărat și în Python, și în Dart. Nu compari niciodată
numere zecimale cu `==`.

Cel mai bun test din suită:

```dart
test('conversia dus-intors returneaza suma initiala', () {
  final toUsd = converter.convert(amount: 250, from: mdl, to: usd);
  final backToMdl = converter.convert(amount: toUsd, from: usd, to: mdl);
  expect(backToMdl, closeTo(250, 0.0001));
});
```

Nu verifică o valoare anume, ci o **proprietate matematică**: conversia trebuie
să fie reversibilă. Genul ăsta de test prinde erori de logică neanticipate.

Rulare:

```bash
flutter test
```

---

## 7. Întrebări probabile la prezentare

**„Explică-mi arhitectura."**
> Am separat pe trei straturi. Modelele și datele conțin valutele și cursurile.
> Serviciile conțin logica pură — conversie, validare, formatare — și nu
> importă nimic din Flutter, de asta pot fi testate independent. Interfața
> folosește serviciile, dar nu conține logică de calcul.

**„De ce monedă de bază?"**
> Ca să am 6 cursuri în loc de 30 de perechi, și ca să fie garantat
> consistente între ele.

**„De ce StatefulWidget?"**
> Pentru că ecranul are date care se schimbă — suma, valutele, rezultatul.
> `setState` anunță Flutter să reconstruiască interfața.

**„Ce e `setState`?"**
> Mecanismul prin care anunți framework-ul că starea s-a schimbat. Flutter
> reapelează `build()` și redesenează. Fără el, variabila se schimbă dar
> ecranul rămâne la fel.

**„De ce ai suprascris `operator ==`?"**
> Ca `DropdownButton` să poată compara valuta selectată cu cele din listă.
> Implicit, Dart compară după adresa din memorie.

**„De ce nu arunci excepție la input invalid?"**
> Pentru că un câmp gol nu e o situație excepțională, e flux normal.
> Excepțiile le păstrez pentru bug-uri de programare.

**„Ce face `dispose()`?"**
> Eliberează `TextEditingController`-ul la închiderea ecranului, ca să nu am
> memory leak.

**„De ce `closeTo` în teste și nu egalitate?"**
> Pentru că numerele `double` au erori de rotunjire binară.

Dacă te întreabă ceva ce nu știi — spune sincer. E mai bine decât să inventezi.
