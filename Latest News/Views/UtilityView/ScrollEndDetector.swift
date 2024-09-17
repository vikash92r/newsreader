//
//  ScrollEndDetector.swift
//  Latest News
//
//  Created by Vikash Kumar on 16/09/24.
//

import Foundation
import SwiftUI

struct ScrollDetector: View {
    var scrollThreshold: CGFloat = 150 // Default distance value from the bottom to trigger load more
    let onScrollToEnd: () -> Void

    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .onChange(of: geometry.frame(in: .global).maxY) { value in
                    let screenHeight = UIScreen.main.bounds.height
                    if value < screenHeight + scrollThreshold {
                        DispatchQueue.main.async {
                            onScrollToEnd()
                        }
                    }
                }
        }
    }
}
