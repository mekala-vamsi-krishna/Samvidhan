//
//  ArticleDetailView.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/10/26.
//

import SwiftUI

// MARK: - Main Article Detail View
struct ArticleDetailView: View {
    let article: Article
    let allArticles: [Article]
    let onNavigate: ((Article) -> Void)?
    
    @State private var expandedClauses: Set<String> = []
    @State private var showingShareSheet = false
    @State private var selectedClauseForDetail: Clause?
    @State private var selectedProvisoForDetail: Proviso?
    @State private var selectedProvisoIndex: Int = 0
    @State private var selectedExplanationForDetail: Explanation?
    @State private var transitionDirection: TransitionDirection = .forward
    @State private var currentArticle: Article
    
    enum TransitionDirection {
        case forward
        case backward
    }
    
    init(article: Article, allArticles: [Article] = [], onNavigate: ((Article) -> Void)? = nil) {
        self.article = article
        self.allArticles = allArticles
        self.onNavigate = onNavigate
        _currentArticle = State(initialValue: article)
    }
    
    private var currentIndex: Int? {
        allArticles.firstIndex { $0.articleId == currentArticle.articleId }
    }
    
    private var previousArticle: Article? {
        guard let index = currentIndex, index > 0 else { return nil }
        return allArticles[index - 1]
    }
    
    private var nextArticle: Article? {
        guard let index = currentIndex, index < allArticles.count - 1 else { return nil }
        return allArticles[index + 1]
    }
    
    var body: some View {
        ZStack {
            // Main Content with Transition Animation
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Header Section
                    headerView
                    
                    // Article Text Box
                    articleTitleBoxView
                    
                    // Clauses Section
                    if let clauses = currentArticle.clauses, !clauses.isEmpty {
                        clausesSection(clauses: clauses)
                    }
                    
                    // Provisos Section
                    if let provisos = currentArticle.provisos, !provisos.isEmpty {
                        provisosSection(provisos: provisos)
                    }
                    
                    // Explanations Section
                    if let explanations = currentArticle.explanations, !explanations.isEmpty {
                        explanationsSection(explanations: explanations)
                    }
                    
                    // Navigation Buttons
                    if !allArticles.isEmpty {
                        navigationButtons
                    }
                }
                .padding(20)
            }
            .background(AppColors.pureWhite)
            .id(currentArticle.articleId) // Force view refresh on article change
            .transition(
                .asymmetric(
                    insertion: .move(edge: transitionDirection == .forward ? .trailing : .leading)
                        .combined(with: .opacity),
                    removal: .move(edge: transitionDirection == .forward ? .leading : .trailing)
                        .combined(with: .opacity)
                )
            )
            .animation(.easeInOut(duration: 0.3), value: currentArticle.articleId)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingShareSheet = true
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(AppColors.saffron)
                }
            }
        }
        .sheet(isPresented: $showingShareSheet) {
            ShareSheet(activityItems: [shareContent])
        }
        .sheet(item: $selectedClauseForDetail) { clause in
            ClauseDetailSheet(clause: clause)
        }
        .sheet(item: $selectedClauseForDetail) { clause in
            ClauseDetailSheet(clause: clause)
        }
        .sheet(item: $selectedProvisoForDetail) { proviso in
            ProvisoDetailSheet(proviso: proviso, index: selectedProvisoIndex)
        }

        .sheet(item: $selectedExplanationForDetail) { explanation in
            ExplanationDetailSheet(explanation: explanation)
        }
        .onChange(of: article.articleId) { newId in
            // Update current article when the parent updates the article
            if currentArticle.articleId != newId {
                withAnimation(.easeInOut(duration: 0.3)) {
                    currentArticle = allArticles.first(where: { $0.articleId == newId }) ?? article
                }
            }
        }
    }
    
    // MARK: - Header View
    private var headerView: some View {
        VStack(alignment: .leading, spacing: 8) {
            if !currentArticle.articleNumber.isEmpty {
                Text("Article \(currentArticle.articleNumber)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(AppColors.primaryNavy)
            }
            
            Rectangle()
                .fill(AppColors.saffron)
                .frame(width: 60, height: 3)
                .cornerRadius(1.5)
        }
        .padding(.bottom, 8)
    }

    // MARK: - Article Title Box View
    private var articleTitleBoxView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Article Text")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(AppColors.primaryNavy)
            
            HStack(alignment: .top, spacing: 12) {
                Rectangle()
                    .fill(AppColors.saffron)
                    .frame(width: 2)
                    .cornerRadius(2)
                
                Text(currentArticle.title)
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundColor(AppColors.primaryText)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.06), radius: 4, x: 0, y: 1)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                    )
            )
        }
    }
    
    // MARK: - Clauses Section
    @ViewBuilder
    private func clausesSection(clauses: [Clause]) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Clauses")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(AppColors.primaryNavy)
            
            VStack(spacing: 12) {
                ForEach(clauses) { clause in
                    ClauseCard(
                        clause: clause,
                        isExpanded: expandedClauses.contains(clause.id.uuidString),
                        onToggle: {
                            toggleClause(clause.id.uuidString)
                        },
                        onSeeMore: {
                            selectedClauseForDetail = clause
                        }
                    )
                }
            }
        }
    }
    
    // MARK: - Provisos Section
    private func provisosSection(provisos: [Proviso]) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Provisos")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(AppColors.primaryNavy)
            
            VStack(spacing: 12) {
                ForEach(Array(provisos.enumerated()), id: \.offset) { index, proviso in
                    ProvisoCard(
                        proviso: proviso,
                        index: index,
                        onSeeMore: {
                            selectedProvisoForDetail = proviso
                            selectedProvisoIndex = index
                        }
                    )
                }
            }
        }
    }
    
    // MARK: - Explanations Section
    private func explanationsSection(explanations: [Explanation]) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Explanations")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(AppColors.primaryNavy)
            
            VStack(spacing: 12) {
                ForEach(explanations) { explanation in
                    ExplanationCard(
                        explanation: explanation,
                        onSeeMore: {
                            selectedExplanationForDetail = explanation
                        }
                    )
                }
            }
        }
    }
    
    // MARK: - Navigation Buttons
    private var navigationButtons: some View {
        VStack(spacing: 16) {
            Divider()
                .padding(.vertical, 8)
            
            HStack(spacing: 20) {
                // Previous Button
                Button(action: {
                    navigateToPrevious()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Previous")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(previousArticle != nil ? AppColors.saffron : Color.gray.opacity(0.3))
                    .foregroundColor(previousArticle != nil ? .white : .gray)
                    .cornerRadius(10)
                }
                .disabled(previousArticle == nil)
                
                // Next Button
                Button(action: {
                    navigateToNext()
                }) {
                    HStack {
                        Text("Next")
                        Image(systemName: "chevron.right")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(nextArticle != nil ? AppColors.saffron : Color.gray.opacity(0.3))
                    .foregroundColor(nextArticle != nil ? .white : .gray)
                    .cornerRadius(10)
                }
                .disabled(nextArticle == nil)
            }
            
            // Article counter
            if let index = currentIndex {
                Text("Article \(index + 1) of \(allArticles.count)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
    
    // MARK: - Navigation Methods
    private func navigateToPrevious() {
        guard let previous = previousArticle else { return }
        
        withAnimation(.easeInOut(duration: 0.3)) {
            transitionDirection = .backward
            currentArticle = previous
            expandedClauses.removeAll() // Reset expanded clauses
            onNavigate?(previous)
        }
    }
    
    private func navigateToNext() {
        guard let next = nextArticle else { return }
        
        withAnimation(.easeInOut(duration: 0.3)) {
            transitionDirection = .forward
            currentArticle = next
            expandedClauses.removeAll() // Reset expanded clauses
            onNavigate?(next)
        }
    }
    
    // MARK: - Helper Functions
    private func toggleClause(_ clauseId: String) {
        if expandedClauses.contains(clauseId) {
            expandedClauses.remove(clauseId)
        } else {
            expandedClauses.insert(clauseId)
        }
    }
    
    private var shareContent: String {
        var content = "Article \(currentArticle.articleNumber): \(currentArticle.title)\n\n"
        content += currentArticle.description
        if let clauses = currentArticle.clauses {
            content += "\n\nClauses:\n"
            for clause in clauses {
                content += "\(clause.clauseNumber). \(clause.text)\n"
                if let subClauses = clause.subClauses {
                    for subClause in subClauses {
                        content += "   \(subClause.subClause)) \(subClause.text)\n"
                    }
                }
            }
        }
        return content
    }
}
// MARK: - Preview
#Preview {
    let sampleSubClauses = [
        SubClause(subClause: "a", text: "No citizen shall, on grounds only of religion, race, caste, sex, place of birth or any of them, be ineligible for, or discriminated against in respect of, any employment or office under the State."),
        SubClause(subClause: "b", text: "No citizen shall, on grounds only of religion, race, caste, sex, place of birth or any of them, be subjected to any disability, liability, restriction or condition with regard to any employment or office under the State.")
    ]
    
    let sampleClause = Clause(
        clauseNumber: "2",
        text: "No citizen shall be discriminated against on grounds only of religion, race, caste, sex, place of birth or any of them.",
        subClauses: sampleSubClauses
    )
    
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
            articleId: 14,
            articleNumber: "14",
            title: "Equality before law",
            description: "The State shall not deny to any person equality before the law or the equal protection of the laws within the territory of India.",
            clauses: [sampleClause],
            provisos: nil,
            explanations: nil
        ),
        Article(
            articleId: 15,
            articleNumber: "15",
            title: "Prohibition of discrimination",
            description: "The State shall not discriminate against any citizen on grounds only of religion, race, caste, sex, place of birth or any of them.",
            clauses: nil,
            provisos: nil,
            explanations: nil
        )
    ]
    
    NavigationView {
        ArticleDetailView(article: sampleArticles[1], allArticles: sampleArticles)
    }
}
