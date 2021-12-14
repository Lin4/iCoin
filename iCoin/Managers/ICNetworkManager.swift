//
//  NetworkManager.swift
//  iCoin
//
//  Created by Lingeswaran Kandasamy on 12/13/21.
//

import Foundation
import Combine

class ICNetworkManager {

    enum ErrorMassage: LocalizedError {
        case invalidURLResponse(url: URL)
        case unknownError
        
        var errorDescription: String? {
            
            switch self {
            case .invalidURLResponse(let url):
                return "invalid response from the server. Please try again.\(url)"
            case .unknownError:
                return "Something went WRONG"
            }
            
        }
        
    }
    
    
    
    static func getData(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ try handleResponseData(output: $0, url: url) })
            .retry(3)
            .eraseToAnyPublisher()
    }
    
    
    static func handleResponseData(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw ErrorMassage.invalidURLResponse(url: url)
        }
        return output.data
    }
    
    
    
    static func completionHandler(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
