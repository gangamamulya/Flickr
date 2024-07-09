//
//  ShareSheet.swift
//  Flickr Finder
//
//  Created by Amulya Gangam on 6/29/24.
//

import SwiftUI
import UIKit

/// A view that presents a share sheet for sharing content.
struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
