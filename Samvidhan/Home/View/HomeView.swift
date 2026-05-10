//
//  HomeView.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/9/26.
//

import SwiftUI

//
//  HomeView.swift
//  Samvidhan
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = ConstitutionViewModel()
    
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
            .background(AppColors.pureWhite)
            .navigationTitle("Constitution")
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear {
            viewModel.loadConstitutionData()
        }
    }
}

// MARK: - Loading View
struct LoadingView: View {
    var body: some View {
        VStack(spacing: 20) {
            ProgressView()
                .scaleEffect(1.5)
                .tint(AppColors.saffron)
            
            Text("Loading Constitution...")
                .font(.headline)
                .foregroundColor(AppColors.primaryNavy)
            
            Text("The supreme law of India")
                .font(.caption)
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
            
            Text("Unable to Load Data")
                .font(.headline)
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
                .foregroundColor(AppColors.saffron)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(AppColors.saffron.opacity(0.1))
                .cornerRadius(8)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 60)
    }
}

#Preview {
    HomeView()
}
