//
//  PreambleCard.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/10/26.
//

import SwiftUI

// MARK: - Preamble Card
struct PreambleCard: View {
    let preamble: Preamble
    
    var body: some View {
        NavigationLink(destination: ArticleDetailView(article: Article(
            articleId: 0,
            articleNumber: 0,
            title: preamble.title,
            description: preamble.description,
            clauses: nil,
            provisos: nil,
            explanations: nil
        ))) {
            HStack(spacing: 0) {
                // Leading Saffron Strip
                Rectangle()
                    .fill(AppColors.saffron)
                    .frame(width: 5)
                    .cornerRadius(12, corners: [.topLeft, .bottomLeft])
                
                // Main Content
                HStack(spacing: 12) {
                    // Circular Icon Container
                    ZStack {
                        Circle()
                            .stroke(AppColors.saffron, lineWidth: 1.5)
                            .fill(AppColors.primaryNavy)
                            .frame(width: 52, height: 52)
                        
                        Text("P")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(AppColors.saffron)
                    }
                    
                    // Content
                    VStack(alignment: .leading, spacing: 4) {
                        Text(preamble.title.uppercased())
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(AppColors.primaryNavy)
                        
                        Text("The Soul of the Constitution")
                            .font(.caption)
                            .foregroundColor(AppColors.secondaryText)
                    }
                    
                    Spacer()
                    
                    // Arrow Indicator
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(AppColors.primaryNavy)
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 12)
            }
            .background(AppColors.cream)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.08), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 1)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    PreambleCard(preamble: Preamble(title: "", description: "", keywords: []))
}
