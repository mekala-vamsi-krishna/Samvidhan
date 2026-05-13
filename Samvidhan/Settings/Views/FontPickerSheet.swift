//
//  FontPickerSheet.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/13/26.
//

import SwiftUI

struct FontPickerSheet: View {
    @Binding var selectedFont: FontStyleOption
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List(FontStyleOption.allCases) { font in
                Button(action: {
                    selectedFont = font
                    dismiss()
                }) {
                    HStack {
                        Text(font.displayName)
                            .font(font.font)
                            .foregroundColor(AppColors.primaryNavy)
                        Spacer()
                        if selectedFont == font {
                            Image(systemName: "checkmark")
                                .foregroundColor(AppColors.saffron)
                        }
                    }
                }
            }
            .navigationTitle("Font Style")
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
