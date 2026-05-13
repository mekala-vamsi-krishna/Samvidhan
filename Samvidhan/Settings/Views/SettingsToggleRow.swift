//
//  SettingsToggleRow.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/13/26.
//

import SwiftUI

struct SettingsToggleRow: View {
    let icon: String
    let title: String
    let subtitle: String?
    @Binding var isOn: Bool
    
    var body: some View {
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
            
            // Toggle Switch
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: AppColors.primaryNavy))
                .labelsHidden()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
    }
}
