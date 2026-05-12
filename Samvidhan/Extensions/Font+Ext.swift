//
//  Font+Ext.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/13/26.
//

import SwiftUI

extension Font {
    // Times New Roman with different weights
    static func timesNewRoman(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        switch weight {
        case .bold:
            return .custom("TimesNewRomanPS-BoldMT", size: size)
        case .semibold:
            return .custom("TimesNewRomanPS-BoldMT", size: size) // Using bold for semibold
        case .medium:
            return .custom("TimesNewRomanPSMT", size: size)
        case .regular:
            return .custom("TimesNewRomanPSMT", size: size)
        case .light:
            return .custom("TimesNewRomanPSMT", size: size) // Light not available
        default:
            return .custom("TimesNewRomanPSMT", size: size)
        }
    }
    
    // Predefined heading styles
    static var headingLarge: Font {
        .timesNewRoman(size: 34, weight: .bold)
    }
    
    static var headingMedium: Font {
        .timesNewRoman(size: 28, weight: .bold)
    }
    
    static var headingSmall: Font {
        .timesNewRoman(size: 22, weight: .semibold)
    }
    
    static var titleLarge: Font {
        .timesNewRoman(size: 20, weight: .semibold)
    }
    
    static var titleMedium: Font {
        .timesNewRoman(size: 18, weight: .medium)
    }
}

// MARK: - UIFont Extension for UIKit components
extension UIFont {
    static func timesNewRoman(size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        switch weight {
        case .bold:
            return UIFont(name: "TimesNewRomanPS-BoldMT", size: size) ?? .systemFont(ofSize: size, weight: .bold)
        case .semibold:
            return UIFont(name: "TimesNewRomanPS-BoldMT", size: size) ?? .systemFont(ofSize: size, weight: .semibold)
        default:
            return UIFont(name: "TimesNewRomanPSMT", size: size) ?? .systemFont(ofSize: size)
        }
    }
}
