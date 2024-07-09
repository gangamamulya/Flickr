//
//  DescriptionView.swift
//  Flickr Finder
//
//  Created by Amulya Gangam on 6/28/24.
//

import SwiftUI

/// A view that displays the description of a Flickr item.
struct DescriptionView: View {
    /// The HTML description of the Flickr item to be displayed.
    var description: String
    
    var body: some View {
        ScrollView { // Make the view scrollable
            VStack(alignment: .leading) {
                /// Header text for the description section.
                Text("Description")
                    .font(.title2)
                    .fontWeight(.bold)
                    .accessibilityLabel("Description")
                
                /// Displays the HTML description content.
                AttributedText(attributedString: plainDescription(from: description))
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .accessibilityLabel("Description content")
                    .accessibilityValue(description)
            }
            .padding([.horizontal, .bottom])
        }
    }
    
    /// Converts an HTML string into an NSAttributedString.
    /// - Parameter htmlString: The HTML string to be converted.
    /// - Returns: An NSAttributedString representation of the HTML string.
    private func plainDescription(from htmlString: String) -> NSAttributedString {
        guard let data = htmlString.data(using: .utf8) else {
            return NSAttributedString(string: htmlString)
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil)
        return attributedString ?? NSAttributedString(string: htmlString)
    }
}

#Preview {
    DescriptionView(description: """
        <p><a href="https://www.flickr.com/people/mtsofan/">MTSOfan</a> posted a photo:</p>
        <p><a href="https://www.flickr.com/photos/mtsofan/53818972996/" title="Orange Choppers">
        <img src="https://live.staticflickr.com/65535/53818972996_69ed98cbc9_m.jpg" width="240" height="194" alt="Orange Choppers" /></a></p>
        <p>Here's a closer look at those porcupine teeth.<br />
        <br /> According to the zoo's website, there are "almost thirty" species of porcupine. Each animal's body is covered with about 30,000 quills.</p>
        """)
}
