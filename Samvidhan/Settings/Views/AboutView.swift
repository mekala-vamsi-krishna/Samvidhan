//
//  AboutView.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/13/26.
//

import SwiftUI

struct AboutView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // App Logo
                    Image("AppIcon")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 22))
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                    
                    Text("Samvidhan")
                        .font(.timesNewRoman(size: 28, weight: .bold))
                        .foregroundColor(AppColors.primaryNavy)
                    
                    Text("Version \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0")")
                        .font(.caption)
                        .foregroundColor(AppColors.secondaryText)
                    
                    Divider()
                        .padding(.horizontal, 40)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        AboutRow(title: "Developer", value: "Mekala Vamsi Krishna")
                        AboutRow(title: "Purpose", value: "Digital Constitution of India")
                        AboutRow(title: "Data Source", value: "Government of India")
                        AboutRow(title: "Privacy Policy", value: "No data collection")
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                }
                .padding(.vertical, 40)
            }
            .navigationTitle("About")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }
                        .foregroundColor(AppColors.saffron)
                }
            }
        }
    }
}

struct AboutRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(AppColors.secondaryText)
            Spacer()
            Text(value)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(AppColors.primaryNavy)
        }
        .padding(.vertical, 8)
    }
}
