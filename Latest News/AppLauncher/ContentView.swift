//
//  ContentView.swift
//  Latest News
//
//  Created by Vikash Kumar on 16/09/24.
//

import SwiftUI

struct ContentView: View {
    private let viewModel = NewsViewModel()
    var body: some View {
        TabView {
            // News Feed Tab
            ArticleListView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("News")
                }
            
            // Bookmark Tab
            BookmarkListView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "bookmark.fill")
                    Text("Bookmarks")
                }
        }
    }
}
