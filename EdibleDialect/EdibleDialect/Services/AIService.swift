import Foundation

class AIService {
    static let shared = AIService()

    private let apiKey = Config.anthropicAPIKey
    private let apiURL = "https://api.anthropic.com/v1/messages"

    private init() {}

    func generateRestaurantBlurb(for restaurant: Restaurant) async throws -> String {
        let prompt = buildPrompt(for: restaurant)

        let requestBody: [String: Any] = [
            "model": "claude-sonnet-4-20250514",
            "max_tokens": 150,
            "messages": [
                ["role": "user", "content": prompt]
            ]
        ]

        guard let url = URL(string: apiURL) else {
            throw AIServiceError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.setValue("2023-06-01", forHTTPHeaderField: "anthropic-version")
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw AIServiceError.invalidResponse
        }

        guard httpResponse.statusCode == 200 else {
            throw AIServiceError.apiError(statusCode: httpResponse.statusCode)
        }

        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]

        guard let content = json?["content"] as? [[String: Any]],
              let firstBlock = content.first,
              let text = firstBlock["text"] as? String else {
            throw AIServiceError.parsingError
        }

        return text
    }

    func sendExperienceChat(messages: [[String: String]]) async throws -> String {
        let restaurants = MockDataService.shared.getRestaurants()
        let restaurantContext = restaurants.map { r in
            "\(r.name) — \(r.cuisineType), \(r.neighborhood) (\(r.borough)), \(r.priceRangeEnum.displayString), Score: \(r.edibleScore)/100"
        }.joined(separator: "\n")

        let systemPrompt = """
        You are the Edible Dialect concierge — a friendly, knowledgeable NYC food expert who curates dining experiences. \
        You help users plan outings like date nights, bar crawls, dinner and a movie, birthday dinners, group outings, and more.

        You have access to these restaurants:
        \(restaurantContext)

        Guidelines:
        - Recommend from the restaurants above when possible, but you can also suggest general NYC tips
        - Be warm, concise, and specific — give a mini-plan, not just a list
        - Include why each pick fits the vibe they're going for
        - Keep responses to 3-4 short paragraphs max
        - If they haven't specified what they want, ask what kind of experience they're looking for
        """

        var apiMessages: [[String: String]] = []
        for msg in messages {
            apiMessages.append(msg)
        }

        let requestBody: [String: Any] = [
            "model": "claude-sonnet-4-20250514",
            "max_tokens": 600,
            "system": systemPrompt,
            "messages": apiMessages
        ]

        guard let url = URL(string: apiURL) else {
            throw AIServiceError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.setValue("2023-06-01", forHTTPHeaderField: "anthropic-version")
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw AIServiceError.invalidResponse
        }

        guard httpResponse.statusCode == 200 else {
            throw AIServiceError.apiError(statusCode: httpResponse.statusCode)
        }

        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]

        guard let content = json?["content"] as? [[String: Any]],
              let firstBlock = content.first,
              let text = firstBlock["text"] as? String else {
            throw AIServiceError.parsingError
        }

        return text
    }

    private func buildPrompt(for restaurant: Restaurant) -> String {
        let priceDescription: String
        switch restaurant.priceRangeEnum {
        case .budget: priceDescription = "budget-friendly"
        case .moderate: priceDescription = "moderately priced"
        case .upscale: priceDescription = "upscale"
        case .fineDining: priceDescription = "fine dining"
        }

        return """
        Write a brief, enticing 2-sentence review blurb for this restaurant. Be specific and vivid, as if you're a local food critic. Don't use generic phrases.

        Restaurant: \(restaurant.name)
        Cuisine: \(restaurant.cuisineType)
        Neighborhood: \(restaurant.neighborhood), \(restaurant.borough)
        Price: \(priceDescription)
        Edible Score: \(restaurant.edibleScore)/100

        Just provide the 2-sentence blurb, nothing else.
        """
    }
}

enum AIServiceError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case apiError(statusCode: Int)
    case parsingError

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid API URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .apiError(let statusCode):
            return "API error with status code: \(statusCode)"
        case .parsingError:
            return "Failed to parse response"
        }
    }
}
