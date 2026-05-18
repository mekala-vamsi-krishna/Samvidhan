//
//  LanguagePickerSheet.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/13/26.
//

import SwiftUI

struct LanguagePickerSheet: View {
    @Binding var selectedLanguage: LanguageOption
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
                    
                    // Sample text showing language
                    VStack(spacing: 12) {
                        Text(sampleTextForLanguage(selectedLanguage))
                            .font(.body)
                            .foregroundColor(AppColors.primaryText)
                            .multilineTextAlignment(.center)
                            .lineSpacing(4)
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
                
                // Language Options
                VStack(spacing: 12) {
                    ForEach(LanguageOption.allCases) { language in
                        LanguageOptionCard(
                            language: language,
                            isSelected: selectedLanguage == language,
                            onSelect: {
                                selectedLanguage = language
                            }
                        )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                
                Spacer()
            }
            .background(AppColors.background)
            .navigationTitle("Language")
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
    
    private func sampleTextForLanguage(_ language: LanguageOption) -> String {
        switch language {
        case .english:
            return "The Constitution of India is the supreme law of India."
        case .hindi:
            return "भारत का संविधान भारत का सर्वोच्च कानून है।"
        case .telugu:
            return "భారత రాజ్యాంగం భారతదేశ సర్వోన్నత చట్టం."
        }
    }
}

// MARK: - Language Option Card
struct LanguageOptionCard: View {
    let language: LanguageOption
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: 12) {
                // Language Icon
                Image(systemName: iconForLanguage(language))
                    .font(.system(size: 22))
                    .foregroundColor(isSelected ? AppColors.saffron : AppColors.iconTint)
                    .frame(width: 36)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(language.displayName)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(isSelected ? AppColors.saffron : AppColors.primaryText)
                    
                    Text(nativeNameForLanguage(language))
                        .font(.caption)
                        .foregroundColor(AppColors.secondaryText)
                }
                
                Spacer()
                
                // Language code
                Text(codeForLanguage(language))
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(AppColors.secondaryText)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(AppColors.cardBorder.opacity(0.3))
                    .cornerRadius(6)
                
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
    
    private func iconForLanguage(_ language: LanguageOption) -> String {
        switch language {
        case .english:
            return "flag"
        case .hindi:
            return "flag"
        case .telugu:
            return "flag"
        }
    }
    
    private func nativeNameForLanguage(_ language: LanguageOption) -> String {
        switch language {
        case .english:
            return "English"
        case .hindi:
            return "हिन्दी"
        case .telugu:
            return "తెలుగు"
        }
    }
    
    private func codeForLanguage(_ language: LanguageOption) -> String {
        switch language {
        case .english:
            return "EN"
        case .hindi:
            return "HI"
        case .telugu:
            return "TE"
        }
    }
}

#Preview {
    LanguagePickerSheet(selectedLanguage: .constant(.english))
        .previewDisplayName("Language Picker")
}
