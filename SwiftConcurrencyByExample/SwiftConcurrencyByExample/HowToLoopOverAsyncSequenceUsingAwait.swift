//
//  HowToLoopOverAsyncSequenceUsingAwait.swift
//  SwiftConcurrencyByExample
//
//  Created by Brandon Johns on 12/28/23.
//

import SwiftUI

class LoopAsyncSequenceAwait {
    func fetchUsers() async throws {
        let url = URL(string: "https://hws.dev/users.csv")!

        for try await line in url.lines {
            print("Received user: \(line)")
        }
    }

    //try? await fetchUsers()
    func printUsers() async throws {
        let url = URL(string: "https://hws.dev/users.csv")!

        var iterator = url.lines.makeAsyncIterator()

        if let line = try await iterator.next() {
            print("The first user is \(line)")
        }

        for i in 2...5 {
            if let line = try await iterator.next() {
                print("User #\(i): \(line)")
            }
        }

        var remainingResults = [String]()

        while let result = try await iterator.next() {
            remainingResults.append(result)
        }

        print("There were \(remainingResults.count) other users.")
    }

    //try? await printUsers()
}

struct HowToLoopOverAsyncSequenceUsingAwait: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    HowToLoopOverAsyncSequenceUsingAwait()
}
