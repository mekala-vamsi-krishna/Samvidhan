//
//  AboutView.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/13/26.
//

import SwiftUI

struct AboutView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var themeManager = ThemeManager.shared
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 28) {
                    // App Logo with gradient background
                    VStack(spacing: 16) {
                        ZStack {
                            // Animated gradient background
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            AppColors.saffron.opacity(0.15),
                                            AppColors.saffron.opacity(0.05),
                                            AppColors.cardBackground
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 140, height: 140)
                                .shadow(color: AppColors.saffron.opacity(0.2), radius: 10, x: 0, y: 5)
                            
                            Image("logo")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 18))
                                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                        }
                        
                        Text("Samvidhan")
                            .font(.timesNewRoman(size: 28, weight: .bold))
                            .foregroundColor(AppColors.primaryText)
                        
                        Text("Version \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0")")
                            .font(.caption)
                            .foregroundColor(AppColors.secondaryText)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 4)
                            .background(AppColors.cardBorder.opacity(0.3))
                            .cornerRadius(8)
                    }
                    .padding(.top, 20)
                    
                    // App Description Card
                    VStack(alignment: .leading, spacing: 16) {
                        HStack(spacing: 12) {
                            Image(systemName: "doc.text.fill")
                                .font(.title3)
                                .foregroundColor(AppColors.saffron)
                            
                            Text("About the App")
                                .font(.headline)
                                .foregroundColor(AppColors.primaryText)
                        }
                        
                        Text("Samvidhan is a comprehensive digital platform that brings the Constitution of India to your fingertips. It provides easy access to all articles, parts, and schedules with a user-friendly interface.")
                            .font(.subheadline)
                            .foregroundColor(AppColors.primaryText)
                            .lineSpacing(4)
                            .multilineTextAlignment(.leading)
                    }
                    .padding(20)
                    .background(AppColors.cardBackground)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(AppColors.cardBorder, lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                    
                    // Information Cards
                    VStack(spacing: 12) {
                        // Developer Card
                        InfoCard(
                            icon: "person.circle.fill",
                            title: "Developer",
                            value: "Mekala Vamsi Krishna",
                            subtitle: "iOS Developer & Designer"
                        )
                        
                        // Purpose Card
                        InfoCard(
                            icon: "target",
                            title: "Purpose",
                            value: "Digital Constitution of India",
                            subtitle: "Making the Constitution accessible to all"
                        )
                        
                        // Data Source Card
                        InfoCard(
                            icon: "server.rack",
                            title: "Data Source",
                            value: "Government of India",
                            subtitle: "Ministry of Law and Justice"
                        )
                        
                        // Privacy Card
                        InfoCard(
                            icon: "lock.shield.fill",
                            title: "Privacy Policy",
                            value: "No Data Collection",
                            subtitle: "Your data stays on your device"
                        )
                    }
                    .padding(.horizontal, 20)
                    
                    // Footer
                    VStack(spacing: 12) {
                        Divider()
                            .background(AppColors.cardBorder)
                            .padding(.horizontal, 40)
                        
                        HStack(spacing: 20) {
                            Link(destination: URL(string: "https://github.com/mekala-vamsi-krishna/Samvidhan")!) {
                                Image(systemName: "link.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(AppColors.secondaryText)
                            }
                            
                            Link(destination: URL(string: "https://www.linkedin.com/in/mekala-vamsi-krishna/")!) {
                                Image(systemName: "network")
                                    .font(.title2)
                                    .foregroundColor(AppColors.secondaryText)
                            }
                            
                            Link(destination: URL(string: "vamsikrishnayadav2002@gmail.com")!) {
                                Image(systemName: "envelope.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(AppColors.secondaryText)
                            }
                        }
                        
                        Text("© 2025 Samvidhan. All rights reserved.")
                            .font(.caption2)
                            .foregroundColor(AppColors.secondaryText.opacity(0.7))
                            .padding(.top, 4)
                    }
                    .padding(.bottom, 30)
                }
                .padding(.vertical, 20)
            }
            .background(AppColors.background)
            .navigationTitle("About")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(AppColors.cardBackground, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(themeManager.currentTheme == .dark ? .dark : .light, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(AppColors.saffron)
                }
            }
        }
        .preferredColorScheme(themeManager.currentTheme == .system ? nil : (themeManager.currentTheme == .light ? .light : .dark))
    }
}

// MARK: - Info Card Component
struct InfoCard: View {
    let icon: String
    let title: String
    let value: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon Circle
            ZStack {
                Circle()
                    .fill(AppColors.iconBackground)
                    .frame(width: 50, height: 50)
                
                Image(systemName: icon)
                    .font(.system(size: 22))
                    .foregroundColor(AppColors.iconTint)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(AppColors.secondaryText)
                    .tracking(0.5)
                
                Text(value)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(AppColors.primaryText)
                
                Text(subtitle)
                    .font(.caption2)
                    .foregroundColor(AppColors.secondaryText)
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(AppColors.cardBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(AppColors.cardBorder, lineWidth: 1)
                )
        )
        .shadow(color: Color.black.opacity(0.03), radius: 2, x: 0, y: 1)
    }
}

// MARK: - Preview
#Preview {
    AboutView()
        .previewDisplayName("About View - Standard")
}
