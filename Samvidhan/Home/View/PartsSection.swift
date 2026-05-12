//
//  PartsSection.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/9/26.
//

import SwiftUI

struct PartsSection: View {
    let parts: [Part]
    
    var displayedParts: [Part] {
        Array(parts.prefix(5))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Section Header
            HStack {
                Text("Constitution Parts")
                    .font(.timesNewRoman(size: 22, weight: .bold))
                    .foregroundColor(AppColors.primaryNavy)
                
                Spacer()
                
                if parts.count > 5 {
                    NavigationLink(destination: AllPartsView(parts: parts)) {
                        HStack(spacing: 4) {
                            Text("View All")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            Image(systemName: "arrow.right")
                                .font(.subheadline)
                        }
                        .foregroundColor(AppColors.saffron)
                    }
                }
            }
            
            // Parts Cards
            VStack(spacing: 12) {
                ForEach(displayedParts) { part in
                    PartCard(part: part)
                }
            }
        }
    }
}

#Preview {
    PartsSection(parts: [])
}
