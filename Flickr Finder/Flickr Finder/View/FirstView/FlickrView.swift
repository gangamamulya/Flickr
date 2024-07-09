//
//  FlickrView.swift
//  Flickr Finder
//
//  Created by Amulya Gangam on 6/28/24.
//
import SwiftUI

/// A view that displays a Flickr image search interface, including a search bar and a grid of image results.
struct FlickrView: View {
    /// The view model that manages the state and data for the view.
    @StateObject private var viewModel = FlickrViewModel()
    
    /// The namespace for matched geometry effect.
    @Namespace private var namespace
    
    var body: some View {
        NavigationView {
            VStack {
                searchBar
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                        .accessibilityLabel("Loading")
                        .accessibilityHint("Please wait while we fetch the Flickr images")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                        .accessibilityLabel("Error message")
                        .accessibilityHint(errorMessage)
                } else {
                    gridView
                        .padding()
                        .animation(.easeInOut, value: viewModel.items)
                }
            }
            .navigationTitle("Flickr Finder")
            .background(Color.white.edgesIgnoringSafeArea(.all))
        }
    }
    
    /// The search bar view for entering search keywords.
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white)
                .font(.title)
                .accessibilityHidden(true)
            TextField("Search", text: $viewModel.searchText)
                .foregroundColor(.white)
                .padding(10)
                .background(Color.white.opacity(0.2))
                .cornerRadius(10)
                .accessibilityLabel("Search Fields")
                .accessibilityHint("Enter keywords to search for images")
        }
        .padding()
        .background(Color.pink.opacity(0.3))
        .cornerRadius(15)
        .padding()
    }
    
    /// The grid view that displays the fetched Flickr images.
    private var gridView: some View {
        ScrollView {
            let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: self.calculateNumberOfColumns(in: UIScreen.main.bounds.width))
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.items) { item in
                    NavigationLink(destination: FlickrDetailedView(item: item, namespace: namespace)) {
                        ZStack {
                            AsyncImage(url: item.mediaURL) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: 150, height: 150)
                                        .background(Color.white.opacity(0.8))
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                        .accessibilityLabel("Loading image")
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 150, height: 150)
                                        .overlay(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color.black.opacity(0.6), Color.clear]),
                                                startPoint: .bottom,
                                                endPoint: .top
                                            )
                                            .cornerRadius(10)
                                        )
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(color: .gray, radius: 5, x: 2, y: 2)
                                        .matchedGeometryEffect(id: item.id, in: namespace)
                                        .transition(.scale(scale: 0.5, anchor: .center))
                                        .animation(.easeInOut(duration: 0.5))
                                        .accessibilityLabel(item.title)
                                    
                                case .failure:
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 150, height: 150)
                                        .foregroundColor(.gray)
                                        .background(Color.white.opacity(0.8))
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                        .accessibilityLabel("Image not available")
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(width: 150, height: 150)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 4)
                            )
                        }
                    }
                    .accessibilityElement(children: .combine)
                }
            }
            .padding()
        }
    }
    
    /// Calculates the number of columns for the grid based on the screen width.
    /// - Parameter width: The width of the screen.
    /// - Returns: The number of columns that fit in the given width.
    private func calculateNumberOfColumns(in width: CGFloat) -> Int {
        let minColumnWidth: CGFloat = 150
        return max(Int(width / minColumnWidth), 1)
    }
}

#Preview {
    FlickrView()
}

