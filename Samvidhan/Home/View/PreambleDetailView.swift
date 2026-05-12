//
//  PreambleDetailView.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/12/26.
//

import SwiftUI

struct PreambleDetailView: View {
    @State private var showingShareSheet = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                // MARK: - Preamble Image
                Image("preamble")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: Color.black.opacity(0.1), radius: 15, x: 0, y: 8)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                
                // MARK: - Timeline Cards
                VStack(spacing: 20) {
                    // Timeline Title
                    HStack(spacing: 12) {
                        Rectangle()
                            .fill(AppColors.saffron)
                            .frame(width: 30, height: 2)
                        
                        Text("KEY DATES")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(AppColors.saffron)
                            .tracking(2)
                        
                        Rectangle()
                            .fill(AppColors.saffron)
                            .frame(width: 30, height: 2)
                    }
                    .padding(.top, 8)
                    
                    // Adoption Timeline Item
                    TimelineItem(
                        icon: "📜",
                        title: "Adoption",
                        date: "November 26, 1949",
                        description: "The Constituent Assembly adopted the Constitution",
                        isLast: false
                    )
                    
                    // Effective Timeline Item
                    TimelineItem(
                        icon: "🇮🇳",
                        title: "Enforcement",
                        date: "January 26, 1950",
                        description: "The Constitution came into effect (Republic Day)",
                        isLast: true
                    )
                }
                .padding(24)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 3)
                )
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                
                // MARK: - Footer
                VStack(spacing: 16) {
                    Divider()
                        .background(Color.gray.opacity(0.2))
                        .padding(.horizontal, 40)
                    
                    HStack(spacing: 8) {
                        Image(systemName: "doc.text.fill")
                            .font(.caption)
                            .foregroundColor(AppColors.saffron)
                        
                        Text("PART OF THE CONSTITUTION OF INDIA")
                            .font(.caption2)
                            .fontWeight(.medium)
                            .foregroundColor(AppColors.secondaryText)
                            .tracking(1)
                    }
                    
                    Text("The Preamble serves as a guiding light for the interpretation of the Constitution")
                        .font(.caption2)
                        .foregroundColor(AppColors.secondaryText)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
                .padding(.vertical, 24)
            }
        }
        .background(AppColors.cream)
        .ignoresSafeArea()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingShareSheet = true
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(AppColors.saffron)
                }
            }
        }
        .sheet(isPresented: $showingShareSheet) {
            ShareSheet(activityItems: [shareContent])
        }
    }
    
    private var shareContent: String {
        return """
        The Preamble to the Constitution of India
        
        Adopted: November 26, 1949
        Enforced: January 26, 1950
        
        "We, the people of India..."
        
        — Constitution of India
        """
    }
}

// MARK: - Timeline Item Component
struct TimelineItem: View {
    let icon: String
    let title: String
    let date: String
    let description: String
    let isLast: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // Timeline Line & Icon
            ZStack(alignment: .top) {
                // Vertical Line
                if !isLast {
                    Rectangle()
                        .fill(AppColors.saffron.opacity(0.3))
                        .frame(width: 2)
                        .padding(.top, 40)
                        .padding(.bottom, 8)
                }
                
                // Icon Circle
                ZStack {
                    Circle()
                        .fill(AppColors.saffron.opacity(0.15))
                        .frame(width: 44, height: 44)
                    
                    Text(icon)
                        .font(.system(size: 22))
                }
            }
            .frame(width: 50)
            
            // Content
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(AppColors.primaryNavy)
                
                Text(date)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(AppColors.saffron)
                
                Text(description)
                    .font(.caption)
                    .foregroundColor(AppColors.secondaryText)
                    .lineSpacing(4)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Preview
#Preview {
    NavigationView {
        PreambleDetailView()
    }
}
