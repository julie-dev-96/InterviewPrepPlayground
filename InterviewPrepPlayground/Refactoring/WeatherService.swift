
//
//  WeatherService.swift
//  InterviewPrep
//
//  Created by Julie Childress on 6/21/25.
//

// CHATGPT: https://chatgpt.com/share/685710f4-28e4-8009-a13a-c63acf58ff5e

import Foundation

protocol WeatherFetching {
    func fetchWeather(
        for city: String
    ) async throws -> Weather
}

class WeatherService {
    private let urlSession: URLSession
    private let config: WeatherServiceConfig

    struct WeatherServiceConfig {
        let apiKey: String
    }

    private enum Endpoint {
        static var baseFetchWeatherURLString: String { "https://api.weatherapi.com/v1/current.json" }
    }

    private enum QueryKey {
        static var apiKey: String { "key" }
        static var city: String { "q" }
    }

    private var apiKeyQueryItem: URLQueryItem {
        .init(
            name: QueryKey.apiKey,
            value: config.apiKey
        )
    }

    init(
        urlSession: URLSession = URLSession.shared,
        config: WeatherServiceConfig
    ) {
        self.urlSession = urlSession
        self.config = config
    }
}

extension WeatherService: WeatherFetching {
    func fetchWeather(
        for city: String
    ) async throws -> Weather {
        guard let baseURL = URL(string: Endpoint.baseFetchWeatherURLString) else {
            throw FetchWeatherError.invalidURL
        }

        let cityQueryItem: URLQueryItem = .init(
            name: QueryKey.city,
            value: city
        )
        let url = baseURL.appending(
            queryItems: [
                apiKeyQueryItem,
                cityQueryItem
            ]
        )
        let urlRequest = URLRequest(url: url)

        let (data, response) = try await urlSession.data(for: urlRequest)
        guard !data.isEmpty else {
            throw FetchWeatherError.emptyData
        }

        guard let weather = try? JSONDecoder().decode(CurrentWeatherResponse.self, from: data) else {
            throw FetchWeatherError.parsingError
        }

        return weather.toSummary
    }
}

struct Weather {
    let temperature: Double
}

struct CurrentWeatherResponse: Decodable {
    let current: TemperatureResponse

    var toSummary: Weather {
        .init(temperature: current.tempInCelsius)
    }
}

struct TemperatureResponse: Decodable {
    let tempInCelsius: Double

    enum CodingKeys: String, CodingKey {
        case tempInCelsius = "temp_c"
    }
}

enum FetchWeatherError: Error {
    case invalidURL
    case apiError(Error)
    case emptyData
    case parsingError
}
