//
//  JokeService.swift
//  Scherzo
//
//  Created by Mike Shevelinsky on 06.01.2021.
//

import Foundation

final class JokeService {
    private let url = URL(string: "https://official-joke-api.appspot.com/random_joke")!
    private let session = URLSession(configuration: .default)

    func getJoke(completionHandler: @escaping (Joke?) -> Void) {
        let task = session.dataTask(with: url) { (data, resp, err) in
            guard let data = data else {
                completionHandler(nil)
                return
            }
            if let joke = try? JSONDecoder().decode(Joke.self, from: data) {
                completionHandler(joke) } else {
                completionHandler(nil)
            }
        }
        
        task.resume()
    }
}