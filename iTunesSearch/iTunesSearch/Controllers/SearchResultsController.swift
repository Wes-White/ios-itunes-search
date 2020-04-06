//
//  SearchResultsController.swift
//  iTunesSearch
//
//  Created by Wesley Ryan on 4/5/20.
//  Copyright © 2020 Wesley Ryan. All rights reserved.
//

import Foundation

final class SearchResultsController {
    
    enum HTTPMethod: String {
           case get = "GET"
           case put = "PUT"
           case post = "POST"
           case delete = "DELETE"
       }
    
    var fromITunesResult: [SearchResult] = []
    
    private let baseURL = URL(string: "https://itunes.apple.com/search")!
    private var task: URLSessionTask?
   
    
    
//  Search Method
    
    func performSearch (searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        task?.cancel()
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let searchQueryTerm = URLQueryItem(name: "search", value: searchTerm)
        //NOT SURE WHAT THIS IS DOING
        urlComponents?.queryItems = [searchQueryTerm]
        
        //Make sure something is there
        guard let requestURL = urlComponents?.url else {
            NSLog("The Request returned nil")
            completion(NSError())
            return
        }
        
        //setting our get request
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        
        task = URLSession.shared.dataTask(with: request) { [weak self ] data, _, error in
            if let error = error {
                NSLog("There was an error fetching the data: \(error) -- \(error.localizedDescription)")
                return
            }
            
            guard let self = self else { return }
           // if our data is nil exit the closure
            guard let data = data else {
                NSLog("There was no Data returned from the running task")
                return
            }
            
            // Decode and display our data
            
            let jsonDecoder = JSONDecoder()
            
            do{
                let iTunesSearch = try
                jsonDecoder.decode(iTunesResult.self, from: data)
                //set our array with the decoded data.
                self.fromITunesResult = iTunesSearch.results
            } catch {
                NSLog("Unable to decode the data into an instance of iTunesSearch: \(error.localizedDescription)")
            }
            
            completion(NSError())
        }
        
        task?.resume()
    
    }
}
