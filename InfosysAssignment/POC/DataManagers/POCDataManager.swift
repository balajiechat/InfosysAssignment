//
//  POCDataManager.swift
//  InfosysAssignment
//
//  Created by Balaji S on 22/04/20.
//  Copyright © 2020 balaji. All rights reserved.
//

import UIKit

enum URLList: String {
    case baseURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
}

enum HeaderKeyField: String {
    case ContentType = "Content-Type"
}

enum HeaderValueField: String {
    case ContentType = "application/json"
}

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}

enum HttpMethod: String {
    case get
}

struct Resource<T: Codable> {
    let url: URL
    var httpMethod: HttpMethod = .get
    var body: Data? = nil

    init(url: URL) {
        self.url = url
    }
}

class POCDataManager {

    static func fetchDataFromServer<T>(resource: Resource<T>, completion: @escaping (Result<T,NetworkError>) -> Void) {
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue.uppercased()
        request.httpBody = resource.body
        request.addValue(HeaderValueField.ContentType.rawValue, forHTTPHeaderField: HeaderKeyField.ContentType.rawValue)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }

            do {
                guard let data = String(decoding: data, as: UTF8.self).data(using: .utf8) else { return }
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                print(error)
                completion(.failure(.decodingError))
            }

            }.resume()
    }
}
