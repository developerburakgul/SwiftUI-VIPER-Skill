# DynamicColor Usage

> BurakKit paketinin `DynamicColor` modülü — `import DynamicColor`

## Genel Mekanizma

Tema değişiklikleri UIKit'in `overrideUserInterfaceStyle` API'si ile tüm window'lara global olarak uygulanır. Bu sayede `static var` olarak tanımlanan renkler dahil tüm `@DynamicColor` property'leri anında güncellenir — ekstra binding veya environment değişkeni gerekmez.

## AppTheme

`public enum AppTheme: String, CaseIterable, Identifiable, Hashable, Sendable` — Kullanılabilir tema seçenekleri.

```swift
public enum AppTheme: String, CaseIterable, Identifiable, Hashable, Sendable {
    case system
    case light
    case dark

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .system: return "System"
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }
}
```

- `id` → `rawValue` döner (`Identifiable` conformance)
- `title` → İngilizce label döner: `"System"`, `"Light"`, `"Dark"`
- `CaseIterable` sayesinde `AppTheme.allCases` ile tüm case'ler iterate edilebilir

## ThemeStore

`@MainActor public final class ThemeStore: ObservableObject, Sendable` — Tema yönetimi singleton'ı. UserDefaults'a otomatik persist eder.

```swift
// Olası değerler
ThemeStore.shared.theme = .system  // Cihaz ayarını takip eder
ThemeStore.shared.theme = .light
ThemeStore.shared.theme = .dark
```

### Detaylar

- `init` **internal** erişim seviyesinde — dışarıdan yalnızca `ThemeStore.shared` kullanılabilir
- Tema değiştiğinde `didSet` tetiklenir → UserDefaults'a kaydeder + `applyInterfaceStyle()` çağırır
- `applyInterfaceStyle()` **public** — tüm `connectedScenes` window'larını iterate edip `overrideUserInterfaceStyle` set eder
- UserDefaults key: `"app_theme"` (hardcoded, override edilemez)

### Startup'ta tema uygulama

`ThemeStore` init olduğunda `applyInterfaceStyle()` çağrılır ama henüz window'lar hazır değildir. Bu yüzden App entry point'te scene hazır olduktan sonra tekrar çağrılmalıdır:

```swift
WindowGroup {
    delegate.builder.appView()
        .task { ThemeStore.shared.applyInterfaceStyle() }
}
```

### Ayarlar ekranı örneği

```swift
struct SettingsScreen: View {
    @ObservedObject private var themeStore = ThemeStore.shared

    var body: some View {
        Picker("Theme", selection: $themeStore.theme) {
            ForEach(AppTheme.allCases) { theme in
                Text(theme.title).tag(theme)
            }
        }
        .pickerStyle(.segmented)
    }
}
```

## @DynamicColor Property Wrapper

`@MainActor @propertyWrapper public struct DynamicColor: DynamicProperty` — Tema değişikliklerine otomatik tepki veren renk tanımları.

- `@MainActor` annotation'ı taşır — kullanan tiplerde main actor bağımlılığı oluşur
- `DynamicProperty` conformance'ı sayesinde SwiftUI view'ları otomatik re-render olur
- Hem instance hem `static` property olarak kullanılabilir

6 farklı init varyantı:

```swift
// 1. SwiftUI Color çifti — light ve dark ayrı
@DynamicColor(light: .white, dark: .black)
var background: Color

// 2. UIColor çifti
@DynamicColor(uiColorLight: UIColor.systemBackground, uiColorDark: UIColor.black)
var surface: Color

// 3. UIColor sistem rengi — light/dark otomatik resolve edilir
@DynamicColor(systemColor: UIColor.systemBlue)
var systemBlue: Color

// 4. SwiftUI sistem rengi — light/dark otomatik resolve edilir
@DynamicColor(systemColor: Color.blue)
var blue: Color

// 5. Hex çifti
@DynamicColor(hexLight: "#FFFFFF", hexDark: "#1C1C1E")
var card: Color

// 6. Tek hex — her iki temada aynı renk
@DynamicColor(hex: "#FF5733")
var highlight: Color
```

## Color(hex:) — Standalone Hex Init

`DynamicColor` modülü `Color`'a hex init ekler. `@DynamicColor` dışında da kullanılabilir:

```swift
let custom = Color(hex: "#34C759")
```

> **Uyarı:** `Color(hex:)` dahili olarak `UIColor(hex:)` üzerinden çalışır. Geçersiz hex string (yanlış uzunluk, hex olmayan karakter) verildiğinde `precondition` ile **runtime crash** oluşur. `Palette` enum'undaki static sabitler güvenlidir, ancak runtime'da dinamik oluşturulan hex string'lerde dikkatli olunmalıdır.

## Design Pattern — `{AppName}Design.swift`

Her projede `Design/{AppName}Design.swift` dosyası renk tanımlarını barındırır. İki bölümden oluşur:

1. **System** — `System` enum'u altında iOS sistem renkleri (`UIColor.systemBackground`, `UIColor.label` vb.). `@DynamicColor(systemColor:)` ile tanımlanır. Light/dark geçişlerini Apple otomatik yönetir. Bu bölüm değiştirilmez.
2. **CUSTOM** — Uygulamaya özel renkler. `CustomPalette` enum'unda hex değerleri tutulur, serbestçe düzenlenebilir.

### Full Template

Tam `{AppName}Design.swift` template kodu: `templates/project/Design/__AppName__Design.swift`

Template iki bölümden oluşur:
- **System** — `@DynamicColor(systemColor:)` ile iOS sistem renkleri (değiştirilmez)
- **CUSTOM** — `CustomPalette` enum'unda hex değerleri + `Accent` gibi kategoriler (serbestçe düzenlenebilir)

### Screen'lerde kullanım

```swift
struct ExploreScreen: View {
    @StateObject var presenter: ExplorePresenter

    var body: some View {
        ZStack {
            MyAppDesign.System.systemBackground.ignoresSafeArea()

            VStack(spacing: 16) {
                Text("Keşfet")
                    .foregroundStyle(MyAppDesign.System.label)

                Text("Alt başlık")
                    .foregroundStyle(MyAppDesign.System.secondaryLabel)

                Button("Devam Et") {
                    presenter.onContinuePressed()
                }
                .tint(MyAppDesign.Accent.primary)
            }
        }
    }
}
```

### Design kuralları

- **System enum** `@DynamicColor(systemColor:)` ile `UIColor` sistem renklerini sarar — hex gerekmez, Apple light/dark'ı yönetir. İsimlendirme Apple ile birebir aynı
- **CUSTOM bölümü** `CustomPalette` enum'u **private** — sadece `{AppName}Design` içinden erişilir
- Hex değişince sadece `CustomPalette`'te güncellenir, kullanan tüm yerler otomatik değişir
- Kullanım: `AppDesign.System.label`, `AppDesign.System.systemBackground`, `AppDesign.Accent.primary`
- Yeni kategori gerekirse CUSTOM bölümüne aynı pattern ile enum eklenir (ör. `Brand`, `Gradient`, `Badge`)
- Design enum'u `{AppName}Design` olarak adlandırılır
