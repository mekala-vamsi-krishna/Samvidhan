//
//  HomeView.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/9/26.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = ConstitutionViewModel()
    @State private var isLogoAnimating = false
    @ObservedObject private var themeManager = ThemeManager.shared
    
    // Dynamic logo based on theme
    private var logoImageName: String {
        let theme = themeManager.currentTheme
        switch theme {
        case .light:
            return "logo"
        case .dark:
            return "logo-dark"
        case .system:
            // Follow system appearance
            return UITraitCollection.current.userInterfaceStyle == .dark ? "logo-dark" : "logo"
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    if viewModel.isLoading {
                        LoadingView()
                    } else if let error = viewModel.errorMessage {
                        ErrorView(errorMessage: error, retryAction: {
                            viewModel.loadConstitutionData()
                        })
                    } else {
                        // MARK: - Logo Section
                        logoSection
                        
                        // Preamble Card
                        if let preamble = viewModel.preamble {
                            PreambleCard(preamble: preamble)
                        }
                        
                        // Constitution Parts Section
                        PartsSection(parts: viewModel.parts)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }
            .background(AppColors.background)
            .navigationBarHidden(true)
        }
        .onAppear {
            viewModel.loadConstitutionData()
            withAnimation(.easeInOut(duration: 0.8).delay(0.3)) {
                isLogoAnimating = true
            }
        }
        .onReceive(themeManager.$currentTheme) { _ in
            // Force view update when theme changes
            isLogoAnimating = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isLogoAnimating = true
                }
            }
        }
    }
    
    // MARK: - Logo Section with Theme Support
    private var logoSection: some View {
        VStack(spacing: 12) {
            Image(logoImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 150)
                .scaleEffect(isLogoAnimating ? 1.0 : 0.9)
                .opacity(isLogoAnimating ? 1.0 : 0.0)
                .animation(.easeOut(duration: 0.5), value: isLogoAnimating)
        }
    }
}

// MARK: - Loading View
struct LoadingView: View {
    @State private var isRotating = false
    
    var body: some View {
        VStack(spacing: 20) {
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(AppColors.saffron, lineWidth: 3)
                .frame(width: 50, height: 50)
                .rotationEffect(.degrees(isRotating ? 360 : 0))
                .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: isRotating)
                .onAppear {
                    isRotating = true
                }
            
            Text("Loading Constitution...")
                .font(.subheadline)
                .foregroundColor(AppColors.secondaryText)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 60)
    }
}

// MARK: - Error View
struct ErrorView: View {
    let errorMessage: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(AppColors.saffron)
            
            Text("Failed to Load")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(AppColors.primaryNavy)
            
            Text(errorMessage)
                .font(.caption)
                .foregroundColor(AppColors.secondaryText)
                .multilineTextAlignment(.center)
            
            Button(action: retryAction) {
                HStack {
                    Image(systemName: "arrow.clockwise")
                    Text("Retry")
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(AppColors.saffron)
                .foregroundColor(AppColors.cardBackground)
                .cornerRadius(10)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 60)
    }
}

// MARK: - Preview
#Preview {
    HomeView()
}
