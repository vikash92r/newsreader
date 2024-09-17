# News Reader App

## Overview

The News Reader app is an iOS application that allows users to browse, read, and bookmark news articles. It features dynamic article loading with pagination, category-based filtering, and the ability to view detailed articles. This README provides information on how to set up, run, and understand the project.

## Features

- **Browse News Articles**: Load and view a list of news articles.
- **Dynamic Loading**: Pagination to load more articles as the user scrolls.
- **Category Filtering**: Filter news articles by category (e.g., Health).
- **Bookmarking**: Bookmark articles and view bookmarked articles.
- **Article Details**: View detailed information about each article.

## Getting Started

### Prerequisites

- Xcode 15 or later
- Swift 5.8 or later

### Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/yourusername/news-reader-app.git
   cd news-reader-app
   ```


### Running the App

1. **Build and Run**

   Select a simulator or connect a physical device and press the run button in Xcode.

2. **Testing**

   Unit tests can be run from Xcode's test navigator. Tests include functionality for fetching articles, toggling bookmarks, and category filtering.

## Project Structure

- **Models**
  - `Article.swift`: Defines the `Article` model used for representing news articles.
  

- **Services**
  - `NewsService.swift`: Handles fetching news articles from the API.
  - `BookmarkService.swift`: Manages bookmark operations.

- **ViewModels**
  - `NewsViewModel.swift`: Manages the state of news articles, including fetching, pagination, and bookmarking.

- **Views**
  - `ArticleListView.swift`: Displays a list of news articles with pagination and filtering.
  - `BookmarkListView.swift`: Displays a list of bookmarked articles.
  - `ArticleDetailView.swift`: Shows detailed information about a selected article.
  - `CategoryFilterView.swift`: Allows users to select a category to filter articles.

- **Helpers**
  - `ScrollDetector.swift`: Detects when the user has scrolled to the bottom of the list to trigger pagination.

## Usage

### Filtering Articles

Tap the filter button in the navigation bar to select a category. The list of articles will be updated based on the selected category.

### Bookmarking Articles

Tap the bookmark icon in the article detail view to add or remove bookmarks. Bookmarked articles can be accessed through the bookmark service.

## Testing

Unit tests are available to verify the functionality of various components. Run the tests from Xcode to ensure everything is working correctly.
