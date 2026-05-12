//
//  Color+Ext.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/9/26.
//

import Foundation
import SwiftUI

enum AppColors {
    static let background = Color(hex: "0F172A")
    static let card = Color(hex: "#1E293B")
    static let cardBorder = Color(hex: "#E8E6DF")
    static let primaryText = Color(hex: "#000000")
    static let secondaryText = Color(hex: "#94A3B8")
    
    // Colors based on the HEX values
    static let primaryNavy = Color(hex: "#0B1F3A")
    static let saffron = Color(hex: "#E49420")
    static let cream = Color(hex: "#FDF9EF")
    static let pureWhite = Color(hex: "#FFFFFF")
}

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
