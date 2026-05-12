// SearchViewModel.swift
import Foundation
import Combine

enum SearchResult: Identifiable {
    case part(Part)
    case article(Article)
    
    var id: UUID {
        switch self {
        case .part(let part): return part.id
        case .article(let article): return article.id
        }
    }
}

@MainActor
class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var results: [SearchResult] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var allParts: [Part] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Observe query changes and filter accordingly
        $query
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] newQuery in
                self?.filterResults(with: newQuery)
            }
            .store(in: &cancellables)
            
        loadData()
    }
    
    func loadData() {
        isLoading = true
        errorMessage = nil
        // Load constitution data using existing model structures
        guard let url = Bundle.main.url(forResource: "constitution", withExtension: "json") else {
            self.errorMessage = "constitution.json not found"
            self.isLoading = false
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(ConstitutionResponse.self, from: data)
            self.allParts = response.constitution.parts
            self.isLoading = false
            filterResults(with: query)
        } catch {
            self.errorMessage = "Failed to load data: \(error.localizedDescription)"
            self.isLoading = false
        }
    }
    
    private func filterResults(with query: String) {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            results = []
            return
        }
        
        let lower = trimmed.lowercased()
        var matched: [SearchResult] = []
        
        for part in allParts {
            var partMatched = false
            if part.partNumber.lowercased().contains(lower) || 
               part.partTitle.lowercased().contains(lower) || 
               part.articleRange.lowercased().contains(lower) {
                matched.append(.part(part))
                partMatched = true
            }
            
            for article in part.articles {
                if String(article.articleNumber).contains(lower) ||
                   article.title.lowercased().contains(lower) ||
                   article.description.lowercased().contains(lower) {
                    matched.append(.article(article))
                    continue
                }
                
                var clauseMatched = false
                if let clauses = article.clauses {
                    for clause in clauses {
                        if clause.clauseNumber.lowercased().contains(lower) || clause.text.lowercased().contains(lower) {
                            clauseMatched = true
                            break
                        }
                        if let subClauses = clause.subClauses {
                            for sub in subClauses {
                                if sub.subClause.lowercased().contains(lower) || sub.text.lowercased().contains(lower) {
                                    clauseMatched = true
                                    break
                                }
                            }
                        }
                        if clauseMatched { break }
                    }
                }
                
                if clauseMatched {
                    matched.append(.article(article))
                }
            }
        }
        
        results = matched
    }
}

