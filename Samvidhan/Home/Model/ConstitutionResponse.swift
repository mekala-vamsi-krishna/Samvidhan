//
//  Articles.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/9/26.
//

import Foundation

// MARK: - Root Response
struct ConstitutionResponse: Codable {
    let constitution: ConstitutionData
}

struct ConstitutionData: Codable {
    let preamble: Preamble
    let parts: [Part]
}

// MARK: - Preamble
struct Preamble: Codable {
    let title: String
    let description: String
    let keywords: [String]
}

// MARK: - Part
struct Part: Codable, Identifiable {
    let id = UUID()
    let partId: Int
    let partNumber: String
    let partTitle: String
    let articleRange: String
    let articles: [Article]
    
    enum CodingKeys: String, CodingKey {
        case partId, partNumber, partTitle, articleRange, articles
    }
}

// MARK: - Article
struct Article: Codable, Identifiable {
    let id = UUID()
    let articleId: Int
    let articleNumber: Int
    let title: String
    let description: String
    let clauses: [Clause]?
    let provisos: [Proviso]?
    let explanations: [Explanation]?
    
    enum CodingKeys: String, CodingKey {
        case articleId, articleNumber, title, description, clauses, provisos, explanations
    }
}

// MARK: - Clause
struct Clause: Codable, Identifiable {
    let id = UUID()
    let clauseNumber: String
    let text: String
    let subClauses: [SubClause]?
    
    enum CodingKeys: String, CodingKey {
        case clauseNumber, text, subClauses
    }
}

// MARK: - SubClause
struct SubClause: Codable, Identifiable {
    let id = UUID()
    let subClause: String
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case subClause, text
    }
}

// MARK: - Proviso
struct Proviso: Codable, Identifiable {
    let id = UUID()
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case text
    }
}

// MARK: - Explanation
struct Explanation: Codable, Identifiable {
    let id = UUID()
    let explanationNumber: String
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case explanationNumber, text
    }
}
