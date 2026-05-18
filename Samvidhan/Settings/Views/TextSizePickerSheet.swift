//
//  TextSizePickerSheet.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/13/26.
//

import SwiftUI

struct TextSizePickerSheet: View {
    @Binding var selectedSize: TextSizeOption
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var themeManager = ThemeManager.shared
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                // Preview Text
                VStack(spacing: 12) {
                    Text("Preview")
                        .font(.headline)
                        .foregroundColor(AppColors.secondaryText)
                    
                    Text("The Constitution of India")
                        .font(.system(size: selectedSize.fontSize + 4, weight: .bold))
                        .foregroundColor(AppColors.saffron)
                        .multilineTextAlignment(.center)
                    
                    Text("We, the people of India, having solemnly resolved to constitute India into a sovereign, socialist, secular, democratic republic...")
                        .font(.system(size: selectedSize.fontSize))
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
                .padding(.horizontal, 16)
                .padding(.top, 20)
                
                // Size Options
                VStack(spacing: 8) {
                    ForEach(TextSizeOption.allCases) { size in
                        TextSizeOptionCard(
                            size: size,
                            isSelected: selectedSize == size,
                            onSelect: {
                                selectedSize = size
                            }
                        )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                
                Spacer()
            }
            .background(AppColors.background)
            .navigationTitle("Text Size")
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

// MARK: - Text Size Option Card
struct TextSizeOptionCard: View {
    let size: TextSizeOption
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(size.displayName)
                        .font(.system(size: size.fontSize, weight: .medium))
                        .foregroundColor(isSelected ? AppColors.saffron : AppColors.primaryText)
                    
                    Text(descriptionForSize(size))
                        .font(.caption)
                        .foregroundColor(AppColors.secondaryText)
                }
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(AppColors.saffron)
                        .font(.system(size: 22))
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? AppColors.saffron.opacity(0.1) : AppColors.cardBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isSelected ? AppColors.saffron : AppColors.cardBorder, lineWidth: isSelected ? 1.5 : 1)
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func descriptionForSize(_ size: TextSizeOption) -> String {
        switch size {
        case .small:
            return "Best for reading on small screens"
        case .medium:
            return "Standard size for comfortable reading"
        case .large:
            return "Easier to read, less eye strain"
        case .extraLarge:
            return "Maximum readability"
        }
    }
}

// MARK: - Preview
#Preview {
    TextSizePickerSheet(selectedSize: .constant(.medium))
        .previewDisplayName("Text Size Picker")
}
