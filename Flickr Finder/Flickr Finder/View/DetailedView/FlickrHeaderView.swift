//
//  FlickrHeaderView.swift
//  Flickr Finder
//
//  Created by Amulya Gangam on 6/28/24.
//

import SwiftUI

/// A view that displays the header information of a Flickr item.
struct FlickrHeaderView: View {
    /// The Flickr item to be displayed in the header.
    var item: FlickrItem
    
    var body: some View {
        HStack {
            Spacer()
            /// Displays the title of the Flickr item as a large, bold, centered text.
            Text(item.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.vertical)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .truncationMode(.tail)
                .accessibilityLabel("Title")
                .accessibilityValue(item.title)
            Spacer()
        }
    }
}

#Preview {
    FlickrHeaderView(item: FlickrItem(
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
