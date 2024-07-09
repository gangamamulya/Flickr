//
//  FlickrDetailedView.swift
//  Flickr Finder
//
//  Created by Amulya Gangam on 6/28/24.
//

import SwiftUI

/// A view displaying detailed information about a selected Flickr image.
struct FlickrDetailedView: View {
    /// The Flickr item to be displayed.
    var item: FlickrItem
    
    /// The namespace for matched geometry effect.
    var namespace: Namespace.ID
    
    /// State variable to track the selected tab in the picker.
    @State private var selectedTab = 0
    
    /// State variable to control the presentation of the share sheet.
    @State private var isShareSheetPresented = false
    
    var body: some View {
        ZStack {
            /// Background gradient for the view.
            BackgroundGradient()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    /// Header view displaying the title of the Flickr item.
                    FlickrHeaderView(item: item)
                    
                    /// Image view displaying the main image of the Flickr item.
                    FlickrImageView(item: item, namespace: namespace)
                    
                    /// Picker to switch between description and details view.
                    Picker("", selection: $selectedTab) {
                        Text("Description").tag(0)
                        Text("Details").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .accessibilityLabel("Picker")
                    .accessibilityHint("Switch between description and details")
                    
                    /// Conditional views based on the selected tab.
                    if selectedTab == 0 {
                        /// View displaying the description of the Flickr item.
                        DescriptionView(description: item.description)
                    } else if selectedTab == 1 {
                        /// View displaying the details of the Flickr item.
                        DetailsView(item: item)
                    }
                    
                    /// Share button to share the image and metadata.
                    Button(action: {
                        isShareSheetPresented = true
                    }) {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                                .font(.title)
                            Text("Share")
                                .fontWeight(.bold)
                                .font(.title)
                                .lineLimit(1)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.pink.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    .sheet(isPresented: $isShareSheetPresented) {
                        ShareSheet(activityItems: [item.title, item.mediaURL!, item.description])
                    }
                }
                .padding([.horizontal, .bottom])
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    FlickrDetailedView(item: FlickrItem(
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
