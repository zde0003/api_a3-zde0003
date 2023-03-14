//
//  WeatherViewModel.swift
//  Assignment3
//
//  Created by Zach Evetts on 3/14/23.
//

import Foundation

class ParksViewModel : ObservableObject {
    
    @Published private(set) var parksData = [WeatherModel]()
    @Published var hasError = false
    @Published var error : WeatherModelError?
    private let url = "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current_weather=true&hourly=temperature_2m,relativehumidity_2m,windspeed_10m"

    @MainActor
    func fetchData() async {
        if let url = URL(string: url) {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                guard let results = try JSONDecoder().decode(ParkResults?.self, from: data) else {
                    self.hasError.toggle()
                    self.error = ParkModelError.decodeError
                    return
                }
                self.parksData = results.data
            } catch {
                self.hasError.toggle()
                self.error = ParkModelError.customError(error: error)
            }
        }
    }
}

extension ParksViewModel {
    enum ParkModelError : LocalizedError {
        case decodeError
        case customError(error: Error)
        
        var errorDescription: String? {
            switch self {
            case .decodeError:
                return "Decoding Error"
            case .customError(let error):
                return error.localizedDescription
            }
        }
        
    }

}
