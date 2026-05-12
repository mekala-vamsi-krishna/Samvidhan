//
//  ExplanationDetailSheet.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/12/26.
//

import SwiftUI

struct ExplanationDetailSheet: View {
    let explanation: Explanation
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
                            
                            Text(explanation.explanationNumber)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(AppColors.saffron)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Explanation \(explanation.explanationNumber)")
                                .font(.timesNewRoman(size: 22, weight: .semibold))
                                .foregroundColor(AppColors.primaryNavy)
                        }
                    }
                    .padding(.bottom, 8)
                    
                    // Full Explanation Text
                    VStack(alignment: .leading, spacing: 12) {
                        Text(explanation.text)
                            .font(.body)
                            .foregroundColor(AppColors.primaryText)
                            .lineSpacing(6)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(16)
                    .background(Color.gray.opacity(0.05))
                    .cornerRadius(12)
                }
                .padding(20)
            }
            .background(AppColors.pureWhite)
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
