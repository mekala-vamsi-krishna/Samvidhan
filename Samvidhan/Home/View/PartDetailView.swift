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
                        .font(.headline)
                        .foregroundColor(AppColors.primaryNavy)
                    
                    HStack(spacing: 20) {
                        
                        Label("\(part.articleRange)", systemImage: "doc.text")
                        
                        Label("\(part.articles.count) Articles", systemImage: "person.2")
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
                    .font(.title3.weight(.semibold))
                    .foregroundColor(AppColors.primaryNavy)
                
                Spacer()
                
                Text(part.articleRange)
                    .font(.subheadline)
                    .foregroundColor(AppColors.saffron)
            }
            .padding(.horizontal, 4)
            
            // Native List
            List {
                ForEach(part.articles) { article in
                    NavigationLink(destination: ArticleDetailView(article: article)) {
                        ArticleRowView(article: article)
                    }
                    .listRowInsets(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0))
                }
            }
            .listStyle(.plain)
            .scrollDisabled(true) // Important because inside ScrollView
            .frame(height: CGFloat(part.articles.count) * 80) // adjust row height
        }
    }
}

struct ArticleRowView: View {
    let article: Article
    
    var body: some View {
        HStack(spacing: 16) {
            
            // MARK: - Saffron Number Badge
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(AppColors.saffron.opacity(0.15))
                    .frame(width: 54, height: 54)
                
                Text("\(article.articleNumber)")
                    .font(.system(size: 20, weight: .heavy)) // Much thicker
                    .foregroundColor(AppColors.saffron)
            }
            
            // MARK: - Title + Subtitle
            VStack(alignment: .leading, spacing: 4) {
                
                Text("Article \(article.articleNumber)")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(AppColors.primaryNavy)
                
                Text(article.title)
                    .font(.system(size: 14))
                    .foregroundColor(AppColors.secondaryText)
                    .lineLimit(2)
            }
            
            Spacer()
        }
        .padding(.horizontal, 4)
    }
}

#Preview {
    PartDetailView(part: Part(partId: 1, partNumber: "", partTitle: "", articleRange: "", articles: []))
}
