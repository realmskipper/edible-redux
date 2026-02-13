# EdibleDialect

A modern iOS restaurant discovery app for New York City featuring aggregated review scores, custom visual badges, and AI-powered restaurant insights.

## Overview

EdibleDialect helps you discover and explore NYC restaurants through curated content, interactive maps, and intelligent recommendations. The app aggregates reviews from multiple sources into a single "Edible Score" to help you make informed dining decisions.

## Features

### Core Features
- **Edible Score System**: Aggregated ratings from multiple review sources (Michelin, NYT, Infatuation, Eater, etc.)
- **Interactive Map**: MapKit-based map view showing all restaurants with custom score annotations
- **AI Restaurant Insights**: Virtual Sous Chef generates concise restaurant reviews using Claude AI
- **Smart Navigation**: Bottom tab bar with Maps, Edible Experiences, Search, and Account sections

### Visual Design
- **Custom SVG Badges**: Menu, location, cost, phone, and health grade indicators
- **Circle Score Badges**: Color-coded scores (green 90+, light green 80s, amber 70s, red below)
- **Restaurant Cards**: Clean card design with integrated badges and tap actions
- **Dynamic Header**: Rotating taglines on app launch

### Interactive Elements
- **Direct Actions**: Tap badges to open menus, initiate calls, or launch maps
- **Maps Integration**: Smart routing to Google Maps (with Apple Maps fallback)
- **Sheet-Based Navigation**: Detail views and scoring method explanations
- **Virtual Search Tab**: Auto-focuses search bar when tapped

## Tech Stack

- **Platform**: iOS 17+
- **Framework**: SwiftUI
- **Maps**: MapKit with custom annotations
- **AI**: Anthropic Claude API (Sonnet 4)
- **Architecture**: MVVM pattern
- **State Management**: ObservableObject + EnvironmentObject

## Current Status

**This is a prototype using mock data.** All restaurant information, reviews, and ratings are hardcoded for demonstration purposes. Real addresses and coordinates are used for NYC restaurants.

### Completed
- ✅ Core UI/UX with custom design system
- ✅ All custom SVG badges implemented
- ✅ MapKit integration with restaurant pins
- ✅ AI-powered restaurant blurbs
- ✅ Tab-based navigation
- ✅ Restaurant photos (6/10 complete)

### In Progress
- 🔄 Remaining restaurant photos (4 needed)
- 🔄 API key security (currently hardcoded)

### Planned
- 📋 Real review data integration (web scraping or API)
- 📋 Cached AI responses to reduce API costs
- 📋 User accounts and favorites
- 📋 Premium features (chat interface, advanced filtering)

## Project Structure

```
EdibleDialect/
├── App/
│   ├── EdibleDialectApp.swift
│   ├── ContentView.swift          # Tab navigation controller
│   └── AppTabState.swift           # Shared navigation state
├── Models/
│   └── Restaurant.swift            # Restaurant data model
├── Views/
│   ├── Components/
│   │   ├── RestaurantCard.swift
│   │   ├── ScoreBadge.swift
│   │   ├── InfoButton.swift
│   │   ├── TabIcon.swift
│   │   └── SearchBar.swift
│   └── Screens/
│       ├── HomeScreen.swift        # Main feed (Edible Experiences)
│       ├── MapScreen.swift         # MapKit view
│       ├── RestaurantDetailScreen.swift
│       ├── ScoringMethodScreen.swift
│       ├── AboutScreen.swift
│       └── AccountScreen.swift
├── Services/
│   ├── MockDataService.swift      # Hardcoded restaurant data
│   └── AIService.swift             # Claude API integration
└── Resources/
    ├── DesignSystem.swift
    └── Assets.xcassets/            # SVG badges, photos, app icon
```

## Design System

- **Primary Color**: Edible Green (#00563F)
- **Background**: Off-white (#FAFAFA)
- **Typography**: SF Pro with custom sizing
- **Spacing**: 4pt grid system
- **Icons**: Custom SVG badges with vector preservation

## Installation

1. Clone the repository
2. Open `EdibleDialect/EdibleDialect.xcodeproj` in Xcode
3. Build and run on iOS 17+ simulator or device

**Note**: AI features require a valid Anthropic API key in `Services/AIService.swift`.

## Data Sources

Current mock data includes 10 NYC restaurants:
- Carbone (Greenwich Village)
- Le Bernardin (Midtown)
- Peter Luger (Williamsburg)
- Lilia (Williamsburg)
- Momofuku Ko (East Village)
- Sripraphai (Queens)
- Di Fara Pizza (Brooklyn)
- Katz's Delicatessen (Lower East Side)
- M. Wells (Queens)
- Hunan Kitchen (Midtown)

## Future Plans

See `/ideas` directory for detailed plans:
- `monetizations.md` - Premium tier and revenue strategy
- `photo_collection_ideas.md` - Photo sourcing and attribution
- `review_ideas.md` - Community features and review system

## License

Private project - not licensed for public use.

## Contact

Built with Claude Code by Anthropic.
