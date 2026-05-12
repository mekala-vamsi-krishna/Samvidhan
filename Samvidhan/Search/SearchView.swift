//
//  SearchView.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/10/26.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    VStack(spacing: 20) {
                        ProgressView()
                            .scaleEffect(1.5)
                            .tint(AppColors.saffron)
                        Text("Searching Constitution...")
                            .foregroundColor(AppColors.secondaryText)
                    }
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 40))
                            .foregroundColor(AppColors.saffron)
                        Text(error)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                } else if viewModel.query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 60))
                            .foregroundColor(AppColors.secondaryText.opacity(0.5))
                        Text("Search the Constitution")
                            .font(.headline)
                            .foregroundColor(AppColors.primaryNavy)
                        Text("Search by article number, part, title, or keywords in clauses.")
                            .font(.subheadline)
                            .foregroundColor(AppColors.secondaryText)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                    }
                } else if viewModel.results.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "doc.text.magnifyingglass")
                            .font(.system(size: 60))
                            .foregroundColor(AppColors.secondaryText.opacity(0.5))
                        Text("No Results Found")
                            .font(.headline)
                            .foregroundColor(AppColors.primaryNavy)
                        Text("Try a different keyword or article number.")
                            .font(.subheadline)
                            .foregroundColor(AppColors.secondaryText)
                    }
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.results) { result in
                                switch result {
                                case .part(let part):
                                    PartCard(part: part)
                                case .article(let article):
                                    ArticleSearchCard(article: article)
                                }
                            }
                        }
                        .padding(16)
                    }
                }
            }
            .navigationTitle("Search")
            .searchable(text: $viewModel.query, prompt: "Search articles, parts, clauses...")
        }
    }
}

struct ArticleSearchCard: View {
    let article: Article
    
    var body: some View {
        NavigationLink(destination: ArticleDetailView(article: article)) {
            HStack(spacing: 0) {
                // Leading Saffron Strip
                Rectangle()
                    .fill(AppColors.saffron)
                    .frame(width: 5)
                    .cornerRadius(12, corners: [.topLeft, .bottomLeft])
                
                // Main Content
                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .top) {
                        Text("Article \(article.articleNumber)")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(AppColors.saffron)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(AppColors.secondaryText)
                    }
                    
                    Text(article.title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(AppColors.primaryNavy)
                        .lineLimit(2)
                    
                    if !article.description.isEmpty {
                        Text(article.description)
                            .font(.system(size: 14))
                            .foregroundColor(AppColors.secondaryText)
                            .lineLimit(3)
                            .multilineTextAlignment(.leading)
                    }
                }
                .padding(16)
            }
            .background(AppColors.pureWhite)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.08), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    SearchView()
}
