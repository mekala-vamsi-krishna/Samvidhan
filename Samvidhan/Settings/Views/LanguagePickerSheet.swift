//
//  LanguagePickerSheet.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/13/26.
//

import SwiftUI

struct LanguagePickerSheet: View {
    @Binding var selectedLanguage: LanguageOption
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List(LanguageOption.allCases) { language in
                Button(action: {
                    selectedLanguage = language
                    dismiss()
                }) {
                    HStack {
                        Text(language.displayName)
                            .foregroundColor(AppColors.primaryNavy)
                        Spacer()
                        if selectedLanguage == language {
                            Image(systemName: "checkmark")
                                .foregroundColor(AppColors.saffron)
                        }
                    }
                }
            }
            .navigationTitle("Language")
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
