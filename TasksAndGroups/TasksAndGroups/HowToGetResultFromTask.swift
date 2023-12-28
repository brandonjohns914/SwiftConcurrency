//
//  HowToGetResultFromTask.swift
//  TasksAndGroups
//
//  Created by Brandon Johns on 12/28/23.
//

import SwiftUI

class ErrorStuff {
    enum LoadError: Error {
        case fetchFailed, decodeFailed
    }
    
    func fetchQuotes() async {
        let downloadTask = Task { () -> String in
            let url = URL(string: "https://hws.dev/quotes.txt")!
                    let data: Data

                    do {
                        (data, _) = try await URLSession.shared.data(from: url)
                    } catch {
                        throw LoadError.fetchFailed
                    }

                    if let string = String(data: data, encoding: .utf8) {
                        return string
                    } else {
                        throw LoadError.decodeFailed
                    }

        }
        
        func results() async {
            let result = await downloadTask.result

                do {
                    let string = try result.get()
                    print(string)
                } catch LoadError.fetchFailed {
                    print("Unable to fetch the quotes.")
                } catch LoadError.decodeFailed {
                    print("Unable to convert quotes to text.")
                } catch {
                    print("Unknown error.")
                }
        }
        
        func quotes() async {
            await fetchQuotes()
        }
    }
}

struct HowToGetResultFromTask: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    HowToGetResultFromTask()
}
