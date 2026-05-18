//
//  FontPickerSheet.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/13/26.
//

import SwiftUI

struct FontPickerSheet: View {
    @Binding var selectedFont: FontStyleOption
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var themeManager = ThemeManager.shared
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Preview Section
                VStack(spacing: 12) {
                    Text("Preview")
                        .font(.headline)
                        .foregroundColor(AppColors.secondaryText)
                        .padding(.top, 8)
                    
                    // Sample text showing the selected font
                    VStack(spacing: 8) {
                        Text("The Constitution of India")
                            .font(selectedFont == .timesNewRoman ? .timesNewRoman(size: 20, weight: .bold) : .system(size: 20, weight: .bold))
                            .foregroundColor(AppColors.saffron)
                            .multilineTextAlignment(.center)
                        
                        Text("We, the people of India, having solemnly resolved to constitute India into a sovereign, socialist, secular, democratic republic...")
                            .font(selectedFont == .timesNewRoman ? .timesNewRoman(size: 14) : .system(size: 14))
                            .foregroundColor(AppColors.primaryText)
                            .lineSpacing(4)
                            .multilineTextAlignment(.center)
                    }
                    .padding(20)
                    .background(AppColors.cardBackground)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(AppColors.cardBorder, lineWidth: 1)
                    )
                }
                .padding(.horizontal, 16)
                .padding(.top, 20)
                .padding(.bottom, 16)
                
                // Font Options
                VStack(spacing: 12) {
                    ForEach(FontStyleOption.allCases) { font in
                        FontOptionCard(
                            font: font,
                            isSelected: selectedFont == font,
                            onSelect: {
                                selectedFont = font
                            }
                        )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                
                Spacer()
            }
            .background(AppColors.background)
            .navigationTitle("Font Style")
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

// MARK: - Font Option Card
struct FontOptionCard: View {
    let font: FontStyleOption
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: 12) {
                // Icon
                Image(systemName: iconForFont(font))
                    .font(.system(size: 22))
                    .foregroundColor(isSelected ? AppColors.saffron : AppColors.iconTint)
                    .frame(width: 36)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(font.displayName)
                        .font(font == .timesNewRoman ? .timesNewRoman(size: 16, weight: .semibold) : .system(size: 16, weight: .semibold))
                        .foregroundColor(isSelected ? AppColors.saffron : AppColors.primaryText)
                    
                    Text(descriptionForFont(font))
                        .font(.caption)
                        .foregroundColor(AppColors.secondaryText)
                }
                
                Spacer()
                
                // Sample text showing the font style
                Text("Sample")
                    .font(font == .timesNewRoman ? .timesNewRoman(size: 14) : .system(size: 14))
                    .foregroundColor(AppColors.secondaryText)
                    .padding(.horizontal, 8)
                
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
    
    private func iconForFont(_ font: FontStyleOption) -> String {
        switch font {
        case .system:
            return "textformat"
        case .timesNewRoman:
            return "textformat.alt"
        }
    }
    
    private func descriptionForFont(_ font: FontStyleOption) -> String {
        switch font {
        case .system:
            return "Clean and modern San Francisco font"
        case .timesNewRoman:
            return "Classic and elegant serif font"
        }
    }
}

// MARK: - Preview
#Preview {
    FontPickerSheet(selectedFont: .constant(.system))
        .previewDisplayName("Font Picker")
}
