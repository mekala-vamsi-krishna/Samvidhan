//
//  HighlightColorPickerSheet.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/13/26.
//

import SwiftUI

struct HighlightColorPickerSheet: View {
    @Binding var selectedColor: HighlightColorOption
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List(HighlightColorOption.allCases) { color in
                Button(action: {
                    selectedColor = color
                    dismiss()
                }) {
                    HStack {
                        Circle()
                            .fill(color.color)
                            .frame(width: 24, height: 24)
                        Text(color.displayName)
                            .foregroundColor(AppColors.primaryNavy)
                        Spacer()
                        if selectedColor == color {
                            Image(systemName: "checkmark")
                                .foregroundColor(AppColors.saffron)
                        }
                    }
                }
            }
            .navigationTitle("Highlight Color")
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
