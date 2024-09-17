//
//  BookmarkListView.swift
//  Latest News
//
//  Created by Vikash Kumar on 16/09/24.
//

import SwiftUI


struct BookmarkListView: View {
    
    @ObservedObject var viewModel: NewsViewModel
    @State private var bookmarkedArticles: [Article] = []
    
    var body: some View {
        NavigationView {
            VStack {
                
                if bookmarkedArticles.isEmpty{
                    Text("You don’t have any bookmarks yet. Please visit the news feed and bookmark some articles to view them here.")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List {
                        // Display the list of articles
                        ForEach($bookmarkedArticles) { $article in
                            NavigationLink(destination: ArticleDetailView(viewModel: viewModel, article: $article, isComingFromBookmark: true)) {
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
                    }
                    .listStyle(PlainListStyle())
                    .onAppear {
                        UITableView.appearance().separatorStyle = .none // Remove List separators
                    }
                }
            }
            .navigationTitle("Bookmarks")
            .onAppear {
                self.bookmarkedArticles = viewModel.getBookmarks()
            }
        }
    }
}
