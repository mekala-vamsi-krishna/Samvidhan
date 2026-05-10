//
//  ArticleDetailView.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/10/26.
//

import SwiftUI

struct ArticleDetailView: View {
    let article: Article
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    if article.articleNumber > 0 {
                        Text("Article \(article.articleNumber)")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(AppColors.saffron)
                    }
                    
                    Text(article.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(AppColors.primaryNavy)
                    
                    Rectangle()
                        .fill(AppColors.saffron)
                        .frame(width: 60, height: 3)
                        .cornerRadius(1.5)
                }
                .padding(.bottom, 8)
                
                // Content
                Text(article.description)
                    .font(.body)
                    .foregroundColor(AppColors.primaryText)
                    .lineSpacing(6)
            }
            .padding(20)
        }
        .background(AppColors.cream)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ArticleDetailView(article: Article(articleId: 1, articleNumber: 1, title: "", description: "", clauses: [], provisos: [], explanations: []))
}
