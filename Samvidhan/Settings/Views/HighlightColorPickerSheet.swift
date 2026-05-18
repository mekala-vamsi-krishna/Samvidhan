//
//  HighlightColorPickerSheet.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/13/26.
//

import SwiftUI

struct HighlightColorPickerSheet: View {
    @Binding var selectedColor: HighlightColorOption
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
                    
                    // Sample text showing highlight color
                    VStack(spacing: 12) {
                        Text("Sample highlighted text")
                            .font(.body)
                            .foregroundColor(AppColors.primaryText)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(selectedColor.color.opacity(0.25))
                            .cornerRadius(8)
                        
                        Text("This is how highlighted text will appear")
                            .font(.caption)
                            .foregroundColor(AppColors.secondaryText)
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
                
                // Color Options
                VStack(spacing: 12) {
                    ForEach(HighlightColorOption.allCases) { color in
                        HighlightColorOptionCard(
                            color: color,
                            isSelected: selectedColor == color,
                            onSelect: {
                                selectedColor = color
                            }
                        )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                
                Spacer()
            }
            .background(AppColors.background)
            .navigationTitle("Highlight Color")
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

// MARK: - Highlight Color Option Card
struct HighlightColorOptionCard: View {
    let color: HighlightColorOption
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: 12) {
                // Color Circle with selection indicator
                ZStack {
                    Circle()
                        .fill(color.color)
                        .frame(width: 32, height: 32)
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                                .shadow(color: Color.black.opacity(0.1), radius: 2)
                        )
                    
                    if isSelected {
                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(color.displayName)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(isSelected ? AppColors.saffron : AppColors.primaryText)
                    
                    Text(descriptionForColor(color))
                        .font(.caption)
                        .foregroundColor(AppColors.secondaryText)
                }
                
                Spacer()
                
                // Sample highlight preview
                Text("Sample")
                    .font(.subheadline)
                    .foregroundColor(AppColors.primaryText)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(color.color.opacity(0.25))
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
    
    private func descriptionForColor(_ color: HighlightColorOption) -> String {
        switch color {
        case .saffron:
            return "Traditional and prominent"
        case .yellow:
            return "Bright and eye-catching"
        case .blue:
            return "Calm and professional"
        case .green:
            return "Natural and soothing"
        }
    }
}

#Preview {
    HighlightColorPickerSheet(selectedColor: .constant(.saffron))
        .previewDisplayName("Highlight Color Picker")
}
