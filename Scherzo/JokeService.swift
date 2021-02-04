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

    func getJoke(completionHandler: @escaping (ApiJoke?) -> Void) {
        let task = session.dataTask(with: url) { (data, _, _) in
            guard let data = data else {
                completionHandler(nil)
                return
            }
            if let joke = try? JSONDecoder().decode(ApiJoke.self, from: data) {
                completionHandler(joke) } else {
                completionHandler(nil)
            }
        }

        task.resume()
    }
}
