//
//  NumberGeneratorTaskModifer.swift
//  TasksAndGroups
//
//  Created by Brandon Johns on 12/29/23.
//

import SwiftUI

struct NumberGenerator: AsyncSequence, AsyncIteratorProtocol {
    typealias Element = Int
    let delay: Double
    let range: ClosedRange<Int>
    
    init(in range: ClosedRange<Int>, delay: Double = 1) {
        self.delay = delay
        self.range = range
    }
    
    mutating func next() async -> Int? {
         // Make sure we stop emitting numbers when our task is cancelled
         while Task.isCancelled == false {
             try? await Task.sleep(nanoseconds: UInt64(delay) * 1_000_000_000)
             print("Generating number")
             return Int.random(in: range)
         }

         return nil
     }

     func makeAsyncIterator() -> NumberGenerator {
         self
     }
}

struct NumberGeneratorTaskModifer: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: DetailView()) {
                Text("Start Generating Numbers")
            }
        }
    }
}

struct DetailView: View {
    @State private var numbers = [String]()
    let generator = NumberGenerator(in: 1...100)
    
    var body: some View {
        List(numbers, id: \.self, rowContent: Text.init)
            .task {
                await generateNumbers()
            }
    }
    
    func generateNumbers() async {
        for await number in generator {
            numbers.insert("\(numbers.count + 1). \(number)", at: 0)
        }
    }
}

#Preview {
    NumberGeneratorTaskModifer()
}
