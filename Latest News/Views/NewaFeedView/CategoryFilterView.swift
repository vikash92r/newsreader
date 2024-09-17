//
//  CategoryFilterView.swift
//  Latest News
//
//  Created by Vikash Kumar on 17/09/24.
//

import SwiftUI

struct CategoryFilterView: View {
    @Binding var selectedCategory: Category?
    var onApply: () -> Void
    
    private let categories: [Category] = Category.allCases

    var body: some View {
        NavigationView {
            List {
                ForEach(categories, id: \.self) { category in
                    Button(action: {
                        selectedCategory = category
                        onApply()
                    }) {
                        HStack {
                            Text(category.description)
                            Spacer()
                            if selectedCategory == category {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Select Category")
            .navigationBarItems(trailing: Button("Done") {
                // Dismiss the sheet
                UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true)
            })
        }
    }
}

