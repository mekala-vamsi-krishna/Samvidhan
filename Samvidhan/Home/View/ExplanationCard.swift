//
//  ExplanationCard.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/12/26.
//

import SwiftUI

struct ExplanationCard: View {
    let explanation: Explanation
    let onSeeMore: () -> Void
    
    @State private var isTextTruncated = false
    @State private var isExpanded = false
    private let maxLineLimit = 3
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                // Explanation Number Circle
                ZStack {
                    Circle()
                        .fill(AppColors.saffron.opacity(0.12))
                        .frame(width: 34, height: 34)
                    
                    Text(explanation.explanationNumber)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(AppColors.saffron)
                }
                
                // Explanation Content
                VStack(alignment: .leading, spacing: 8) {
                    Text("Explanation")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(AppColors.saffron)
                    
                    Text(explanation.text)
                        .font(.body)
                        .foregroundColor(AppColors.primaryText)
                        .lineSpacing(4)
                        .lineLimit(isExpanded ? nil : maxLineLimit)
                        .background(
                            GeometryReader { geometry in
                                Color.clear.onAppear {
                                    let textView = UITextView()
                                    textView.font = UIFont.systemFont(ofSize: 17)
                                    textView.text = explanation.text
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
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.12), lineWidth: 1)
                )
        )
    }
}
