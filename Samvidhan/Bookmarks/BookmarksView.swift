//
//  BookmarksView.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/9/26.
//

import SwiftUI

struct BookmarksView: View {
    var body: some View {
        NavigationStack {
            Text("Saved Articles")
                .navigationTitle("Bookmarks")
        }
    }
}

#Preview {
    BookmarksView()
}
