//
//  HowTocreateContinuationsThatThrowsErrors.swift
//  SwiftConcurrencyByExample
//
//  Created by Brandon Johns on 12/27/23.
//

import SwiftUI


func fetchMessagesThrowing(completion: @escaping ([Message]) -> Void) {
    let url = URL(string: "https://hws.dev/user-messages.json")!

    URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {
            if let messages = try? JSONDecoder().decode([Message].self, from: data) {
                completion(messages)
                return
            }
        }

        completion([])
    }.resume()
}

// An example error we can throw
enum FetchError: Error {
    case noMessages
}

func fetchMessagesThrowing() async -> [Message] {
    do {
        return try await withCheckedThrowingContinuation { continuation in
            fetchMessages { messages in
                if messages.isEmpty {
                    continuation.resume(throwing: FetchError.noMessages)
                } else {
                    continuation.resume(returning: messages)
                }
            }
        }
    } catch {
        return [
            Message(id: 1, user: "Tom", text: "Welcome to MySpace! I'm your new friend.")
        ]
    }
}
struct HowTocreateContinuationsThatThrowsErrors: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    HowTocreateContinuationsThatThrowsErrors()
}
