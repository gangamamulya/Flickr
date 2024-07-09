//
//  BackgroundGradient.swift
//  Flickr Finder
//
//  Created by Amulya Gangam on 6/28/24.
//

import SwiftUI

/// A view that displays a linear gradient background.
struct BackgroundGradient: View {
    var body: some View {
        /// A linear gradient with colors transitioning from a light pink to a lighter pink.
        LinearGradient(
            gradient: Gradient(colors: [
                Color(.sRGB, red: 1.0, green: 0.9, blue: 0.9, opacity: 1.0), // Light pink color
                Color(.sRGB, red: 0.98, green: 0.85, blue: 0.85, opacity: 1.0) // Lighter pink color
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .edgesIgnoringSafeArea(.all) 
    }
}

#Preview {
    BackgroundGradient()
}
