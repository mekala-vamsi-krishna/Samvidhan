//
//  Color+Ext.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/9/26.
//

import Foundation
import SwiftUI
import Combine

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        
        switch hex.count {
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - App Colors
enum AppColors {
    // Static colors (don't change with theme)
    static let saffron = Color(hex: "#E49420")
    static let primaryNavy = Color(hex: "#0B1F3A")
    static let cream = Color(hex: "#FDF9EF")
    static let pureWhite = Color(hex: "#FFFFFF")
    
    // Dynamic colors (change with theme)
    static var background: Color {
        let theme = ThemeManager.shared.currentTheme
        switch theme {
        case .light:
            return Color(hex: "#FFFFFF")
        case .dark:
            return Color(hex: "#0F172A")
        case .system:
            return Color(UIColor.systemBackground)
        }
    }
    
    static var isDarkMode: Bool {
        let theme = ThemeManager.shared.currentTheme
        switch theme {
        case .light:
            return false
        case .dark:
            return true
        case .system:
            return UITraitCollection.current.userInterfaceStyle == .dark
        }
    }
    
    // Icon background color that adapts to theme
    static var iconBackground: Color {
        let theme = ThemeManager.shared.currentTheme
        switch theme {
        case .light:
            return primaryNavy.opacity(0.08)
        case .dark:
            return saffron.opacity(0.12)
        case .system:
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return saffron.opacity(0.12)
            } else {
                return primaryNavy.opacity(0.08)
            }
        }
    }
    
    static var cardBackground: Color {
        let theme = ThemeManager.shared.currentTheme
        switch theme {
        case .light:
            return Color(hex: "#FFFFFF")
        case .dark:
            return Color(hex: "#1E293B")
        case .system:
            return Color(UIColor.secondarySystemBackground)
        }
    }
    
    static var cardBorder: Color {
        let theme = ThemeManager.shared.currentTheme
        switch theme {
        case .light:
            return Color(hex: "#E8E6DF").opacity(0.5)
        case .dark:
            return Color(hex: "#334155").opacity(0.5)
        case .system:
            return Color(UIColor.separator)
        }
    }
    
    static var primaryText: Color {
        let theme = ThemeManager.shared.currentTheme
        switch theme {
        case .light:
            return Color(hex: "#000000")
        case .dark:
            return Color(hex: "#F1F5F9")
        case .system:
            return Color(UIColor.label)
        }
    }
    
    static var secondaryText: Color {
        let theme = ThemeManager.shared.currentTheme
        switch theme {
        case .light:
            return Color(hex: "#64748B")
        case .dark:
            return Color(hex: "#94A3B8")
        case .system:
            return Color(UIColor.secondaryLabel)
        }
    }
    
    static var iconTint: Color {
        let theme = ThemeManager.shared.currentTheme
        switch theme {
        case .light:
            return Color(hex: "#E49420")
        case .dark:
            return Color(hex: "#F59E0B")
        case .system:
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return Color(hex: "#F59E0B")
            } else {
                return Color(hex: "#E49420")
            }
        }
    }
}

// MARK: - Theme Manager
class ThemeManager: ObservableObject {
    static let shared = ThemeManager()
    
    @Published var currentTheme: ThemeOption = .system {
        didSet {
            saveTheme()
            applyTheme()
        }
    }
    
    private let userDefaultsKey = "selectedTheme"
    private var isApplying = false
    
    private init() {
        loadTheme()
        applyTheme()
    }
    
    private func loadTheme() {
        let savedValue = UserDefaults.standard.string(forKey: userDefaultsKey) ?? ThemeOption.system.rawValue
        currentTheme = ThemeOption(rawValue: savedValue) ?? .system
    }
    
    private func saveTheme() {
        UserDefaults.standard.set(currentTheme.rawValue, forKey: userDefaultsKey)
    }
    
    private func applyTheme() {
        // Prevent recursive calls
        guard !isApplying else { return }
        isApplying = true
        
        DispatchQueue.main.async {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else {
                self.isApplying = false
                return
            }
            
            switch self.currentTheme {
            case .light:
                window.overrideUserInterfaceStyle = .light
            case .dark:
                window.overrideUserInterfaceStyle = .dark
            case .system:
                window.overrideUserInterfaceStyle = .unspecified
            }
            
            self.isApplying = false
        }
    }
    
    // Method to update theme from SettingsView
    func updateTheme(_ newTheme: ThemeOption) {
        DispatchQueue.main.async {
            self.currentTheme = newTheme
        }
    }
}

// MARK: - Theme-Aware View Modifier
struct ThemeAwareViewModifier: ViewModifier {
    @ObservedObject private var themeManager = ThemeManager.shared
    
    func body(content: Content) -> some View {
        content
            .background(AppColors.background)
            .preferredColorScheme(themeManager.currentTheme == .system ? nil : (themeManager.currentTheme == .light ? .light : .dark))
    }
}

extension View {
    func themeAware() -> some View {
        modifier(ThemeAwareViewModifier())
    }
}

// MARK: - Theme-Aware Card Component
struct ThemeCard<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding()
            .background(AppColors.cardBackground)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(AppColors.cardBorder, lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

// MARK: - UIColor Extension for Hex
extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: .alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        
        switch hex.count {
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            red: CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue: CGFloat(b) / 255,
            alpha: CGFloat(a) / 255
        )
    }
}
