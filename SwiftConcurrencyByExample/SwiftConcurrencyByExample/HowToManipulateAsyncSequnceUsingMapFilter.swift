//
//  HowToManipulateAsyncSequnceUsingMapFilter.swift
//  SwiftConcurrencyByExample
//
//  Created by Brandon Johns on 12/28/23.
//

import SwiftUI

class AsyncSequnceMapFilter {
    func shoutQuotes() async throws {
        let url = URL(string: "https://hws.dev/quotes.txt")!
        let uppercaseLines = url.lines.map(\.localizedUppercase)

        for try await line in uppercaseLines {
            print(line)
        }
    }

   // try? await shoutQuotes()
    
    struct Quote {
        let text: String
    }

    func printQuotes() async throws {
        let url = URL(string: "https://hws.dev/quotes.txt")!

        let quotes = url.lines.map(Quote.init)

        for try await quote in quotes {
            print(quote.text)
        }
    }

    //try? await printQuotes()
    
    func printAnonymousQuotes() async throws {
        let url = URL(string: "https://hws.dev/quotes.txt")!
        let anonymousQuotes = url.lines.filter { $0.contains("Anonymous") }

        for try await line in anonymousQuotes {
            print(line)
        }
    }
    //try? await printAnonymousQuotes()
    
    func printTopQuotes() async throws {
        let url = URL(string: "https://hws.dev/quotes.txt")!
        let topQuotes = url.lines.prefix(5)

        for try await line in topQuotes {
            print(line)
        }
    }

    //try? await printTopQuotes()
    
    func printAllQuotes() async throws {
        let url = URL(string: "https://hws.dev/quotes.txt")!

        let anonymousQuotes = url.lines.filter { $0.contains("Anonymous") }
        let topAnonymousQuotes = anonymousQuotes.prefix(5)
        let shoutingTopAnonymousQuotes = topAnonymousQuotes.map(\.localizedUppercase)

        for try await line in shoutingTopAnonymousQuotes {
            print(line)
        }
    }

    //try? await printAllQuotes()
}



struct HowToManipulateAsyncSequnceUsingMapFilter: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    HowToManipulateAsyncSequnceUsingMapFilter()
}
