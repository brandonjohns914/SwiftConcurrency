//
//  HowToCallAsyncFunctionUsingAsyncLet.swift
//  SwiftConcurrencyByExample
//
//  Created by Brandon Johns on 12/27/23.
//

import SwiftUI

struct User: Decodable {
    let id: UUID
    let name: String
    let age: Int
}

func loadData() async {
    async let (userData, _) = URLSession.shared.data(from: URL(string: "https://hws.dev/user-24601.json")!)

      async let (messageData, _) = URLSession.shared.data(from: URL(string: "https://hws.dev/user-messages.json")!)

    do {
           let decoder = JSONDecoder()
           let user = try await decoder.decode(User.self, from: userData)
           let messages = try await decoder.decode([Message].self, from: messageData)
           print("User \(user.name) has \(messages.count) message(s).")
       } catch {
           print("Sorry, there was a network problem.")
       }
}

func fetchFavorites(for user: User) async -> [Int] {
    print("Fetching favorites for \(user.name)…")

    do {
        async let (favorites, _) = URLSession.shared.data(from: URL(string: "https://hws.dev/user-favorites.json")!)
        return try await JSONDecoder().decode([Int].self, from: favorites)
    } catch {
        return []
    }
}

struct HowToCallAsyncFunctionUsingAsyncLet: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    HowToCallAsyncFunctionUsingAsyncLet()
}
