//
//  APIManager.swift
//  marvelComics
//
//  Created by Miguel Gomes on 27/12/17.
//  Copyright © 2017 Miguel Gomes. All rights reserved.
//

import Foundation

class APIManager {
    private let API_URL = "http://gateway.marvel.com/v1/public/comics"
    private let API_KEY = "476268019f66f6894a3242f9794017d0"
    private let API_TS = "1"
    private let API_HASH = "709f5bd3cc2192b8386fd097596ae269"
    
    let defaultSession = URLSession(configuration: .default)
    
    //var dataTask: URLSessionDataTask?
    
//    func createURLWithString(date: NSDate) -> NSURL? {
//        // TODO: implement
//    }
//
//    func createURLWithComponents(offset: Int) -> NSURL? {
//        // TODO: implement
//    }
    
    
    func getComicBooks(offset: Int, completion: @escaping ([ComicBook])->Void) {
        if var urlComponents = URLComponents(string: API_URL) {
            urlComponents.query = "ts=\(API_TS)&apikey=\(API_KEY)&hash=\(API_HASH)"
    
            guard let url = urlComponents.url else { return }

            let dataTask = defaultSession.dataTask(with: url) { data, response, error in
                if let error = error {
                    // TODO: Handle error
                    print("DataTask error: " + error.localizedDescription + "\n")
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    
                    var comics: [ComicBook] = []

                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let data = json?["data"] as? [String: Any], let results = data["results"] as? [[String: Any]] {
                            for result in results {
                                if let comic = ComicBook(json: result) {
                                    comics.append(comic)
                                }
                            }
                        }
                    }
            
                    DispatchQueue.main.async {
                        completion(comics)
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    func getComicResources(resourceURI: String, completion: @escaping (ComicResources)->Void) {
        if var urlComponents = URLComponents(string: resourceURI) {
            urlComponents.query = "ts=\(API_TS)&apikey=\(API_KEY)&hash=\(API_HASH)"
            
            guard let url = urlComponents.url else { return }
            
            let dataTask = defaultSession.dataTask(with: url) { data, response, error in
                if let error = error {
                    // TODO: Handle error
                    print("DataTask error: " + error.localizedDescription + "\n")
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let data = json?["data"] as? [String: Any], let results = data["results"] as? [[String: Any]] {
                            for result in results {
                                if let resources = ComicResources(json: result) {
                                    DispatchQueue.main.async {
                                        completion(resources)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            dataTask.resume()
        }
    }
}
