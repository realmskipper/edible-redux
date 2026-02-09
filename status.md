# EdibleDialect iOS App - Status

## Last Updated: Feb 8, 2026

### Overview
iOS restaurant discovery app for NYC featuring aggregated review scores, custom badges, and restaurant details.

---

## Completed Features

### Custom SVG Badges
All info buttons use custom SVG badges (no SF Symbols):
| Badge | Asset Name | Usage |
|-------|------------|-------|
| Menu | `MenuBadge` | Opens restaurant menu URL |
| Location | `LocationBadge` | Opens address in Google Maps (falls back to Apple Maps) |
| Cost (expensive) | `CostBadge` | For $$$ and $$$$ restaurants |
| Cost (budget) | `CostBadge2` | For $ and $$ restaurants |
| Phone | `PhoneBadge` | Initiates phone call |
| Health Grade A | `HealthScoreA` | For grade A restaurants |
| Health Grade B | `HealthScoreB` | For grade B/C restaurants |
| Hours | `HoursBadge` | Available but not currently used |

### Restaurant Photos Added
| Restaurant | Asset Name | Format |
|------------|------------|--------|
| Carbone | `carbone` | JPG |
| Peter Luger | `peter_luger` | JPG |
| Lilia | `lilia` | AVIF |
| Sripraphai | `sripraphai` | AVIF |
| Di Fara Pizza | `difara` | JPG |
| Katz's Deli | `katz` | JPG |

### Still Need Photos
- Le Bernardin (`le_bernardin`)
- Momofuku Ko (`momofuku_ko`)
- M. Wells (`mwells`)
- Hunan Kitchen (`hunan_kitchen`)

### UI Changes
- **Home screen**: Vertical scroll layout (featured + all restaurants)
- **Borough buttons**: Text only, no icons
- **Info badges**: Icons only, no text labels underneath
- **Restaurant cards**: No gradient overlay on photos
- **Detail screen**: Square hero image (1:1 aspect ratio)
- **App Icon**: Updated to new "ed" plate logo (`newappicon`)

### Maps Integration
- Location badge and location section both open maps
- Tries Google Maps app first
- Falls back to Apple Maps if Google Maps not installed

### Feb 5 Session - AI Features & UI Tweaks

**Virtual Sous Chef (AI Blurbs)**
- Added `Services/AIService.swift` — calls Anthropic Claude API
- Generates 2-sentence restaurant review blurbs on-demand
- Displays in `RestaurantDetailScreen` with "— Virtual Sous Chef" attribution
- Loading state: "Our sous chef is thinking..."
- API key hardcoded for testing (swap for production)
- Model: `claude-sonnet-4-20250514`

**Rotating Taglines**
- Header tagline randomly selected on each app launch
- Options: "we're talking food", "Find your next favorite", "Your table awaits", "Dinner, decided", "Your guide to great eats", "Real reviews. Real flavor", "The verdict on every dish"

**Header Redesign**
- Logo "edible dialect" increased to 38pt (was 32pt)
- Title and tagline now centered
- Tagline offset slightly to the right

**Info Button Redesign**
- Moved from bottom-right floating button to top-right
- Semi-transparent (60% opacity green background)
- Auto-fades out after 10 seconds with 2-second dissolve animation
- Still opens About screen

**Idea Documents Created**
- `monetizations.md` — Premium tier ideas, AI feature paywall, unit economics
- `photo_collection_ideas.md` — Outreach strategy for sourcing photos with attribution
- `review_ideas.md` — Cached reviews, pinned reviews, community voting, premium photo uploads

### Feb 6 Session - Cleanup & Polish

**Header Scroll Behavior**
- Header ("edible dialect" + tagline) now scrolls naturally with content
- Disappears off-screen as user scrolls down, like a website title

**App Icon Updated**
- Replaced old icon with new "ed" plate logo (green "e", blue "d" on white plate)

**Katz's Deli Photo**
- Added `katz.jpg` photo and linked it in mock data

**Menu URLs Completed**
- All 10 restaurants now have menu URLs populated
- Added URLs for Momofuku Ko, Di Fara Pizza, and Hunan Kitchen
- Also added missing website URLs for Di Fara and Hunan Kitchen

### Feb 7 Session - Bottom Tab Bar Navigation

**Tab Bar Added**
- 4-tab bottom navigation: Maps, Edible Experiences, Search, Account
- SF Symbols for icons (structured for easy swap to custom SVGs via `TabIcon` component)
- Selected tab highlighted in edibleGreen
- Default tab: Edible Experiences

**Maps Tab**
- Apple MapKit view centered on NYC with all restaurant locations
- Custom map pins showing Edible Score in green circles
- Tap a pin to open restaurant detail sheet
- Added `latitude`/`longitude` to Restaurant model with real NYC coordinates for all 10 restaurants

**Edible Experiences Tab**
- Existing home feed (featured + all restaurants) now lives here
- No changes to content or behavior

**Search Tab (Virtual)**
- Not a standalone screen — tapping it switches to Edible Experiences and auto-focuses the search bar
- Uses shared `AppTabState` ObservableObject for cross-tab communication

**Account Tab**
- Placeholder "Coming soon" screen

**New Files**
- `App/AppTabState.swift` — Shared tab navigation state (`AppTab` enum + `AppTabState` ObservableObject)
- `Views/Components/TabIcon.swift` — Swappable icon component (SF Symbol or custom SVG)
- `Views/Screens/MapScreen.swift` — MapKit-based map screen
- `Views/Screens/AccountScreen.swift` — Placeholder account screen

**Modified Files**
- `App/ContentView.swift` — Now contains `TabView` with all 4 tabs
- `Views/Screens/HomeScreen.swift` — Added `@EnvironmentObject` for tab state
- `Views/Components/SearchBar.swift` — Added external focus trigger binding
- `Models/Restaurant.swift` — Added `latitude`, `longitude`, `coordinate` computed property
- `Services/MockDataService.swift` — Added real lat/lng coordinates to all restaurants

### Feb 8 Session - Card Badges & Visual Polish

**Tagline Fade Animation**
- Tagline below "edible dialect" now fades out after 3 seconds (1.5s easeOut dissolve)
- Tagline overlaps slightly with title (offset -6pt) for a tighter header look

**SVG Badge Icons on Restaurant Cards**
- Replaced `$$$$` price text with CostBadge/CostBadge2 SVG graphics inline on cards
- Added HealthScoreA/HealthScoreB badge on cards (visual, not tappable)
- Added tappable MenuBadge — opens restaurant menu URL in browser
- Added tappable PhoneBadge — initiates phone call
- Added tappable LocationBadge — opens Google Maps (falls back to Apple Maps)
- All badges at 22pt height, pushed to right side of info row via Spacer
- Text info row now shows: `Cuisine • Neighborhood` on the left, badges on the right

**Circle Score Badges**
- Edible Score badges changed from rounded rectangles to circles
- Sizes: small (44pt), medium (60pt), large (80pt)
- Same color-coded backgrounds (green 90+, light green 80s, amber 70s, red below)

**Git Repository Initialized**
- Local git repo created with `.gitignore` (excludes .DS_Store, xcuserdata, DerivedData, .claude/)
- Initial commit: full app baseline
- Second commit: tonight's card badges + circle scores + tagline fade

**Modified Files**
- `Views/Components/RestaurantCard.swift` — SVG badge row replacing price text
- `Views/Components/ScoreBadge.swift` — Circle shape instead of rounded rectangle
- `Views/Screens/HomeScreen.swift` — Tagline fade-out animation + overlap offset

---

## Technical Notes

### Data Source
Currently using **mock data** in `MockDataService.swift`:
- Reviews/ratings are hardcoded (not real)
- Addresses are real locations for actual NYC restaurants
- Hours are hardcoded (may not be accurate)

### Future API Integration (Tabled)
Discussed but not implemented:
- Google Places API (~$17/1k requests, $200/mo free credit)
- Yelp Fusion API (500 free requests/day)
- Foursquare API (50 free requests/day, expensive paid tiers)
- **Alternative**: Web scraping with Python/BeautifulSoup, store locally

### Image Format Support
- JPG/PNG: Universal support
- AVIF: Requires iOS 16+
- SVG: Supported for badges with `preserves-vector-representation: true`

---

## File Structure

### Key Files
- `App/ContentView.swift` - TabView controller (Maps, Edible Experiences, Search, Account)
- `App/AppTabState.swift` - Shared tab navigation state
- `Views/Components/InfoButton.swift` - Badge buttons with dynamic icon selection
- `Views/Components/RestaurantCard.swift` - Restaurant card (no overlay)
- `Views/Components/TabIcon.swift` - Swappable tab bar icon (SF Symbol / custom SVG)
- `Views/Screens/HomeScreen.swift` - Vertical scroll home screen (Edible Experiences tab)
- `Views/Screens/MapScreen.swift` - MapKit map with restaurant pins
- `Views/Screens/AccountScreen.swift` - Account placeholder
- `Views/Screens/RestaurantDetailScreen.swift` - Detail view with square hero image, AI blurb section
- `Services/MockDataService.swift` - Mock restaurant data with coordinates
- `Services/AIService.swift` - Anthropic Claude API integration for AI blurbs
- `Resources/Assets.xcassets/` - All images and badges

---

## Next Steps (Ideas)
- [ ] Add remaining restaurant photos
- [ ] Web scraping backend for real review scores
- [ ] Scrape restaurant photos from websites
- [ ] Add hours badge functionality back
- [ ] Real API integration (if budget allows)
- [ ] Cache AI blurbs to reduce API costs at scale
- [ ] Implement premium paywall (see `monetizations.md`)
- [ ] Add "Ask questions" chat feature for premium users
- [ ] Photo outreach campaign (see `photo_collection_ideas.md`)
- [ ] Human-written/pinned reviews system (see `review_ideas.md`)
- [ ] Secure API key storage (replace hardcoded key)
