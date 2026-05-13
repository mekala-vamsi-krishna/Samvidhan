//
//  ThemePickerSheet.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/13/26.
//

import SwiftUI

struct ThemePickerSheet: View {
    @Binding var selectedTheme: ThemeOption
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List(ThemeOption.allCases) { theme in
                Button(action: {
                    selectedTheme = theme
                    dismiss()
                }) {
                    HStack {
                        Text(theme.displayName)
                            .foregroundColor(AppColors.primaryNavy)
                        Spacer()
                        if selectedTheme == theme {
                            Image(systemName: "checkmark")
                                .foregroundColor(AppColors.saffron)
                        }
                    }
                }
            }
            .navigationTitle("Select Theme")
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
