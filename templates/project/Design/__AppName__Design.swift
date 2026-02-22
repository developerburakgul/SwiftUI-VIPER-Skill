//
//  __AppName__Design.swift
//  Created by __Username__ on __Date__
//

import DynamicColor
import SwiftUI

// Uygulama genelinde kullanılan renk tanımları
enum __AppName__Design {

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
        static let splashStart = "#1A1A4D"
        static let splashMid   = "#331A80"
        static let splashEnd   = "#662699"
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

    // MARK: - Splash

    enum Splash {
        @DynamicColor(hex: Palette.splashStart)
        static var gradientStart: Color

        @DynamicColor(hex: Palette.splashMid)
        static var gradientMid: Color

        @DynamicColor(hex: Palette.splashEnd)
        static var gradientEnd: Color
    }
}
