//
//  SettingsRowView.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/13/26.
//

import SwiftUI

struct SettingsRow: View {
    let icon: String
    let title: String
    let subtitle: String?
    let value: String?
    let action: () -> Void
    
    init(icon: String, title: String, subtitle: String? = nil, value: String? = nil, action: @escaping () -> Void) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.value = value
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                // Icon Circle
                ZStack {
                    Circle()
                        .fill(AppColors.primaryNavy.opacity(0.12))
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: icon)
                        .font(.system(size: 18))
                        .foregroundColor(AppColors.primaryNavy)
                }
                
                // Text Content
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(AppColors.primaryNavy)
                    
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.caption)
                            .foregroundColor(AppColors.secondaryText)
                    }
                }
                
                Spacer()
                
                // Value and Chevron
                if let value = value {
                    Text(value)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(AppColors.primaryNavy.opacity(0.8))
                        .padding(.horizontal, 8)
                }
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(AppColors.secondaryText.opacity(0.5))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.white)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
