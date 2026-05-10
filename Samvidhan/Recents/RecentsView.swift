//
//  RecentsView.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/9/26.
//

import SwiftUI

struct RecentsView: View {
    var body: some View {
        NavigationStack {
            Text("Recently Viewed Articles")
                .navigationTitle("Recents")
        }
    }
}

#Preview {
    RecentsView()
}
