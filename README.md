# TypeFace — Font Preview & Compare

A beautiful, professional iOS app for previewing and comparing all system fonts with custom text in real-world scenarios.

## Features

### 📚 Font Browser
- Browse all iOS system fonts organized by family
- Search and filter through hundreds of fonts
- Live preview with custom text
- View font metadata and character sets

### 🔄 Side-by-Side Comparison
- Compare 2-4 fonts simultaneously
- Drag to reorder comparison panels
- Synchronized text across all panels
- Adjustable panel sizes

### 🎨 Scene Templates
- Title/Heading mockup
- Body Text layout
- Logo design preview
- Poster template
- Social Media Post
- Business Card
- App UI mockup

### ⚙️ Typography Controls
- Font size adjustment
- Weight selection
- Letter spacing control
- Line height adjustment
- Color picker
- Text alignment options

### 💾 Favorites & Collections
- Save favorite fonts
- Create font combinations (pairs/trios)
- Organize collections
- Quick access to saved fonts

### 📤 Export
- Export comparisons as high-resolution PNG
- Share directly from the app
- Perfect for presentations and mockups

## Technical Details

- **Platform**: iOS 17.0+
- **Language**: Swift
- **UI Framework**: SwiftUI
- **Architecture**: MVVM
- **Persistence**: SwiftData
- **Dependencies**: None (100% native)

## Requirements

- Xcode 15.0+
- iOS 17.0+ deployment target
- iPhone and iPad support

## Installation

1. Clone the repository
2. Open `TypeFace.xcodeproj` in Xcode
3. Build and run on simulator or device

## Project Structure

```
TypeFace/
├── Models/              # Data models and SwiftData schemas
├── Views/               # SwiftUI views
│   ├── Browse/         # Font browsing interface
│   ├── Compare/        # Comparison views
│   ├── Templates/      # Template mockups
│   ├── Favorites/      # Favorites management
│   └── Components/     # Reusable UI components
├── ViewModels/         # Observable view models
├── Services/           # Font service and utilities
├── Extensions/         # Swift extensions
└── Utils/              # Helper utilities
```

## Target Audience

- Graphic designers
- Social media managers
- Content creators
- Students
- App developers
- Typography enthusiasts

## License

MIT License - see LICENSE file for details

## Version

1.0.0 - Initial Release

## Support

For issues, questions, or suggestions, please open an issue on GitHub.

---

Built with ❤️ using Swift and SwiftUI
