//
//  ArticleListView.swift
//  Latest News
//
//  Created by Vikash Kumar on 16/09/24.
//

import SwiftUI

struct ArticleListView: View {
    @ObservedObject var viewModel: NewsViewModel
    @State private var showFilterSheet = false
    @State private var selectedCategory: Category? = nil

    private let scrollThreshold: CGFloat = 150 // Distance from the bottom to trigger load more
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading && viewModel.articles.isEmpty {
                    // Show loader in the center when loading the first page
                    ProgressView("Loading articles...")
                        .scaleEffect(1.5)
                        .padding()
                } else {
                    if let errorMessage = viewModel.errorMessage, viewModel.articles.isEmpty{
                        // Show error message if available
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        List {
                            // Display the list of articles
                            ForEach($viewModel.articles) { $article in
                                NavigationLink(destination: ArticleDetailView(viewModel: viewModel, article: $article)) {
                                    VStack(alignment: .leading) {
                                        Text(article.title)
                                            .font(.headline)
                                            .lineLimit(2)
                                        Text(article.summary)
                                            .font(.subheadline)
                                            .lineLimit(4)
                                    }
                                    .padding(.vertical, 8)
                                }
                            }
                            
                            // Bottom loader when fetching more data
                            if viewModel.isLoading && !viewModel.articles.isEmpty {
                                HStack {
                                    Spacer()
                                    ProgressView()
                                    Spacer()
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                        .onAppear {
                            UITableView.appearance().separatorStyle = .none // Remove List separators
                        }
                        .background(ScrollDetector(scrollThreshold: scrollThreshold, onScrollToEnd: {
                            if !viewModel.isLoading && viewModel.hasMoreArticles {
                                viewModel.fetchArticles(category: selectedCategory) // Fetch the next page
                            }
                        }))
                    }
                }
            }
            .navigationBarBackButtonHidden()
            .navigationTitle("Home")
            .toolbarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: filterButton)
            .sheet(isPresented: $showFilterSheet) {
                CategoryFilterView(selectedCategory: $selectedCategory, onApply: {
                    viewModel.resetPage()
                    viewModel.fetchArticles(category: selectedCategory)
                })
            }

        }
        .onAppear {
            if viewModel.articles.isEmpty {
                viewModel.fetchArticles(category: selectedCategory)
            }
        }
    }
    
    private var filterButton: some View {
           Button(action: {
               showFilterSheet.toggle()
           }) {
               Image(systemName: "line.horizontal.3.decrease.circle") // Filter icon
                   .imageScale(.large)
           }
       }
}
