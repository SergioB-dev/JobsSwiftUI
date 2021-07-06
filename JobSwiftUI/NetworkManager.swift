//
//  NetworkManager.swift
//  JobSwiftUI
//
//  Created by Sergio Bost on 7/3/21.
//

import Foundation

final class NetworkManager: ObservableObject {
    @Published var applications = [Application]()
    var appStatus: AppStatus = .testing
    
    
    private var baseURL: String {
        switch appStatus {
        case .production:
            return "apple.com"
        case .testing:
            return "http://192.168.1.250:8080/applications"
        }
    }
    
    func getAllApplications(result: @escaping ((Result<[Application], JobError>) -> Void)) {
        let task = URLSession.shared.dataTask(with: URL(string: baseURL)!) { data, _, error in
            guard error == nil else { return }
            if let data = data {
                do {
                    let loadedApps = try JSONDecoder().decode([Application].self, from: data)
                    result(.success(loadedApps))
                    print(loadedApps)
                } catch let error {
                    print(error)
                    result(.failure(.badSignal))
                }
            }
        }
        task.resume()
    }
    
    func deleteApplication(appID: String, completion: @escaping () -> Void) {
        let url = URL(string: baseURL + "/\(appID)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        let task = URLSession.shared.dataTask(with: request){ _, response, error in
            guard error == nil else { return }
            guard let response = response as? HTTPURLResponse else {
                print("Error in deleting application with ID: \(appID)")
                return
            }
            completion()

        }
        task.resume()
    }
    
    func postApplication(company: String, position:
                         String, hiringManager: String,
                         type: String) {
        
        let postable = Application(company: company, position: position, hiringManager: hiringManager, type: type)
        var request = URLRequest(url: URL(string: baseURL)!)
        request.allHTTPHeaderFields = ["Content-Type":"application/json",
                                       "Connection" : "keep-alive"
        ]
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONEncoder().encode(postable)
            
        } catch let error {
            print(error)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else { print (error!) ; return }
            if let response = response {
                print(response)
            }
            if let data = data {
                print(data)
            }
        }
        task.resume()
        
    }
    
    
    
}

enum JobError: Error {
    case badSignal
}

enum AppStatus {
    case production
    case testing
}

struct Application: Codable, Hashable, Identifiable {
    var id: String?
    let company: String
    let position: String
    let hiringManager: String
    let type: String
}
