import Foundation

class MockDataService {
    static let shared = MockDataService()

    private init() {}

    func getRestaurants() -> [Restaurant] {
        return [
            // Manhattan
            Restaurant(
                id: UUID(),
                name: "Carbone",
                cuisineType: "Italian",
                borough: "Manhattan",
                neighborhood: "Greenwich Village",
                address: "181 Thompson St, New York, NY 10012",
                phoneNumber: "2122543000",
                priceRange: 4,
                healthGrade: "A",
                menuURL: "https://carbonenewyork.com/menu",
                websiteURL: "https://carbonenewyork.com",
                imageURL: "carbone",
                heroImageURL: "carbone_hero",
                hours: [
                    "Monday": "5:00 PM - 11:00 PM",
                    "Tuesday": "5:00 PM - 11:00 PM",
                    "Wednesday": "5:00 PM - 11:00 PM",
                    "Thursday": "5:00 PM - 11:00 PM",
                    "Friday": "5:00 PM - 11:30 PM",
                    "Saturday": "5:00 PM - 11:30 PM",
                    "Sunday": "5:00 PM - 10:00 PM"
                ],
                sourceReviews: [
                    SourceReview(id: UUID(), source: "Google", rawRating: 4.7, reviewCount: 3421, url: nil),
                    SourceReview(id: UUID(), source: "Yelp", rawRating: 4.5, reviewCount: 2156, url: nil),
                    SourceReview(id: UUID(), source: "Foursquare", rawRating: 9.4, reviewCount: 892, url: nil),
                    SourceReview(id: UUID(), source: "NY Times", rawRating: 3.0, reviewCount: nil, url: nil),
                    SourceReview(id: UUID(), source: "Zagat", rawRating: 3.5, reviewCount: nil, url: nil)
                ],
                isFeatured: true,
                dateAdded: Date(),
                latitude: 40.7272,
                longitude: -73.9999
            ),

            Restaurant(
                id: UUID(),
                name: "Le Bernardin",
                cuisineType: "Seafood",
                borough: "Manhattan",
                neighborhood: "Midtown West",
                address: "155 W 51st St, New York, NY 10019",
                phoneNumber: "2125541515",
                priceRange: 4,
                healthGrade: "A",
                menuURL: "https://le-bernardin.com/menus",
                websiteURL: "https://le-bernardin.com",
                imageURL: "le_bernardin",
                heroImageURL: "le_bernardin_hero",
                hours: [
                    "Monday": "12:00 PM - 2:30 PM, 5:15 PM - 10:30 PM",
                    "Tuesday": "12:00 PM - 2:30 PM, 5:15 PM - 10:30 PM",
                    "Wednesday": "12:00 PM - 2:30 PM, 5:15 PM - 10:30 PM",
                    "Thursday": "12:00 PM - 2:30 PM, 5:15 PM - 10:30 PM",
                    "Friday": "12:00 PM - 2:30 PM, 5:15 PM - 11:00 PM",
                    "Saturday": "5:15 PM - 11:00 PM",
                    "Sunday": "Closed"
                ],
                sourceReviews: [
                    SourceReview(id: UUID(), source: "Google", rawRating: 4.8, reviewCount: 2891, url: nil),
                    SourceReview(id: UUID(), source: "Yelp", rawRating: 4.6, reviewCount: 1823, url: nil),
                    SourceReview(id: UUID(), source: "Foursquare", rawRating: 9.6, reviewCount: 1205, url: nil),
                    SourceReview(id: UUID(), source: "NY Times", rawRating: 4.0, reviewCount: nil, url: nil),
                    SourceReview(id: UUID(), source: "Zagat", rawRating: 4.0, reviewCount: nil, url: nil)
                ],
                isFeatured: true,
                dateAdded: Date(),
                latitude: 40.7618,
                longitude: -73.9816
            ),

            Restaurant(
                id: UUID(),
                name: "Katz's Delicatessen",
                cuisineType: "American",
                borough: "Manhattan",
                neighborhood: "Lower East Side",
                address: "205 E Houston St, New York, NY 10002",
                phoneNumber: "2122542246",
                priceRange: 2,
                healthGrade: "A",
                menuURL: "https://katzsdelicatessen.com/menu",
                websiteURL: "https://katzsdelicatessen.com",
                imageURL: "katz",
                heroImageURL: "katz",
                hours: [
                    "Monday": "8:00 AM - 10:45 PM",
                    "Tuesday": "8:00 AM - 10:45 PM",
                    "Wednesday": "8:00 AM - 10:45 PM",
                    "Thursday": "8:00 AM - 2:45 AM",
                    "Friday": "8:00 AM - Open 24 hours",
                    "Saturday": "Open 24 hours",
                    "Sunday": "Open 24 hours - 10:45 PM"
                ],
                sourceReviews: [
                    SourceReview(id: UUID(), source: "Google", rawRating: 4.6, reviewCount: 15234, url: nil),
                    SourceReview(id: UUID(), source: "Yelp", rawRating: 4.3, reviewCount: 8912, url: nil),
                    SourceReview(id: UUID(), source: "Foursquare", rawRating: 9.3, reviewCount: 3421, url: nil)
                ],
                isFeatured: true,
                dateAdded: Date(),
                latitude: 40.7223,
                longitude: -73.9873
            ),

            Restaurant(
                id: UUID(),
                name: "Momofuku Ko",
                cuisineType: "Japanese",
                borough: "Manhattan",
                neighborhood: "East Village",
                address: "8 Extra Pl, New York, NY 10003",
                phoneNumber: "2122038095",
                priceRange: 4,
                healthGrade: "A",
                menuURL: "https://ko.momofuku.com/menu",
                websiteURL: "https://ko.momofuku.com",
                imageURL: "momofuku_ko",
                heroImageURL: "momofuku_ko_hero",
                hours: [
                    "Monday": "Closed",
                    "Tuesday": "5:00 PM - 10:00 PM",
                    "Wednesday": "5:00 PM - 10:00 PM",
                    "Thursday": "5:00 PM - 10:00 PM",
                    "Friday": "5:00 PM - 10:30 PM",
                    "Saturday": "5:00 PM - 10:30 PM",
                    "Sunday": "5:00 PM - 9:00 PM"
                ],
                sourceReviews: [
                    SourceReview(id: UUID(), source: "Google", rawRating: 4.5, reviewCount: 892, url: nil),
                    SourceReview(id: UUID(), source: "Yelp", rawRating: 4.4, reviewCount: 623, url: nil),
                    SourceReview(id: UUID(), source: "NY Times", rawRating: 3.0, reviewCount: nil, url: nil)
                ],
                isFeatured: false,
                dateAdded: Date(),
                latitude: 40.7264,
                longitude: -73.9907
            ),

            // Brooklyn
            Restaurant(
                id: UUID(),
                name: "Peter Luger Steak House",
                cuisineType: "Steakhouse",
                borough: "Brooklyn",
                neighborhood: "Williamsburg",
                address: "178 Broadway, Brooklyn, NY 11211",
                phoneNumber: "7183877400",
                priceRange: 4,
                healthGrade: "A",
                menuURL: "https://peterluger.com/menu",
                websiteURL: "https://peterluger.com",
                imageURL: "peter_luger",
                heroImageURL: "peter_luger_hero",
                hours: [
                    "Monday": "11:45 AM - 9:45 PM",
                    "Tuesday": "11:45 AM - 9:45 PM",
                    "Wednesday": "11:45 AM - 9:45 PM",
                    "Thursday": "11:45 AM - 9:45 PM",
                    "Friday": "11:45 AM - 10:45 PM",
                    "Saturday": "11:45 AM - 10:45 PM",
                    "Sunday": "12:45 PM - 9:45 PM"
                ],
                sourceReviews: [
                    SourceReview(id: UUID(), source: "Google", rawRating: 4.5, reviewCount: 6234, url: nil),
                    SourceReview(id: UUID(), source: "Yelp", rawRating: 4.1, reviewCount: 4521, url: nil),
                    SourceReview(id: UUID(), source: "Foursquare", rawRating: 9.2, reviewCount: 2891, url: nil),
                    SourceReview(id: UUID(), source: "Zagat", rawRating: 3.5, reviewCount: nil, url: nil)
                ],
                isFeatured: true,
                dateAdded: Date(),
                latitude: 40.7098,
                longitude: -73.9624
            ),

            Restaurant(
                id: UUID(),
                name: "Lilia",
                cuisineType: "Italian",
                borough: "Brooklyn",
                neighborhood: "Williamsburg",
                address: "567 Union Ave, Brooklyn, NY 11211",
                phoneNumber: "7185765095",
                priceRange: 3,
                healthGrade: "A",
                menuURL: "https://lilianewyork.com/menu",
                websiteURL: "https://lilianewyork.com",
                imageURL: "lilia",
                heroImageURL: "lilia_hero",
                hours: [
                    "Monday": "Closed",
                    "Tuesday": "5:30 PM - 10:00 PM",
                    "Wednesday": "5:30 PM - 10:00 PM",
                    "Thursday": "5:30 PM - 10:00 PM",
                    "Friday": "5:30 PM - 11:00 PM",
                    "Saturday": "11:00 AM - 2:30 PM, 5:30 PM - 11:00 PM",
                    "Sunday": "11:00 AM - 2:30 PM, 5:00 PM - 9:00 PM"
                ],
                sourceReviews: [
                    SourceReview(id: UUID(), source: "Google", rawRating: 4.6, reviewCount: 1823, url: nil),
                    SourceReview(id: UUID(), source: "Yelp", rawRating: 4.5, reviewCount: 1456, url: nil),
                    SourceReview(id: UUID(), source: "NY Times", rawRating: 3.0, reviewCount: nil, url: nil)
                ],
                isFeatured: true,
                dateAdded: Date(),
                latitude: 40.7145,
                longitude: -73.9512
            ),

            Restaurant(
                id: UUID(),
                name: "Di Fara Pizza",
                cuisineType: "Pizza",
                borough: "Brooklyn",
                neighborhood: "Midwood",
                address: "1424 Avenue J, Brooklyn, NY 11230",
                phoneNumber: "7182581367",
                priceRange: 2,
                healthGrade: "A",
                menuURL: "https://www.difarapizza.com/menu",
                websiteURL: "https://www.difarapizza.com",
                imageURL: "difara",
                heroImageURL: "difara_hero",
                hours: [
                    "Monday": "Closed",
                    "Tuesday": "Closed",
                    "Wednesday": "12:00 PM - 4:00 PM",
                    "Thursday": "12:00 PM - 4:00 PM",
                    "Friday": "12:00 PM - 4:00 PM",
                    "Saturday": "12:00 PM - 4:00 PM",
                    "Sunday": "1:00 PM - 4:00 PM"
                ],
                sourceReviews: [
                    SourceReview(id: UUID(), source: "Google", rawRating: 4.4, reviewCount: 2341, url: nil),
                    SourceReview(id: UUID(), source: "Yelp", rawRating: 4.2, reviewCount: 1892, url: nil),
                    SourceReview(id: UUID(), source: "Foursquare", rawRating: 9.1, reviewCount: 1234, url: nil)
                ],
                isFeatured: false,
                dateAdded: Date(),
                latitude: 40.6250,
                longitude: -73.9615
            ),

            // Queens
            Restaurant(
                id: UUID(),
                name: "Sripraphai",
                cuisineType: "Thai",
                borough: "Queens",
                neighborhood: "Woodside",
                address: "64-13 39th Ave, Woodside, NY 11377",
                phoneNumber: "7188991599",
                priceRange: 2,
                healthGrade: "A",
                menuURL: "https://sripraphairestaurant.com/menu",
                websiteURL: "https://sripraphairestaurant.com",
                imageURL: "sripraphai",
                heroImageURL: "sripraphai_hero",
                hours: [
                    "Monday": "Closed",
                    "Tuesday": "11:30 AM - 9:30 PM",
                    "Wednesday": "11:30 AM - 9:30 PM",
                    "Thursday": "11:30 AM - 9:30 PM",
                    "Friday": "11:30 AM - 10:00 PM",
                    "Saturday": "11:30 AM - 10:00 PM",
                    "Sunday": "11:30 AM - 9:30 PM"
                ],
                sourceReviews: [
                    SourceReview(id: UUID(), source: "Google", rawRating: 4.5, reviewCount: 3421, url: nil),
                    SourceReview(id: UUID(), source: "Yelp", rawRating: 4.3, reviewCount: 2891, url: nil),
                    SourceReview(id: UUID(), source: "Foursquare", rawRating: 9.0, reviewCount: 1567, url: nil)
                ],
                isFeatured: true,
                dateAdded: Date(),
                latitude: 40.7441,
                longitude: -73.9059
            ),

            Restaurant(
                id: UUID(),
                name: "M. Wells Steakhouse",
                cuisineType: "Steakhouse",
                borough: "Queens",
                neighborhood: "Long Island City",
                address: "43-15 Crescent St, Long Island City, NY 11101",
                phoneNumber: "7187868060",
                priceRange: 3,
                healthGrade: "A",
                menuURL: "https://magasinwells.com/steakhouse",
                websiteURL: "https://magasinwells.com",
                imageURL: "mwells",
                heroImageURL: "mwells_hero",
                hours: [
                    "Monday": "Closed",
                    "Tuesday": "Closed",
                    "Wednesday": "5:30 PM - 10:00 PM",
                    "Thursday": "5:30 PM - 10:00 PM",
                    "Friday": "5:30 PM - 11:00 PM",
                    "Saturday": "11:00 AM - 3:00 PM, 5:30 PM - 11:00 PM",
                    "Sunday": "11:00 AM - 3:00 PM, 5:30 PM - 9:00 PM"
                ],
                sourceReviews: [
                    SourceReview(id: UUID(), source: "Google", rawRating: 4.4, reviewCount: 892, url: nil),
                    SourceReview(id: UUID(), source: "Yelp", rawRating: 4.2, reviewCount: 756, url: nil),
                    SourceReview(id: UUID(), source: "NY Times", rawRating: 2.0, reviewCount: nil, url: nil)
                ],
                isFeatured: false,
                dateAdded: Date(),
                latitude: 40.7475,
                longitude: -73.9465
            ),

            Restaurant(
                id: UUID(),
                name: "Hunan Kitchen of Grand Sichuan",
                cuisineType: "Chinese",
                borough: "Queens",
                neighborhood: "Flushing",
                address: "42-47 Main St, Flushing, NY 11355",
                phoneNumber: "7188885553",
                priceRange: 2,
                healthGrade: "A",
                menuURL: "https://www.hunankitchenofgrandsichuan.com/menu",
                websiteURL: "https://www.hunankitchenofgrandsichuan.com",
                imageURL: "hunan_kitchen",
                heroImageURL: "hunan_kitchen_hero",
                hours: [
                    "Monday": "11:00 AM - 10:00 PM",
                    "Tuesday": "11:00 AM - 10:00 PM",
                    "Wednesday": "11:00 AM - 10:00 PM",
                    "Thursday": "11:00 AM - 10:00 PM",
                    "Friday": "11:00 AM - 10:30 PM",
                    "Saturday": "11:00 AM - 10:30 PM",
                    "Sunday": "11:00 AM - 10:00 PM"
                ],
                sourceReviews: [
                    SourceReview(id: UUID(), source: "Google", rawRating: 4.3, reviewCount: 1234, url: nil),
                    SourceReview(id: UUID(), source: "Yelp", rawRating: 4.1, reviewCount: 892, url: nil),
                    SourceReview(id: UUID(), source: "Foursquare", rawRating: 8.8, reviewCount: 567, url: nil)
                ],
                isFeatured: false,
                dateAdded: Date(),
                latitude: 40.7580,
                longitude: -73.8306
            )
        ]
    }

    func getRestaurants(for borough: Borough) -> [Restaurant] {
        return getRestaurants().filter { $0.borough == borough.rawValue }
    }

    func getFeaturedRestaurants() -> [Restaurant] {
        return getRestaurants().filter { $0.isFeatured }
    }

    func searchRestaurants(query: String) -> [Restaurant] {
        let lowercasedQuery = query.lowercased()
        return getRestaurants().filter {
            $0.name.lowercased().contains(lowercasedQuery) ||
            $0.cuisineType.lowercased().contains(lowercasedQuery) ||
            $0.neighborhood.lowercased().contains(lowercasedQuery)
        }
    }
}
