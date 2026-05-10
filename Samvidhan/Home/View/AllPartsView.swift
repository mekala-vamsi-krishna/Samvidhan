//
//  AllPartsView.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/10/26.
//

import SwiftUI

struct AllPartsView: View {
    let parts: [Part]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(parts) { part in
                    PartCard(part: part)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .background(AppColors.cream)
        .navigationTitle("All Parts")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AllPartsView(parts: [])
}
