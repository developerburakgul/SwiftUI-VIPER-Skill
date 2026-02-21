# DynamicColor Usage

> BurakKit paketinin `DynamicColor` modülü — `import DynamicColor`

## ThemeStore

`ThemeStore.shared.theme` controls app-wide appearance. Set it at launch or from a settings screen.

```swift
// Olası değerler
ThemeStore.shared.theme = .system  // Cihaz ayarını takip eder
ThemeStore.shared.theme = .light
ThemeStore.shared.theme = .dark
```

## @DynamicColor Property Wrapper

Tema değişikliklerine otomatik tepki veren renk tanımları. 6 farklı init varyantı:

```swift
// 1. Tek renk (her iki temada aynı)
@DynamicColor(light: .blue)
var accent: Color

// 2. Light + Dark ayrı
@DynamicColor(light: .white, dark: .black)
var background: Color

// 3. Hex string
@DynamicColor(lightHex: "#FFFFFF", darkHex: "#1C1C1E")
var surface: Color

// 4. Sadece light hex (dark aynı)
@DynamicColor(hex: "#FF5733")
var highlight: Color

// 5. Asset catalog ismi
@DynamicColor(named: "AccentColor")
var accentColor: Color

// 6. Color.init(hex:) — standalone kullanım
let custom = Color(hex: "#34C759")
```

## Design Pattern — `{AppName}Design.swift`

Her projede `Design/{AppName}Design.swift` dosyası renk tanımlarını barındırır:

```swift
import DynamicColor

struct MyAppDesign {
    // Tema renkleri
    @DynamicColor(light: .white, dark: Color(hex: "#1C1C1E"))
    static var background: Color

    @DynamicColor(light: .black, dark: .white)
    static var primaryText: Color

    @DynamicColor(lightHex: "#007AFF", darkHex: "#0A84FF")
    static var accent: Color
}
```
