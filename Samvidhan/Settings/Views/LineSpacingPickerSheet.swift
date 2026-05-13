//
//  LineSpacingPickerSheet.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/13/26.
//

import SwiftUI

struct LineSpacingPickerSheet: View {
    @Binding var selectedSpacing: LineSpacingOption
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List(LineSpacingOption.allCases) { spacing in
                Button(action: {
                    selectedSpacing = spacing
                    dismiss()
                }) {
                    HStack {
                        Text(spacing.displayName)
                            .foregroundColor(AppColors.primaryNavy)
                        Spacer()
                        if selectedSpacing == spacing {
                            Image(systemName: "checkmark")
                                .foregroundColor(AppColors.saffron)
                        }
                    }
                }
            }
            .navigationTitle("Line Spacing")
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
