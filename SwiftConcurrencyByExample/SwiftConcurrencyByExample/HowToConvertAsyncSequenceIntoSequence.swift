//
//  HowToConvertAsyncSequenceIntoSequence.swift
//  SwiftConcurrencyByExample
//
//  Created by Brandon Johns on 12/28/23.
//

import SwiftUI

extension AsyncSequence {
    func collect() async rethrows -> [Element] {
        try await reduce(into: [Element]()) { $0.append($1)}
    }
}

func getNumberArray() async throws -> [Int] {
    let url = URL(string: "https://hws.dev/random-numbers.txt")!
    let numbers = url.lines.compactMap(Int.init)
    return try await numbers.collect()
}

func convert() async {
    if let numbers = try? await getNumberArray() {
        for number in numbers {
            print(number)
        }
    }
}

struct HowToConvertAsyncSequenceIntoSequence: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    HowToConvertAsyncSequenceIntoSequence()
}
