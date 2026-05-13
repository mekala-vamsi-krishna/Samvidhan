//
//  TextSizePickerSheet.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/13/26.
//

import SwiftUI

struct TextSizePickerSheet: View {
    @Binding var selectedSize: TextSizeOption
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List(TextSizeOption.allCases) { size in
                Button(action: {
                    selectedSize = size
                    dismiss()
                }) {
                    HStack {
                        Text(size.displayName)
                            .font(.system(size: size.fontSize))
                            .foregroundColor(AppColors.primaryNavy)
                        Spacer()
                        if selectedSize == size {
                            Image(systemName: "checkmark")
                                .foregroundColor(AppColors.saffron)
                        }
                    }
                }
            }
            .navigationTitle("Text Size")
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
