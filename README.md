
# Flickr Finder

Flickr Finder is a native iOS application developed in SwiftUI, designed to help users search for images on Flickr. The app provides a clean and interactive way to view search results and detailed information about each image, including the ability to share images and metadata.

## Features

- **Search Images**: Users can enter keywords in the search bar to find images on Flickr.
- **Real-time Updates**: The search results are updated in real-time as the user types.
- **Image Grid**: Display search results in a grid of thumbnail images.
- **Detailed View**: Tap on an image to view detailed information including the image, title, description, author, published date, and dimensions.
- **Share Functionality**: Users can share the metadata.
- **Voice Accessibility**: The app includes accessibility support with voice-over for visually impaired users.
- **Landscape Orientation**: The app supports both portrait and landscape orientations.
- **Animated Transitions**: Smooth animations for transitioning from the grid view to the detailed view and while scrolling through the grid view.

## Prerequisites

- Xcode 15.2 or later
- iOS 17.2 or later
- Swift 5 or later

## Installation

To set up the project locally:

1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/FlickrFinder.git
   ```
2. Open `FlickrFinder.xcodeproj` in Xcode.
3. Select your target device or simulator.
4. Press `Cmd + R` to build and run the application.

## Architecture

Flickr Finder is structured using the MVVM (Model-View-ViewModel) architecture pattern, enhancing the separation of concerns and simplifying the management of UI state and business logic.

### Components

#### Model

- `FlickrItem` : Represents an individual Flickr image item.
- `FlickrResponse` : Represents the response from the Flickr API containing a list of Flickr items.

#### View

- `FlickrView` : The main view that displays the search bar and grid of image results.
- `FlickrDetailedView` : Displays detailed information about a selected Flickr image.
- `FlickrHeaderView` :  Displays the title  of a Flickr item.
- `FlickrImageView` : Displays the main image of a Flickr item with various states and effects.
- `DescriptionView` :  Displays the description of a Flickr item. 
- `DetailsView` : Displays detailed information about a Flickr item including author, published date, and dimensions.
- `BackgroundGradient` :  A view that displays a linear gradient background.
- `AttributedText` :  A view that wraps a UILabel to display attributed text in SwiftUI.
- `ShareSheet` :  A view that presents a share sheet for sharing content

#### ViewModel

- `FlickrViewModel` :  Manages the state and data for the Flickr view, including handling search text and fetching images.

#### Networking

- `FlickrService` : Responsible for fetching Flickr data from the API.

#### Utils

- `DateFormatter` : Provides custom date formatting.
- `FlickrError` : Custom error types for handling different error scenarios.

### Network Operations

- **Fetching Images**:
  - Utilizes `URLSession` and Combine to send a request to `https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=KEYWORDS`.
  - Processes the JSON response to populate the list of images.

### Error Handling

Flickr Finder includes comprehensive error handling using custom `FlickrError` enum to manage different error scenarios:

- Invalid URL
- Request Failed
- Decoding Failed
- Unknown Error

## Testing

Flickr Finder includes both unit and UI tests to ensure the robustness and stability of the application:

- **Unit Tests**:
  - `FlickrViewModelTests`: Tests for view model logic and data binding.

- **UI Tests**:
  - `FlickrUITests`: Tests for user interface interactions including searching and viewing detailed information.
    
[UI Tests](https://github.com/gangamamulya/Flickr/assets/171300562/d5502a71-e8cb-422f-85e9-deb1e47cc223)


### Running Tests

Tests can be executed from the `FlickrFinderTests` and `FlickrFinderUITests` directories by pressing `Cmd + U` in Xcode.

## Accessibility

Flickr Finder includes accessibility support such as:

- **VoiceOver Support**: Accessibility labels, hints, and values for all interactive elements.
  
[Voice Over Support Video](https://github.com/gangamamulya/Flickr/assets/88301130/7ee66b66-acf4-452c-9226-3ced680d41ff)


## Demo Video

See Flickr Finder in action:

[Demo Video](https://github.com/gangamamulya/Flickr/assets/88301130/bc5ec0de-c6cb-491c-bd6e-7dc2c93835b2)


