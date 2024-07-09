//
//  DetailsView.swift
//  Flickr Finder
//
//  Created by Amulya Gangam on 6/28/24.
//

import SwiftUI

/// A view that displays the details of a Flickr item.
struct DetailsView: View {
    /// The Flickr item containing the details to be displayed.
    var item: FlickrItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            /// Header for the author section.
            Text("Author")
                .font(.title2)
                .fontWeight(.bold)
                .accessibilityLabel("Author")
            
            /// Displays the author of the Flickr item.
            Text(item.author)
                .font(.body)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white.opacity(0.8))
                .cornerRadius(20)
                .shadow(radius: 10)
                .accessibilityLabel("Author name")
                .accessibilityValue(item.author)
            
            /// Conditionally displays the published date if available.
            if let publishedDate = item.publishedDate {
                Text("Published Date")
                    .font(.title2)
                    .fontWeight(.bold)
                    .accessibilityLabel("Published Date")
                
                Text(publishedDate, formatter: DateFormatter.shortDate)
                    .font(.body)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .accessibilityLabel("Published Date value")
                    .accessibilityValue(DateFormatter.shortDate.string(from: publishedDate))
            }
            
            /// Add dimensions text if available
            if let dimensions = item.dimensions {
                Text("Dimensions")
                    .font(.title2)
                    .fontWeight(.bold)
                    .accessibilityLabel("Dimensions")
                
                Text("\(dimensions.width) x \(dimensions.height)")
                    .font(.body)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .accessibilityLabel("Image dimensions")
                    .accessibilityValue("\(dimensions.width) by \(dimensions.height) pixels")
            }
        }
        .padding()
    }
}

#Preview {
    DetailsView(item: FlickrItem(
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
    ))
}
