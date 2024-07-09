//
//  AttributedText.swift
//  Flickr Finder
//
//  Created by Amulya Gangam on 6/28/24.
//

import SwiftUI

/// A view that wraps a UILabel to display attributed text in SwiftUI.
struct AttributedText: UIViewRepresentable {
    /// The attributed string to be displayed.
    var attributedString: NSAttributedString
    
    /// Creates the UILabel that will be used to display the attributed string.
    /// - Parameter context: The context in which the view is created.
    /// - Returns: A configured UILabel instance.
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.attributedText = attributedString
        return label
    }
    
    /// Updates the UILabel with new data.
    /// - Parameters:
    ///   - uiView: The UILabel instance to be updated.
    ///   - context: The context in which the update is occurring.
    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.attributedText = attributedString
    }
}

#Preview {
    AttributedText(attributedString: NSAttributedString(string: """
    <p><a href="https://www.flickr.com/people/mtsofan/">MTSOfan</a> posted a photo:</p>
    <p><a href="https://www.flickr.com/photos/mtsofan/53818972996/" title="Orange Choppers">
    <img src="https://live.staticflickr.com/65535/53818972996_69ed98cbc9_m.jpg" width="240" height="194" alt="Orange Choppers" /></a></p>
    <p>Here's a closer look at those porcupine teeth.<br />
    <br /> According to the zoo's website, there are "almost thirty" species of porcupine. Each animal's body is covered with about 30,000 quills.</p>
    """))
}
