//
//  FlickrImage.swift
//  Flickr Finder
//
//  Created by Amulya Gangam on 6/28/24.
//

import Foundation

/// Stores a list of Flickr items fetched from an API response.
/// - parameters:
///     - items: An array of `FlickrItem` objects representing the items.
struct FlickrResponse: Decodable {
    var items: [FlickrItem]
}

/// Stores Flickr item information for populating UI.
/// - parameters:
///     - title: A string representing the title of the item.
///     - link: A string representing the URL of the item's page.
///     - media: A `Media` object containing the media URLs.
///     - date_taken: A string representing the date the photo was taken.
///     - description: A string representing the description of the item.
///     - published: A string representing the date the item was published.
///     - author: A string representing the author of the item.
///     - author_id: A string representing the unique ID of the author.
///     - tags: A string representing the tags associated with the item.
struct FlickrItem: Decodable, Identifiable, Equatable {
    var title: String
    var link: String
    var media: Media
    var date_taken: String
    var description: String
    var published: String
    var author: String
    var author_id: String
    var tags: String
    
    var id: String { "\(author_id)_\(link)" }
    
    // Nested struct for media dictionary
    struct Media: Decodable {
        var m: String
    }
    
    // Computed property to get media URL
    var mediaURL: URL? {
        URL(string: media.m)
    }
    
    // Computed property to get link URL
    var linkURL: URL? {
        URL(string: link)
    }
    
    // Computed property to get published Date
    var publishedDate: Date? {
        ISO8601DateFormatter().date(from: published)
    }
    
    // Computed property to parse width and height from description
    var dimensions: (width: String, height: String)? {
        // Regular expression to match width and height in the description
        let regex = try? NSRegularExpression(pattern: #"width="(\d+)" height="(\d+)""#, options: [])
        let nsString = description as NSString
        if let match = regex?.firstMatch(in: description, options: [], range: NSRange(location: 0, length: nsString.length)) {
            let width = nsString.substring(with: match.range(at: 1))
            let height = nsString.substring(with: match.range(at: 2))
            return (width, height)
        }
        return nil
    }
    
    static func == (lhs: FlickrItem, rhs: FlickrItem) -> Bool {
        return lhs.title == rhs.title &&
        lhs.link == rhs.link &&
        lhs.media.m == rhs.media.m &&
        lhs.date_taken == rhs.date_taken &&
        lhs.description == rhs.description &&
        lhs.published == rhs.published &&
        lhs.author == rhs.author &&
        lhs.author_id == rhs.author_id &&
        lhs.tags == rhs.tags
    }
}
