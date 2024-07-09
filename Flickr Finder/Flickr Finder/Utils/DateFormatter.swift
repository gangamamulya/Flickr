//
//  DateFormatter.swift
//  Flickr Finder
//
//  Created by Amulya Gangam on 6/28/24.
//

import Foundation

/// Extension to DateFormatter providing a reusable date formatter for short date style.
extension DateFormatter {
    
    /// A static computed property that returns a DateFormatter configured to display dates in short style.
    ///
    /// This DateFormatter uses the `.short` date style, which typically displays dates in a concise format such as "MM/dd/yy" or "dd/MM/yy" depending on the user's locale.
    ///
    /// - Returns: A DateFormatter instance configured with short date style.
    static var shortDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}
