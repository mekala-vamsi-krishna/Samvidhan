//
//  SettingsInfoRow.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/13/26.
//

import SwiftUI

struct SettingsInfoRow: View {
    let icon: String
    let title: String
    let subtitle: String?
    let value: String
    
    var body: some View {
        HStack(spacing: 12) {
            // Icon Circle
            ZStack {
                Circle()
                    .fill(AppColors.iconBackground)
                    .frame(width: 40, height: 40)
                
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(AppColors.iconTint)
            }
            
            // Text Content
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(AppColors.primaryText)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(AppColors.secondaryText)
                }
            }
            
            Spacer()
            
            Text(value)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(AppColors.iconTint)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

struct SettingsDivider: View {
    var body: some View {
        Rectangle()
            .fill(AppColors.cardBorder)
            .frame(height: 1)
            .padding(.leading, 68)
    }
}
