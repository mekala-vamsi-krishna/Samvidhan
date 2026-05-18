//
//  PartCard.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/9/26.
//

import SwiftUI

struct PartCard: View {
    let part: Part
    
    var body: some View {
        NavigationLink(destination: PartDetailView(part: part)) {
            HStack(spacing: 0) {
                // Leading Saffron Strip
                Rectangle()
                    .fill(AppColors.saffron)
                    .frame(width: 5)
                    .cornerRadius(12, corners: [.topLeft, .bottomLeft])
                
                // Main Content
                HStack(spacing: 12) {
                    // Circular Icon
                    ZStack {
                        Circle()
                            .fill(AppColors.primaryNavy)
                            .frame(width: 64, height: 64)
                        
                        Text(part.partNumber)
                            .font(.timesNewRoman(size: 16, weight: .bold))
                            .foregroundColor(AppColors.saffron)
                    }
                    
                    // Content
                    VStack(alignment: .leading, spacing: 4) {
                        Text(part.partTitle)
                            .font(.timesNewRoman(size: 16, weight: .bold))
                            .foregroundColor(AppColors.primaryText)
                            .lineLimit(1)
                        
                        Text(part.articleRange)
                            .font(.caption)
                            .foregroundColor(AppColors.secondaryText)
                    }
                    
                    Spacer()
                    
                    // Arrow Indicator
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color.gray.opacity(0.5))
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 12)
            }
            .cornerRadius(12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(AppColors.cardBorder)
                    .shadow(color: Color.black.opacity(0.04), radius: 3, x: 0, y: 1)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    PartCard(part: Part(partId: 1, partNumber: "", partTitle: "", articleRange: "", articles: []))
}
