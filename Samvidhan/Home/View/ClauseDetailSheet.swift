//
//  ClauseDetailSheet.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/12/26.
//


import SwiftUI

struct ClauseDetailSheet: View {
    let clause: Clause
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Clause Header
                    HStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(AppColors.saffron.opacity(0.15))
                                .frame(width: 44, height: 44)
                            
                            Text(clause.clauseNumber)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(AppColors.saffron)
                        }
                        
                        Text("Clause")
                            .font(.timesNewRoman(size: 22, weight: .semibold))
                            .foregroundColor(AppColors.primaryText)
                    }
                    .padding(.bottom, 8)
                    
                    // Full Clause Text
                    VStack(alignment: .leading, spacing: 12) {
                        Text(clause.text)
                            .font(.body)
                            .foregroundColor(AppColors.primaryText)
                            .lineSpacing(6)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(16)
                    .background(Color.gray.opacity(0.05))
                    .cornerRadius(12)
                    
                    // Subclauses if available
                    if let subClauses = clause.subClauses, !subClauses.isEmpty {
                        VStack(alignment: .leading, spacing: 16) {
                            HStack(spacing: 8) {
                                Rectangle()
                                    .fill(AppColors.saffron)
                                    .frame(width: 4, height: 18)
                                    .cornerRadius(2)
                                
                                Text("Sub-clauses")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(AppColors.primaryText)
                            }
                            
                            VStack(alignment: .leading, spacing: 20) {
                                ForEach(Array(subClauses.enumerated()), id: \.offset) { index, subClause in
                                    VStack(alignment: .leading, spacing: 8) {
                                        HStack(alignment: .top, spacing: 12) {
                                            ZStack {
                                                Circle()
                                                    .fill(AppColors.saffron.opacity(0.12))
                                                    .frame(width: 28, height: 28)
                                                
                                                Text(subClause.subClause)
                                                    .font(.system(size: 14, weight: .bold))
                                                    .foregroundColor(AppColors.saffron)
                                            }
                                            
                                            Text(subClause.text)
                                                .font(.body)
                                                .foregroundColor(AppColors.primaryText)
                                                .lineSpacing(5)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                    }
                                    .padding()
                                    .background(Color.gray.opacity(0.03))
                                    .cornerRadius(10)
                                }
                            }
                        }
                    }
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
