//
//  ThemePickerSheet.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/13/26.
//

import SwiftUI

struct ThemePickerSheet: View {
    @Binding var selectedTheme: ThemeOption
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var themeManager = ThemeManager.shared
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Custom styled picker instead of List
                VStack(spacing: 12) {
                    ForEach(ThemeOption.allCases) { theme in
                        ThemeOptionRow(
                            theme: theme,
                            isSelected: selectedTheme == theme,
                            onSelect: {
                                selectedTheme = theme
                                themeManager.updateTheme(theme)
                                dismiss()
                            }
                        )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
                
                Spacer()
            }
            .background(AppColors.background)
            .navigationTitle("Select Theme")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(AppColors.cardBackground, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(themeManager.currentTheme == .dark ? .dark : .light, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(AppColors.saffron)
                }
            }
        }
        .preferredColorScheme(themeManager.currentTheme == .system ? nil : (themeManager.currentTheme == .light ? .light : .dark))
    }
}

// MARK: - Theme Option Row Component
struct ThemeOptionRow: View {
    let theme: ThemeOption
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            HStack {
                // Icon based on theme
                Image(systemName: iconForTheme(theme))
                    .font(.system(size: 22))
                    .foregroundColor(isSelected ? AppColors.saffron : AppColors.iconTint)
                    .frame(width: 36)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(theme.displayName)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(AppColors.primaryText)
                    
                    Text(subtitleForTheme(theme))
                        .font(.caption)
                        .foregroundColor(AppColors.secondaryText)
                }
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(AppColors.saffron)
                        .font(.system(size: 24))
                } else {
                    Circle()
                        .stroke(AppColors.cardBorder, lineWidth: 1.5)
                        .frame(width: 24, height: 24)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(isSelected ? AppColors.saffron.opacity(0.1) : AppColors.cardBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(isSelected ? AppColors.saffron : AppColors.cardBorder, lineWidth: isSelected ? 1.5 : 1)
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
        .shadow(color: Color.black.opacity(0.04), radius: 2, x: 0, y: 1)
    }
    
    private func iconForTheme(_ theme: ThemeOption) -> String {
        switch theme {
        case .light:
            return "sun.max.fill"
        case .dark:
            return "moon.fill"
        case .system:
            return "iphone"
        }
    }
    
    private func subtitleForTheme(_ theme: ThemeOption) -> String {
        switch theme {
        case .light:
            return "Always use light appearance"
        case .dark:
            return "Always use dark appearance"
        case .system:
            return "Follow device settings"
        }
    }
}

// MARK: - Preview
#Preview {
    Group {
        // Light Mode Preview
        ThemePickerSheet(selectedTheme: .constant(.light))
            .previewDisplayName("Light Mode")
            .preferredColorScheme(.light)
        
        // Dark Mode Preview
        ThemePickerSheet(selectedTheme: .constant(.dark))
            .previewDisplayName("Dark Mode")
            .preferredColorScheme(.dark)
    }
}
