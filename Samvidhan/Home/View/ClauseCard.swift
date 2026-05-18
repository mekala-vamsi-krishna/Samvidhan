//
//  ClauseCard.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/12/26.
//

import SwiftUI

struct ClauseCard: View {
    let clause: Clause
    let isExpanded: Bool
    let onToggle: () -> Void
    let onSeeMore: () -> Void
    
    @State private var isTextTruncated = false
    private let maxLineLimit = 3
    
    var hasSubClauses: Bool {
        clause.subClauses != nil && !clause.subClauses!.isEmpty
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Main Clause Header
            Button(action: {
                if hasSubClauses {
                    onToggle()
                }
            }) {
                HStack(alignment: .top, spacing: 12) {
                    // Clause Number Circle
                    ZStack {
                        Circle()
                            .fill(AppColors.saffron.opacity(0.12))
                            .frame(width: 34, height: 34)
                        
                        Text(clause.clauseNumber)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(AppColors.saffron)
                    }
                    
                    // Clause Text with See More
                    VStack(alignment: .leading, spacing: 8) {
                        Text(clause.text)
                            .font(.body)
                            .foregroundColor(AppColors.primaryText)
                            .lineSpacing(4)
                            .lineLimit(isExpanded ? nil : maxLineLimit)
                            .background(
                                GeometryReader { geometry in
                                    Color.clear.onAppear {
                                        let textView = UITextView()
                                        textView.font = UIFont.systemFont(ofSize: 17)
                                        textView.text = clause.text
                                        let size = textView.sizeThatFits(CGSize(width: geometry.size.width, height: .greatestFiniteMagnitude))
                                        let lineHeight = textView.font?.lineHeight ?? 20
                                        let totalLines = Int(size.height / lineHeight)
                                        isTextTruncated = totalLines > maxLineLimit && !isExpanded
                                    }
                                }
                            )
                        
                        // See More Button
                        if isTextTruncated {
                            Button(action: onSeeMore) {
                                Text("See more")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(AppColors.saffron)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(16)
            }
            .buttonStyle(PlainButtonStyle())
            
            // Subclauses Section (When Expanded)
            if hasSubClauses && isExpanded {
                VStack(alignment: .leading, spacing: 12) {
                    // Separator
                    Rectangle()
                        .fill(Color.gray.opacity(0.12))
                        .frame(height: 1)
                    
                    // Sub-clauses Header
                    HStack(spacing: 8) {
                        Rectangle()
                            .fill(AppColors.saffron)
                            .frame(width: 3, height: 14)
                            .cornerRadius(1.5)
                        
                        Text("SUB-CLAUSES")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(AppColors.saffron)
                            .tracking(0.8)
                    }
                    .padding(.top, 8)
                    
                    // Subclauses List
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(Array((clause.subClauses ?? []).enumerated()), id: \.offset) { index, subClause in
                            SubclauseItem(subClause: subClause, index: index)
                        }
                    }
                    .padding(.leading, 8)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
                .background(Color.gray.opacity(0.02))
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(AppColors.cardBorder)
                .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.12), lineWidth: 1)
                )
        )
    }
}
