//
//  HowToCreateCustomAsyncSequence.swift
//  SwiftConcurrencyByExample
//
//  Created by Brandon Johns on 12/28/23.
//

import SwiftUI

struct DoubleGenerator: AsyncSequence, AsyncIteratorProtocol {
    typealias Element = Int
    
    var current = 1
    
    mutating func next() async -> Element? {
        defer { current &*= 2 }
        if current < 0 {
            return nil
        } else {
            return current
        }
    }
    
    func makeAsyncIterator() -> DoubleGenerator {
        self
    }
}

//let sequence = DoubleGenerator()
//
//for await number in sequence {
//    print(number)
//}


struct HowToCreateCustomAsyncSequence: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    HowToCreateCustomAsyncSequence()
}
