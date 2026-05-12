//
//  SubClauseItem.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/12/26.
//

import SwiftUI

struct SubclauseItem: View {
    let subClause: SubClause
    let index: Int
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Subclause Letter Circle
            ZStack {
                Circle()
                    .fill(AppColors.saffron.opacity(0.12))
                    .frame(width: 26, height: 26)
                
                Text(subClause.subClause)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(AppColors.saffron)
            }
            
            // Subclause Text
            Text(subClause.text)
                .font(.subheadline)
                .foregroundColor(AppColors.primaryText)
                .lineSpacing(4)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 4)
    }
}
