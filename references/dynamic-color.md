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
- `applyInterfaceStyle()` tüm `connectedScenes` window'larını iterate edip `overrideUserInterfaceStyle` set eder
- UserDefaults key: `"app_theme"` (hardcoded, override edilemez)

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

Her projede `Design/{AppName}Design.swift` dosyası renk tanımlarını barındırır. İç içe enum'lar ile mantıksal gruplama yapılır. Hex değerleri `Palette` enum'unda tek yerde tutulur — yarın değişirse tek noktadan güncellenir.

```swift
import DynamicColor
import SwiftUI

enum MyAppDesign {

    // MARK: - Palette — Tüm hex değerleri tek kaynak

    private enum Palette {
        static let white       = "#FFFFFF"
        static let black       = "#000000"
        static let gray50      = "#F2F2F7"
        static let gray100     = "#E5E5EA"
        static let gray200     = "#C6C6C8"
        static let gray600     = "#48484A"
        static let gray700     = "#3C3C43"
        static let darkGray50  = "#3A3A3C"
        static let darkGray100 = "#2C2C2E"
        static let darkGray200 = "#1C1C1E"
        static let darkGray300 = "#38383A"
        static let blue        = "#007AFF"
        static let blueDark    = "#0A84FF"
        static let purple      = "#5856D6"
        static let purpleDark  = "#5E5CE6"
        static let green       = "#34C759"
        static let greenDark   = "#30D158"
        static let orange      = "#FF9500"
        static let orangeDark  = "#FF9F0A"
        static let red         = "#FF3B30"
        static let redDark     = "#FF453A"
        static let foregroundSecondaryDark = "#EBEBF5"
        static let foregroundTertiaryDark  = "#AEAEB2"
    }

    // MARK: - Background

    enum Background {
        @DynamicColor(hexLight: Palette.white, hexDark: Palette.darkGray200)
        static var primary: Color

        @DynamicColor(hexLight: Palette.gray50, hexDark: Palette.darkGray100)
        static var secondary: Color

        @DynamicColor(hexLight: Palette.gray100, hexDark: Palette.darkGray50)
        static var tertiary: Color
    }

    // MARK: - Foreground

    enum Foreground {
        @DynamicColor(light: .black, dark: .white)
        static var primary: Color

        @DynamicColor(hexLight: Palette.gray700, hexDark: Palette.foregroundSecondaryDark)
        static var secondary: Color

        @DynamicColor(hexLight: Palette.gray600, hexDark: Palette.foregroundTertiaryDark)
        static var tertiary: Color
    }

    // MARK: - Accent

    enum Accent {
        @DynamicColor(hexLight: Palette.blue, hexDark: Palette.blueDark)
        static var primary: Color

        @DynamicColor(hexLight: Palette.purple, hexDark: Palette.purpleDark)
        static var secondary: Color
    }

    // MARK: - Semantic

    enum Semantic {
        @DynamicColor(hexLight: Palette.green, hexDark: Palette.greenDark)
        static var success: Color

        @DynamicColor(hexLight: Palette.orange, hexDark: Palette.orangeDark)
        static var warning: Color

        @DynamicColor(hexLight: Palette.red, hexDark: Palette.redDark)
        static var error: Color

        @DynamicColor(hexLight: Palette.blue, hexDark: Palette.blueDark)
        static var info: Color
    }

    // MARK: - Border

    enum Border {
        @DynamicColor(hexLight: Palette.gray200, hexDark: Palette.darkGray300)
        static var primary: Color
    }
}
```

### Screen'lerde kullanım

```swift
struct ExploreScreen: View {
    @State var presenter: ExplorePresenter

    var body: some View {
        ZStack {
            MyAppDesign.Background.primary.ignoresSafeArea()

            VStack(spacing: 16) {
                Text("Keşfet")
                    .foregroundStyle(MyAppDesign.Foreground.primary)

                Text("Alt başlık")
                    .foregroundStyle(MyAppDesign.Foreground.secondary)

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

- `Palette` enum'u **private** — sadece `{AppName}Design` içinden erişilir, dışarıdan direkt hex kullanılmaz
- Hex değişince sadece `Palette`'te güncellenir, kullanan tüm yerler otomatik değişir
- İç içe enum'lar semantik gruplama sağlar: `Background.primary`, `Semantic.error`, `Accent.secondary`
- Yeni kategori gerekirse aynı pattern ile enum eklenir (ör. `Overlay`, `Divider`, `Badge`)
- Hex değerleri projeye özgüdür, yukarıdakiler sadece örnek
- Design enum'u `{AppName}Design` olarak adlandırılır
