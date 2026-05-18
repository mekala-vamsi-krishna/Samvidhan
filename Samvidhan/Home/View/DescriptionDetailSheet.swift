//
//  DescriptionDetailSheet.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/17/26.
//

import SwiftUI

struct DescriptionDetailSheet: View {
    let description: String
    let title: String
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Header
                    HStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(AppColors.saffron.opacity(0.15))
                                .frame(width: 44, height: 44)
                            
                            Image(systemName: "doc.text")
                                .font(.system(size: 22))
                                .foregroundColor(AppColors.saffron)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Full Description")
                                .font(.timesNewRoman(size: 22, weight: .bold))
                                .foregroundColor(AppColors.primaryText)
                            
                            Text(title)
                                .font(.caption)
                                .foregroundColor(AppColors.saffron)
                        }
                    }
                    .padding(.bottom, 8)
                    
                    // Full Description with preserved formatting
                    VStack(alignment: .leading, spacing: 0) {
                        let paragraphs = description.components(separatedBy: "\n\n")
                        
                        ForEach(Array(paragraphs.enumerated()), id: \.offset) { index, paragraph in
                            if !paragraph.trimmingCharacters(in: .whitespaces).isEmpty {
                                VStack(alignment: .leading, spacing: 8) {
                                    let lines = paragraph.components(separatedBy: "\n")
                                    
                                    ForEach(Array(lines.enumerated()), id: \.offset) { lineIndex, line in
                                        let trimmedLine = line.trimmingCharacters(in: .whitespaces)
                                        if !trimmedLine.isEmpty {
                                            // Check if this line starts with a clause pattern like (a), (b), (1), (2)
                                            if let range = trimmedLine.range(of: #"^\([a-zA-Z0-9]+\)"#, options: .regularExpression) {
                                                let clauseNumber = String(trimmedLine[range])
                                                let clauseText = String(trimmedLine[range.upperBound...]).trimmingCharacters(in: .whitespaces)
                                                
                                                HStack(alignment: .top, spacing: 8) {
                                                    Text(clauseNumber)
                                                        .font(.body)
                                                        .fontWeight(.semibold)
                                                        .foregroundColor(AppColors.saffron)
                                                        .frame(width: 35, alignment: .leading)
                                                    
                                                    Text(clauseText)
                                                        .font(.body)
                                                        .foregroundColor(AppColors.primaryText)
                                                        .lineSpacing(6)
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                }
                                            }
                                            // Check for sub-clause pattern with indentation
                                            else if let range = trimmedLine.range(of: #"^\([a-z]+\)"#, options: .regularExpression) {
                                                let subClauseLetter = String(trimmedLine[range])
                                                let subClauseText = String(trimmedLine[range.upperBound...]).trimmingCharacters(in: .whitespaces)
                                                
                                                HStack(alignment: .top, spacing: 8) {
                                                    Text(subClauseLetter)
                                                        .font(.body)
                                                        .fontWeight(.medium)
                                                        .foregroundColor(AppColors.saffron.opacity(0.8))
                                                        .frame(width: 35, alignment: .leading)
                                                    
                                                    Text(subClauseText)
                                                        .font(.body)
                                                        .foregroundColor(AppColors.primaryText)
                                                        .lineSpacing(6)
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                }
                                                .padding(.leading, 20)
                                            }
                                            // Regular text with possible leading spaces
                                            else {
                                                let leadingSpaces = line.prefix(while: { $0 == " " }).count
                                                
                                                Text(trimmedLine)
                                                    .font(.body)
                                                    .foregroundColor(AppColors.primaryText)
                                                    .lineSpacing(6)
                                                    .padding(.leading, leadingSpaces > 0 ? CGFloat(leadingSpaces * 2) : 0)
                                            }
                                        }
                                    }
                                }
                                .padding(.bottom, index < paragraphs.count - 1 ? 12 : 0)
                            }
                        }
                    }
                    .padding(20)
                    .background(Color.gray.opacity(0.03))
                    .cornerRadius(12)
                }
                .padding(20)
            }
            .background(AppColors.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(AppColors.saffron)
                }
            }
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }
}
