//
//  __AppName__Design.swift
//  Created by __Username__ on __Date__
//

import DynamicColor
import SwiftUI
import UIKit

// Uygulama genelinde kullanılan renk tanımları
enum __AppName__Design {

    // MARK: - System — iOS sistem renkleri, değiştirilmemeli

    enum System {
        @DynamicColor(systemColor: UIColor.systemBackground)
        static var systemBackground: Color

        @DynamicColor(systemColor: UIColor.secondarySystemBackground)
        static var secondarySystemBackground: Color

        @DynamicColor(systemColor: UIColor.tertiarySystemBackground)
        static var tertiarySystemBackground: Color

        @DynamicColor(systemColor: UIColor.systemGroupedBackground)
        static var systemGroupedBackground: Color

        @DynamicColor(systemColor: UIColor.secondarySystemGroupedBackground)
        static var secondarySystemGroupedBackground: Color

        @DynamicColor(systemColor: UIColor.tertiarySystemGroupedBackground)
        static var tertiarySystemGroupedBackground: Color

        @DynamicColor(systemColor: UIColor.label)
        static var label: Color

        @DynamicColor(systemColor: UIColor.secondaryLabel)
        static var secondaryLabel: Color

        @DynamicColor(systemColor: UIColor.tertiaryLabel)
        static var tertiaryLabel: Color

        @DynamicColor(systemColor: UIColor.quaternaryLabel)
        static var quaternaryLabel: Color

        @DynamicColor(systemColor: UIColor.placeholderText)
        static var placeholderText: Color

        @DynamicColor(systemColor: UIColor.separator)
        static var separator: Color

        @DynamicColor(systemColor: UIColor.opaqueSeparator)
        static var opaqueSeparator: Color

        @DynamicColor(systemColor: UIColor.systemFill)
        static var systemFill: Color

        @DynamicColor(systemColor: UIColor.secondarySystemFill)
        static var secondarySystemFill: Color

        @DynamicColor(systemColor: UIColor.tertiarySystemFill)
        static var tertiarySystemFill: Color

        @DynamicColor(systemColor: UIColor.quaternarySystemFill)
        static var quaternarySystemFill: Color

        @DynamicColor(systemColor: UIColor.link)
        static var link: Color

        @DynamicColor(systemColor: UIColor.systemBlue)
        static var systemBlue: Color

        @DynamicColor(systemColor: UIColor.systemGreen)
        static var systemGreen: Color

        @DynamicColor(systemColor: UIColor.systemRed)
        static var systemRed: Color

        @DynamicColor(systemColor: UIColor.systemOrange)
        static var systemOrange: Color

        @DynamicColor(systemColor: UIColor.systemYellow)
        static var systemYellow: Color

        @DynamicColor(systemColor: UIColor.systemPurple)
        static var systemPurple: Color

        @DynamicColor(systemColor: UIColor.systemPink)
        static var systemPink: Color

        @DynamicColor(systemColor: UIColor.systemTeal)
        static var systemTeal: Color

        @DynamicColor(systemColor: UIColor.systemIndigo)
        static var systemIndigo: Color

        @DynamicColor(systemColor: UIColor.systemMint)
        static var systemMint: Color

        @DynamicColor(systemColor: UIColor.systemCyan)
        static var systemCyan: Color

        @DynamicColor(systemColor: UIColor.systemBrown)
        static var systemBrown: Color

        @DynamicColor(systemColor: UIColor.systemGray)
        static var systemGray: Color

        @DynamicColor(systemColor: UIColor.systemGray2)
        static var systemGray2: Color

        @DynamicColor(systemColor: UIColor.systemGray3)
        static var systemGray3: Color

        @DynamicColor(systemColor: UIColor.systemGray4)
        static var systemGray4: Color

        @DynamicColor(systemColor: UIColor.systemGray5)
        static var systemGray5: Color

        @DynamicColor(systemColor: UIColor.systemGray6)
        static var systemGray6: Color
    }

    // ╔══════════════════════════════════════════════════════════════╗
    // ║  CUSTOM — Uygulamaya özel renkler, serbestçe düzenlenebilir ║
    // ╚══════════════════════════════════════════════════════════════╝

    // MARK: - Custom Palette

    private enum CustomPalette {
        static let blue       = "#007AFF"
        static let blueDark   = "#0A84FF"
        static let purple     = "#5856D6"
        static let purpleDark = "#5E5CE6"
        static let splashStart = "#1A1A4D"
        static let splashMid   = "#331A80"
        static let splashEnd   = "#662699"
    }

    // MARK: - Accent

    enum Accent {
        @DynamicColor(hexLight: CustomPalette.blue, hexDark: CustomPalette.blueDark)
        static var primary: Color

        @DynamicColor(hexLight: CustomPalette.purple, hexDark: CustomPalette.purpleDark)
        static var secondary: Color
    }

    // MARK: - Splash

    enum Splash {
        @DynamicColor(hex: CustomPalette.splashStart)
        static var gradientStart: Color

        @DynamicColor(hex: CustomPalette.splashMid)
        static var gradientMid: Color

        @DynamicColor(hex: CustomPalette.splashEnd)
        static var gradientEnd: Color
    }
}
