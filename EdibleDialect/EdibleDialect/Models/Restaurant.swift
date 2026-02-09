import Foundation
import CoreLocation

// MARK: - Borough
enum Borough: String, CaseIterable, Identifiable {
    case manhattan = "Manhattan"
    case brooklyn = "Brooklyn"
    case queens = "Queens"
    case elsewhere = "Elsewhere"

    var id: String { rawValue }

    var displayName: String { rawValue }

    var icon: String {
        switch self {
        case .manhattan: return "building.2"
        case .brooklyn: return "leaf"
        case .queens: return "crown"
        case .elsewhere: return "map"
        }
    }
}

// MARK: - Cuisine Type
enum CuisineType: String, CaseIterable, Identifiable {
    case italian = "Italian"
    case japanese = "Japanese"
    case mexican = "Mexican"
    case american = "American"
    case french = "French"
    case chinese = "Chinese"
    case indian = "Indian"
    case thai = "Thai"
    case korean = "Korean"
    case mediterranean = "Mediterranean"
    case seafood = "Seafood"
    case steakhouse = "Steakhouse"
    case pizza = "Pizza"
    case vietnamese = "Vietnamese"
    case other = "Other"

    var id: String { rawValue }
}

// MARK: - Price Range
enum PriceRange: Int, CaseIterable, Identifiable {
    case budget = 1
    case moderate = 2
    case upscale = 3
    case fineDining = 4

    var id: Int { rawValue }

    var displayString: String {
        String(repeating: "$", count: rawValue)
    }
}

// MARK: - Health Grade
enum HealthGrade: String, CaseIterable, Identifiable {
    case a = "A"
    case b = "B"
    case c = "C"
    case pending = "Pending"

    var id: String { rawValue }

    var color: String {
        switch self {
        case .a: return "00563F"
        case .b: return "F5A623"
        case .c: return "D0021B"
        case .pending: return "9B9B9B"
        }
    }
}

// MARK: - Review Source
enum ReviewSource: String, CaseIterable, Identifiable {
    case google = "Google"
    case yelp = "Yelp"
    case menuPages = "MenuPages"
    case zomato = "Zomato"
    case foursquare = "Foursquare"
    case nyTimes = "NY Times"
    case zagat = "Zagat"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .google: return "g.circle.fill"
        case .yelp: return "star.circle.fill"
        case .menuPages: return "book.circle.fill"
        case .zomato: return "fork.knife.circle.fill"
        case .foursquare: return "location.circle.fill"
        case .nyTimes: return "newspaper.circle.fill"
        case .zagat: return "rosette"
        }
    }

    var maxRating: Double {
        switch self {
        case .foursquare: return 10.0
        case .nyTimes, .zagat: return 4.0
        default: return 5.0
        }
    }

    var curve: Double {
        switch self {
        case .nyTimes, .zagat: return 20.0
        case .foursquare: return 0.0
        default: return 10.0
        }
    }

    var isProfessional: Bool {
        switch self {
        case .nyTimes, .zagat: return true
        default: return false
        }
    }
}

// MARK: - Source Review
struct SourceReview: Identifiable, Codable {
    let id: UUID
    let source: String
    let rawRating: Double
    let reviewCount: Int?
    let url: String?

    var reviewSource: ReviewSource? {
        ReviewSource(rawValue: source)
    }

    var convertedScore: Double {
        guard let reviewSource = reviewSource else { return 0 }

        let baseScore = (rawRating / reviewSource.maxRating) * 100
        let curvedScore = min(baseScore + reviewSource.curve, 100)

        return curvedScore
    }
}

// MARK: - Restaurant
struct Restaurant: Identifiable, Codable {
    let id: UUID
    let name: String
    let cuisineType: String
    let borough: String
    let neighborhood: String
    let address: String
    let phoneNumber: String
    let priceRange: Int
    let healthGrade: String?
    let menuURL: String?
    let websiteURL: String?
    let imageURL: String
    let heroImageURL: String?
    let hours: [String: String]
    let sourceReviews: [SourceReview]
    let isFeatured: Bool
    let dateAdded: Date
    let latitude: Double?
    let longitude: Double?

    var coordinate: CLLocationCoordinate2D? {
        guard let latitude = latitude, let longitude = longitude else { return nil }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var cuisineTypeEnum: CuisineType {
        CuisineType(rawValue: cuisineType) ?? .other
    }

    var boroughEnum: Borough {
        Borough(rawValue: borough) ?? .elsewhere
    }

    var priceRangeEnum: PriceRange {
        PriceRange(rawValue: priceRange) ?? .moderate
    }

    var healthGradeEnum: HealthGrade? {
        guard let grade = healthGrade else { return nil }
        return HealthGrade(rawValue: grade)
    }

    var edibleScore: Int {
        guard !sourceReviews.isEmpty else { return 0 }

        let totalScore = sourceReviews.reduce(0.0) { $0 + $1.convertedScore }
        let averageScore = totalScore / Double(sourceReviews.count)

        return min(Int(round(averageScore)), 100)
    }

    var formattedPhone: String {
        guard phoneNumber.count == 10 else { return phoneNumber }
        let areaCode = phoneNumber.prefix(3)
        let middle = phoneNumber.dropFirst(3).prefix(3)
        let last = phoneNumber.suffix(4)
        return "(\(areaCode)) \(middle)-\(last)"
    }

    var todayHours: String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        let today = formatter.string(from: Date())
        return hours[today]
    }
}

// MARK: - Restaurant Extension for Mock Data
extension Restaurant {
    static func mock() -> Restaurant {
        Restaurant(
            id: UUID(),
            name: "Sample Restaurant",
            cuisineType: CuisineType.italian.rawValue,
            borough: Borough.manhattan.rawValue,
            neighborhood: "West Village",
            address: "123 Main St, New York, NY 10014",
            phoneNumber: "2125551234",
            priceRange: 2,
            healthGrade: "A",
            menuURL: "https://example.com/menu",
            websiteURL: "https://example.com",
            imageURL: "restaurant_placeholder",
            heroImageURL: "restaurant_hero_placeholder",
            hours: [
                "Monday": "11:00 AM - 10:00 PM",
                "Tuesday": "11:00 AM - 10:00 PM",
                "Wednesday": "11:00 AM - 10:00 PM",
                "Thursday": "11:00 AM - 11:00 PM",
                "Friday": "11:00 AM - 11:00 PM",
                "Saturday": "10:00 AM - 11:00 PM",
                "Sunday": "10:00 AM - 9:00 PM"
            ],
            sourceReviews: [
                SourceReview(id: UUID(), source: "Google", rawRating: 4.5, reviewCount: 234, url: nil),
                SourceReview(id: UUID(), source: "Yelp", rawRating: 4.2, reviewCount: 156, url: nil)
            ],
            isFeatured: false,
            dateAdded: Date(),
            latitude: 40.7335,
            longitude: -74.0003
        )
    }
}
