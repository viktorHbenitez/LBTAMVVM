//
//  Service.swift
//  MVC
//
//  Created by Brian Voong on 6/30/18.
//  Copyright © 2018 Brian Voong. All rights reserved.
//

import Foundation

class Service: NSObject {
    static let shared = Service()
    
    func fetchCourses(completion: @escaping ([Course]?, Error?) -> ()) {
        let urlString = "https://api.letsbuildthatapp.com/jsondecodable/courses"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                print("Failed to fetch courses:", err)
                return
            }
            
            // check response
            
            guard let data = data else { return }
            do {
                let courses = try JSONDecoder().decode([Course].self, from: data)
                DispatchQueue.main.async {
                    completion(courses, nil)
                }
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
            }.resume()
    }
}
