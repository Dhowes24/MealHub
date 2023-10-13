//
//  MenuViewModel.swift
//  Food@Home
//
//  Created by Derek Howes on 10/5/23.
//

import Foundation

extension MenuView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var recipes = [Recipe]()
        
        private lazy var downloadSession: URLSession = {
            let configuration = URLSessionConfiguration.default
            return URLSession(configuration: configuration, delegate: nil, delegateQueue: .main)
        }()
        
        func fetchRecipes() async throws {
            let request = NSMutableURLRequest(url: NSURL(string: searchRecipes)! as URL,
                                                    cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers

            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    print(error as Any)
                } else {
                    if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data!) {
                        Task {
                            await MainActor.run {
                                self.recipes = decodedResponse.results
                            }
                        }
                    } else {
                        print("Bad decode")
                    }
                }
            })

            dataTask.resume()
        }
    }
}
