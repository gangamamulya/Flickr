//
//  FlickrImageView.swift
//  Flickr Finder
//
//  Created by Amulya Gangam on 6/28/24.
//

import SwiftUI

/// A view that displays the main image of a Flickr item with various states and effects.
struct FlickrImageView: View {
    /// The Flickr item containing the image to be displayed.
    var item: FlickrItem
    
    /// The namespace for matched geometry effect.
    var namespace: Namespace.ID
    
    var body: some View {
        ZStack {
            /// Asynchronously loads and displays the image from the provided URL.
            AsyncImage(url: item.mediaURL) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 300)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        .matchedGeometryEffect(id: item.id, in: namespace)
                        .accessibilityLabel("Image")
                        .accessibilityValue(item.title)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width - 40, height: 300)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        .accessibilityLabel("Image not available")
                case .empty:
                    ProgressView()
                        .frame(width: UIScreen.main.bounds.width - 40, height: 300)
                        .accessibilityLabel("Loading image")
                @unknown default:
                    EmptyView()
                        .frame(width: UIScreen.main.bounds.width - 40, height: 300)
                }
            }
            
            /// Applies a gradient overlay on top of the image for better text visibility.
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.6), Color.clear]),
                startPoint: .bottom,
                endPoint: .top
            )
            .cornerRadius(20)
        }
        .frame(width: UIScreen.main.bounds.width - 40, height: 300)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white, lineWidth: 4)
        )
        .shadow(color: .pink.opacity(0.5), radius: 30)
    }
}

#Preview {
    FlickrImageView(item: FlickrItem(
        title: "Orange Choppers",
        link: "https://www.flickr.com/photos/mtsofan/53818972996/",
        media: FlickrItem.Media(m: "https://live.staticflickr.com/65535/53818972996_69ed98cbc9_m.jpg"),
        date_taken: "2024-06-27T06:12:31-08:00",
        description: """
            <p><a href="https://www.flickr.com/people/mtsofan/">MTSOfan</a> posted a photo:</p>
            <p><a href="https://www.flickr.com/photos/mtsofan/53818972996/" title="Orange Choppers">
            <img src="https://live.staticflickr.com/65535/53818972996_69ed98cbc9_m.jpg" width="240" height="194" alt="Orange Choppers" /></a></p>
            <p>Here's a closer look at those porcupine teeth.<br />
            <br /> According to the zoo's website, there are "almost thirty" species of porcupine. Each animal's body is covered with about 30,000 quills.</p>
            """,
        published: "2024-06-27T10:17:53Z",
        author: "nobody@flickr.com (\"MTSOfan\")",
        author_id: "8628862@N05",
        tags: "porcupine teeth orange epz erethizondorsatum rodent nikonz5"
    ), namespace: Namespace().wrappedValue)
}
