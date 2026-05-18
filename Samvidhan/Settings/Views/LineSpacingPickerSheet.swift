//
//  LineSpacingPickerSheet.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/13/26.
//

import SwiftUI

struct LineSpacingPickerSheet: View {
    @Binding var selectedSpacing: LineSpacingOption
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
                    
                    VStack(spacing: selectedSpacing.spacing) {
                        Text("Line spacing affects readability")
                            .font(.body)
                            .foregroundColor(AppColors.saffron)
                        
                        Text("The Constitution of India is the supreme law of India. It lays down the framework defining fundamental political principles, establishes the structure, procedures, powers and duties of government institutions.")
                            .font(.body)
                            .foregroundColor(AppColors.primaryText)
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
                
                // Spacing Options
                VStack(spacing: 12) {
                    ForEach(LineSpacingOption.allCases) { spacing in
                        LineSpacingOptionCard(
                            spacing: spacing,
                            isSelected: selectedSpacing == spacing,
                            onSelect: {
                                selectedSpacing = spacing
                            }
                        )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                
                Spacer()
            }
            .background(AppColors.background)
            .navigationTitle("Line Spacing")
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

// MARK: - Line Spacing Option Card
struct LineSpacingOptionCard: View {
    let spacing: LineSpacingOption
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: 12) {
                // Icon
                Image(systemName: iconForSpacing(spacing))
                    .font(.system(size: 22))
                    .foregroundColor(isSelected ? AppColors.saffron : AppColors.iconTint)
                    .frame(width: 36)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(spacing.displayName)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(isSelected ? AppColors.saffron : AppColors.primaryText)
                    
                    Text(descriptionForSpacing(spacing))
                        .font(.caption)
                        .foregroundColor(AppColors.secondaryText)
                }
                
                Spacer()
                
                // Visual indicator of line spacing
                VStack(spacing: 2) {
                    Rectangle()
                        .fill(isSelected ? AppColors.saffron : AppColors.secondaryText)
                        .frame(width: 30, height: 2)
                    Rectangle()
                        .fill(isSelected ? AppColors.saffron : AppColors.secondaryText)
                        .frame(width: 30, height: 2)
                        .opacity(0.7)
                    Rectangle()
                        .fill(isSelected ? AppColors.saffron : AppColors.secondaryText)
                        .frame(width: 30, height: 2)
                        .opacity(0.4)
                }
                .frame(width: 40)
                .padding(.horizontal, 4)
                
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
    
    private func iconForSpacing(_ spacing: LineSpacingOption) -> String {
        switch spacing {
        case .compact:
            return "line.horizontal.3"
        case .normal:
            return "line.horizontal.3.decrease"
        case .relaxed:
            return "arrow.up.and.down.text.horizontal"
        case .double:
            return "arrow.up.and.down.and.arrow.left.and.right"
        }
    }
    
    private func descriptionForSpacing(_ spacing: LineSpacingOption) -> String {
        switch spacing {
        case .compact:
            return "Tighter lines, more content per page"
        case .normal:
            return "Standard spacing for comfortable reading"
        case .relaxed:
            return "More breathing room between lines"
        case .double:
            return "Maximum spacing for easy reading"
        }
    }
}


#Preview {
    LineSpacingPickerSheet(selectedSpacing: .constant(.normal))
        .previewDisplayName("Line Spacing Picker")
}
