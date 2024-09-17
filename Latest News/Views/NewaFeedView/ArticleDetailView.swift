//
//  ArticleDetailView.swift
//  Latest News
//
//  Created by Vikash Kumar on 16/09/24.
//

import SwiftUI
import SwiftUI

struct ArticleDetailView: View {
    
    @ObservedObject var viewModel: NewsViewModel
    @Binding var article: Article // Ensure Binding is used
    private let isComingFromBookmark: Bool
    init(viewModel: NewsViewModel, article: Binding<Article>, isComingFromBookmark: Bool = false) {
        self.viewModel = viewModel
        _article = article
        self.isComingFromBookmark = isComingFromBookmark
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(article.title)
                    .font(.body)
                    .padding(.bottom, 16)
                    .fontWeight(.bold)
                
                if !article.imageUrl.isEmpty, let url = URL(string: article.imageUrl) {
                    ZStack {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                        } placeholder: {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                        }
                        .frame(height: 200)
                        .clipped() // Ensure the content outside the frame is clipped
                    }
                    .frame(maxWidth: .infinity) // Ensure the ZStack fills the width
                    .clipped()
                }
                
                Text(article.content)
                    .font(.body)
                    .padding(.bottom, 16)
                
                Text(article.summary)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding()
        }
        .navigationTitle("Article Details") // Set title
        .navigationBarTitleDisplayMode(.inline) // Ensure title is centered
        .toolbar {
            
            // Conditionally show the bookmark button based on isBookmarkVisible
            if !isComingFromBookmark {
                ToolbarItem(placement: .navigationBarTrailing) {
                    bookmarkButton
                }
            }
        }
    }
    
    private var bookmarkButton: some View {
        Button(action: toggleBookmark) {
            Image(systemName: article.isBookmarked ? "bookmark.fill" : "bookmark")
                .frame(width: 44, height: 44) // Adjust the frame size
        }
    }
    
    private func toggleBookmark() {
        article.isBookmarked.toggle()
        viewModel.toggleBookmark(for: article)
    }
}
