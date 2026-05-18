//
//  SettingsView.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/9/26.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @State private var showingLanguageSheet = false
    @State private var showingAboutSheet = false
    @State private var showingClearCacheConfirmation = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Appearance Section
                    SettingsSection(title: "Appearance") {
                        VStack(spacing: 12) {
                            SettingsRow(
                                icon: "paintpalette.fill",
                                title: "Theme",
                                subtitle: "Choose your preferred theme",
                                value: viewModel.selectedTheme.displayName,
                                action: { viewModel.showThemePicker = true }
                            )
                            SettingsDivider()
                            SettingsRow(
                                icon: "textformat.size",
                                title: "Text Size",
                                subtitle: "Adjust text display size",
                                value: viewModel.textSize.displayName,
                                action: { viewModel.showTextSizePicker = true }
                            )
                            SettingsDivider()
                            SettingsRow(
                                icon: "character.text.justify",
                                title: "Font Style",
                                subtitle: "Change reading font",
                                value: viewModel.fontStyle.displayName,
                                action: { viewModel.showFontPicker = true }
                            )
                            SettingsDivider()
                            SettingsRow(
                                icon: "line.3.horizontal",
                                title: "Line Spacing",
                                subtitle: "Adjust line height",
                                value: viewModel.lineSpacing.displayName,
                                action: { viewModel.showLineSpacingPicker = true }
                            )
                        }
                    }
                    
                    // Reading & Content Section
                    SettingsSection(title: "Reading & Content") {
                        VStack(spacing: 12) {
                            SettingsRow(
                                icon: "highlighter",
                                title: "Highlight Color",
                                subtitle: "Select highlight color for articles",
                                value: viewModel.highlightColor.displayName,
                                action: { viewModel.showHighlightColorPicker = true }
                            )
                            SettingsDivider()
                            SettingsRow(
                                icon: "bookmark.fill",
                                title: "Bookmarks",
                                subtitle: "View saved articles",
                                action: { viewModel.navigateToBookmarks = true }
                            )
                            SettingsDivider()
                            SettingsRow(
                                icon: "clock.arrow.circlepath",
                                title: "Reading History",
                                subtitle: "Recently viewed articles",
                                action: { viewModel.navigateToHistory = true }
                            )
                        }
                    }
                    
                    // Data & Storage Section
                    SettingsSection(title: "Data & Storage") {
                        VStack(spacing: 12) {
                            SettingsToggleRow(
                                icon: "arrow.down.circle.fill",
                                title: "Download for Offline",
                                subtitle: "Access constitution without internet",
                                isOn: $viewModel.isOfflineDownloadEnabled
                            )
                            SettingsDivider()
                            SettingsRow(
                                icon: "trash.fill",
                                title: "Clear Cache",
                                subtitle: "Free up storage space",
                                value: viewModel.cacheSize,
                                action: { showingClearCacheConfirmation = true }
                            )
                            SettingsDivider()
                            SettingsInfoRow(
                                icon: "internaldrive.fill",
                                title: "Storage Usage",
                                subtitle: "Total app storage",
                                value: viewModel.totalStorageUsed
                            )
                        }
                    }
                    
                    // More Section
                    SettingsSection(title: "More") {
                        VStack(spacing: 12) {
                            SettingsRow(
                                icon: "globe",
                                title: "Language",
                                subtitle: "Change app language",
                                value: viewModel.currentLanguage.displayName,
                                action: { showingLanguageSheet = true }
                            )
                            SettingsDivider()
                            SettingsRow(
                                icon: "star.fill",
                                title: "Rate Us",
                                subtitle: "Rate this app on App Store",
                                action: { viewModel.rateApp() }
                            )
                            SettingsDivider()
                            SettingsRow(
                                icon: "square.and.arrow.up",
                                title: "Share App",
                                subtitle: "Share with friends and family",
                                action: { viewModel.shareApp() }
                            )
                            SettingsDivider()
                            SettingsRow(
                                icon: "info.circle.fill",
                                title: "About",
                                subtitle: "Version \(appVersion)",
                                action: { showingAboutSheet = true }
                            )
                        }
                    }
                    
                    // Footer
                    VStack(spacing: 8) {
                        Text("Constitution of India")
                            .font(.caption)
                            .foregroundColor(AppColors.secondaryText)
                        
                        Text("© 2025 Samvidhan. All rights reserved.")
                            .font(.caption2)
                            .foregroundColor(AppColors.secondaryText.opacity(0.7))
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 40)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
            }
            .background(AppColors.background)
            .navigationTitle("Settings")
            .navigationSubtitle("Customize your app experience")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $viewModel.showThemePicker) {
                ThemePickerSheet(selectedTheme: $viewModel.selectedTheme)
            }
            .sheet(isPresented: $viewModel.showTextSizePicker) {
                TextSizePickerSheet(selectedSize: $viewModel.textSize)
            }
            .sheet(isPresented: $viewModel.showFontPicker) {
                FontPickerSheet(selectedFont: $viewModel.fontStyle)
            }
            .sheet(isPresented: $viewModel.showLineSpacingPicker) {
                LineSpacingPickerSheet(selectedSpacing: $viewModel.lineSpacing)
            }
            .sheet(isPresented: $viewModel.showHighlightColorPicker) {
                HighlightColorPickerSheet(selectedColor: $viewModel.highlightColor)
            }
            .sheet(isPresented: $showingLanguageSheet) {
                LanguagePickerSheet(selectedLanguage: $viewModel.currentLanguage)
            }
            .sheet(isPresented: $showingAboutSheet) {
                AboutView()
            }
            .alert("Clear Cache", isPresented: $showingClearCacheConfirmation) {
                Button("Cancel", role: .cancel) { }
                Button("Clear", role: .destructive) {
                    viewModel.clearCache()
                }
            } message: {
                Text("Are you sure you want to clear all cached data? This action cannot be undone.")
            }
        }
    }
    
    private var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }
}

#Preview {
    SettingsView()
}
