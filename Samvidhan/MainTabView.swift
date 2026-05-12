//
//  MainTabView.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/9/26.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var selectedTab: AppTab = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            Tab("Home",
                systemImage: "house.fill",
                value: AppTab.home) {
                NavigationStack {
                    HomeView()
                }
            }
            
            Tab("Bookmarks",
                systemImage: "bookmark.fill",
                value: AppTab.bookmarks) {
                NavigationStack {
                    BookmarksView()
                }
            }
            
            Tab("Recents",
                systemImage: "clock.fill",
                value: AppTab.recents) {
                NavigationStack {
                    RecentsView()
                }
            }
            
            Tab("Search",
                systemImage: "magnifyingglass",
                value: AppTab.search,
                role: .search) {
                NavigationStack {
                    SearchView()
                }
            }
            
            Tab("Settings",
                systemImage: "gearshape.fill",
                value: AppTab.settings) {
                NavigationStack {
                    SettingsView()
                }
            }
        }
        .tint(AppColors.saffron)
    }
}

enum AppTab: Hashable {
    case home
    case bookmarks
    case recents
    case settings
    case search
}

#Preview {
    MainTabView()
}
