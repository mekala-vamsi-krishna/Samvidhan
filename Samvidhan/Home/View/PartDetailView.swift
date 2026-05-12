//
//  PartDetailView.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/10/26.
//

import SwiftUI

struct PartDetailView: View {
    let part: Part
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // MARK: - Top Summary Card
                summaryCard
                
                // MARK: - Articles Section
                articlesSection
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 30)
        }
        .background(AppColors.pureWhite.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension PartDetailView {
    
    var summaryCard: some View {
        HStack(spacing: 0) {
            
            // MARK: - Leading Saffron Strip
            Rectangle()
                .fill(AppColors.saffron)
                .frame(width: 6)
                .cornerRadius(18, corners: [.topLeft, .bottomLeft])
            
            // MARK: - Main Content
            HStack(alignment: .center, spacing: 16) {
                
                // Circular Part Number
                ZStack {
                    Circle()
                        .fill(AppColors.primaryNavy)
                        .frame(width: 64, height: 64)
                    
                    Text(part.partNumber)
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(AppColors.saffron)
                }
                
                // Text Content
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Part \(part.partNumber) – \(part.partTitle)")
                        .font(.timesNewRoman(size: 22, weight: .bold))
                        .foregroundColor(AppColors.primaryNavy)
                    
                    HStack(spacing: 20) {
                        
                        Label("\(part.articleRange)", systemImage: "doc.text")
                        
                        Label("\(part.articles.count) Articles", systemImage: "list.star")
                    }
                    .font(.caption)
                    .foregroundColor(AppColors.secondaryText)
                }
                
                Spacer()
            }
            .padding(20)
        }
        .background(AppColors.cream)
        .cornerRadius(18)
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.gray.opacity(0.08), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 2)
    }
}

private extension PartDetailView {
    
    var articlesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            // Section Header
            HStack {
                Text("Articles")
                    .font(.timesNewRoman(size: 22, weight: .bold))
                    .foregroundColor(AppColors.primaryNavy)
                
                Spacer()
                
                Text(part.articleRange)
                    .font(.subheadline)
                    .foregroundColor(AppColors.saffron)
            }
            .padding(.horizontal, 4)
            
            // Native List with Navigation
            LazyVStack(spacing: 8) {
                ForEach(Array(part.articles.enumerated()), id: \.element.id) { index, article in
                    NavigationLink(
                        destination: ArticleDetailView(
                            article: article,
                            allArticles: getAllArticles(),
                            onNavigate: { newArticle in
                                // This will be handled by the navigation system
                                // The parent view will update automatically
                            }
                        )
                    ) {
                        ArticleRowView(article: article)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
    
    // Helper function to get all articles from the part
    func getAllArticles() -> [Article] {
        return part.articles
    }
}

// MARK: - Article Row View
struct ArticleRowView: View {
    let article: Article
    
    var body: some View {
        HStack(spacing: 16) {
            
            // MARK: - Saffron Number Badge
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(AppColors.saffron.opacity(0.15))
                    .frame(width: 54, height: 54)
                
                Text(article.articleNumber)
                    .font(.timesNewRoman(size: 22, weight: .heavy))
                    .foregroundColor(AppColors.saffron)
            }
            
            // MARK: - Title + Subtitle
            VStack(alignment: .leading, spacing: 4) {
                
                Text("Article \(article.articleNumber)")
                    .font(.timesNewRoman(size: 16, weight: .semibold))
                    .foregroundColor(AppColors.primaryNavy)
                
                Text(article.title)
                    .font(.system(size: 14))
                    .foregroundColor(AppColors.secondaryText)
                    .lineLimit(2)
            }
            
            Spacer()
            
            // Chevron indicator
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Color.gray.opacity(0.5))
        }
        .navigationTitle("Articles")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.04), radius: 3, x: 0, y: 1)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                )
        )
    }
}

// MARK: - Preview
#Preview {
    let sampleArticles = [
        Article(
            articleId: 1,
            articleNumber: "1",
            title: "Name and territory of the Union",
            description: "India, that is Bharat, shall be a Union of States.",
            clauses: nil,
            provisos: nil,
            explanations: nil
        ),
        Article(
            articleId: 2,
            articleNumber: "2",
            title: "Admission or establishment of new States",
            description: "Parliament may by law admit into the Union, or establish, new States.",
            clauses: nil,
            provisos: nil,
            explanations: nil
        ),
        Article(
            articleId: 3,
            articleNumber: "3",
            title: "Formation of new States",
            description: "Parliament may by law form a new State by separation of territory.",
            clauses: nil,
            provisos: nil,
            explanations: nil
        )
    ]
    
    let samplePart = Part(
        partId: 1,
        partNumber: "I",
        partTitle: "The Union and its Territory",
        articleRange: "Articles 1-4",
        articles: sampleArticles
    )
    
    NavigationView {
        PartDetailView(part: samplePart)
    }
}
