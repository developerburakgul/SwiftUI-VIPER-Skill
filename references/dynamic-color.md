# DynamicColor Usage

> BurakKit paketinin `DynamicColor` modülü — `import DynamicColor`

## ThemeStore

`@MainActor public final class ThemeStore: ObservableObject, Sendable` — Tema yönetimi singleton'ı. UserDefaults'a otomatik persist eder.

```swift
// Olası değerler
ThemeStore.shared.theme = .system  // Cihaz ayarını takip eder
ThemeStore.shared.theme = .light
ThemeStore.shared.theme = .dark
```

### Ayarlar ekranı örneği

```swift
struct SettingsScreen: View {
    @ObservedObject private var themeStore = ThemeStore.shared

    var body: some View {
        Picker("Tema", selection: $themeStore.theme) {
            Text("Sistem").tag(AppTheme.system)
            Text("Açık").tag(AppTheme.light)
            Text("Koyu").tag(AppTheme.dark)
        }
        .pickerStyle(.segmented)
    }
}
```

## @DynamicColor Property Wrapper

Tema değişikliklerine otomatik tepki veren renk tanımları. 6 farklı init varyantı:

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
