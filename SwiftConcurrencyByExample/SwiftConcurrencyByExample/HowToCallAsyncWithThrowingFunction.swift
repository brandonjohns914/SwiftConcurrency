//
//  HowToCallAsyncWithThrowingFunction.swift
//  SwiftConcurrencyByExample
//
//  Created by Brandon Johns on 12/27/23.
//

import Foundation
import SwiftUI


func fetchFavorites() async throws -> [Int] {
    let url = URL(string: "https://hws.dev/user-favorites.json")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Int].self, from: data)
}

func callingFavorites() async {
    if let favorites = try? await fetchFavorites() {
        print("fetched \(favorites.count) favorites")
    } else {
        print("Failed to fetch favorites")
    }
}
