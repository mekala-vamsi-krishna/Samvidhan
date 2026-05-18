//
//  SettingsViewModel.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/13/26.
//

import SwiftUI
import Combine

class SettingsViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var selectedTheme: ThemeOption = .system
    @Published var textSize: TextSizeOption = .medium
    @Published var fontStyle: FontStyleOption = .system
    @Published var lineSpacing: LineSpacingOption = .normal
    @Published var highlightColor: HighlightColorOption = .saffron
    @Published var isOfflineDownloadEnabled = false
    @Published var currentLanguage: LanguageOption = .english
    
    // Sheet Presentations
    @Published var showThemePicker = false
    @Published var showTextSizePicker = false
    @Published var showFontPicker = false
    @Published var showLineSpacingPicker = false
    @Published var showHighlightColorPicker = false
    @Published var navigateToBookmarks = false
    @Published var navigateToHistory = false
    
    // Cancellables for debouncing
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Sync with ThemeManager on initialization
        selectedTheme = ThemeManager.shared.currentTheme
        
        // Use debounce to avoid publishing changes during view updates
        $selectedTheme
            .dropFirst() // Skip initial value
            .debounce(for: .milliseconds(50), scheduler: DispatchQueue.main)
            .sink { [weak self] newTheme in
                guard let self = self else { return }
                // Update ThemeManager without causing circular updates
                if ThemeManager.shared.currentTheme != newTheme {
                    DispatchQueue.main.async {
                        ThemeManager.shared.currentTheme = newTheme
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Computed Properties
    var cacheSize: String {
        let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        guard let directory = cacheURL else { return "0 MB" }
        
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: [.fileSizeKey])
            let totalSize = try contents.reduce(0) { (sum, url) -> UInt64 in
                let attributes = try FileManager.default.attributesOfItem(atPath: url.path)
                return sum + (attributes[.size] as? UInt64 ?? 0)
            }
            return ByteCountFormatter.string(fromByteCount: Int64(totalSize), countStyle: .binary)
        } catch {
            return "0 MB"
        }
    }
    
    var totalStorageUsed: String {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        guard let directory = documentsURL else { return "0 MB" }
        
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: [.fileSizeKey])
            let totalSize = try contents.reduce(0) { (sum, url) -> UInt64 in
                let attributes = try FileManager.default.attributesOfItem(atPath: url.path)
                return sum + (attributes[.size] as? UInt64 ?? 0)
            }
            return ByteCountFormatter.string(fromByteCount: Int64(totalSize), countStyle: .binary)
        } catch {
            return "0 MB"
        }
    }
    
    // MARK: - Actions
    func rateApp() {
        guard let url = URL(string: "https://apps.apple.com/app/idYOUR_APP_ID") else { return }
        UIApplication.shared.open(url)
    }
    
    func shareApp() {
        let text = "Check out Samvidhan - The Constitution of India app!"
        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(activityVC, animated: true)
        }
    }
    
    func clearCache() {
        let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        guard let directory = cacheURL else { return }
        
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil)
            for url in contents {
                try FileManager.default.removeItem(at: url)
            }
            objectWillChange.send()
        } catch {
            print("Error clearing cache: \(error)")
        }
    }
}

// MARK: - Setting Options

enum ThemeOption: String, CaseIterable, Identifiable {
    case light, dark, system
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .light: return "Light"
        case .dark: return "Dark"
        case .system: return "System"
        }
    }
}

enum TextSizeOption: String, CaseIterable, Identifiable {
    case small, medium, large, extraLarge
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .small: return "Small"
        case .medium: return "Medium"
        case .large: return "Large"
        case .extraLarge: return "Extra Large"
        }
    }
    
    var fontSize: CGFloat {
        switch self {
        case .small: return 14
        case .medium: return 16
        case .large: return 18
        case .extraLarge: return 20
        }
    }
}

enum FontStyleOption: String, CaseIterable, Identifiable {
    case system, timesNewRoman
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .system: return "System Font"
        case .timesNewRoman: return "Times New Roman"
        }
    }
    
    var font: Font {
        switch self {
        case .system: return .body
        case .timesNewRoman: return .timesNewRoman(size: 16)
        }
    }
}

enum LineSpacingOption: String, CaseIterable, Identifiable {
    case compact, normal, relaxed, double
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .compact: return "Compact"
        case .normal: return "Normal"
        case .relaxed: return "Relaxed"
        case .double: return "Double"
        }
    }
    
    var spacing: CGFloat {
        switch self {
        case .compact: return 2
        case .normal: return 4
        case .relaxed: return 8
        case .double: return 12
        }
    }
}

enum HighlightColorOption: String, CaseIterable, Identifiable {
    case saffron, yellow, blue, green
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .saffron: return "Saffron"
        case .yellow: return "Yellow"
        case .blue: return "Blue"
        case .green: return "Green"
        }
    }
    
    var color: Color {
        switch self {
        case .saffron: return AppColors.saffron
        case .yellow: return .yellow
        case .blue: return .blue
        case .green: return .green
        }
    }
}

enum LanguageOption: String, CaseIterable, Identifiable {
    case english, hindi, telugu
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .english: return "English"
        case .hindi: return "हिन्दी (Hindi)"
        case .telugu: return "తెలుగు (Telugu)"
        }
    }
}
