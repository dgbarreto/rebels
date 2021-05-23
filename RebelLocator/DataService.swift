//
//  DataService.swift
//  RebelLocator
//
//  Created by Danilo Barreto on 22/05/21.
//  Copyright © 2021 Danilo Barreto. All rights reserved.
//

import Foundation

class DataService{
    static let shared = DataService()
    fileprivate let baseURLString = "https://rebel-api.azure-api.net/"

    func fetchRebels(completion : @escaping(Result<[Rebel], Error>) -> Void){
//        var baseURL = URL(string: baseURLString)
//        var composedURL = URL(string: "/rebels", relativeTo: baseURL)
//
//        print(baseURL!)
//        print(composedURL?.absoluteString ?? "Erro no unwrap da URL")

        let componentURL = createUrlComponents(path: "/rebels")
        
        guard let validURL = componentURL.url else {
            print("URL mal formada")
            return
        }

        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse{
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do{
//                let json = try JSONSerialization.jsonObject(with: validData, options: [])
                let rebels = try JSONDecoder().decode([Rebel].self, from: validData)
                completion(.success(rebels))
            } catch let serializationError {
                completion(.failure(serializationError))
            }
            
        }.resume()
    }
    
    func createNewAlert(alert: Alert, completion: @escaping(Result<Any, Error>)->Void){
        let postComponents = createUrlComponents(path: "/alerts")
        
        guard let composedURL = postComponents.url else {
            print("Erro ao definir url");
            return
        }
        
        var postRequest = URLRequest(url: composedURL)
        postRequest.httpMethod = "POST"
        
        let authString = "Vader:V@d3r"
        var authStringBase64 = ""
        
        if let authData = authString.data(using: .utf8){
            authStringBase64 = authData.base64EncodedString()
        }
        
        do{
            let alertData = try JSONEncoder().encode(alert)
            postRequest.httpBody = alertData
        } catch {
            print("Erro ao fazer encodingo do alerta")
        }
        
        postRequest.setValue("Basic \(authStringBase64)", forHTTPHeaderField: "Authorization")
        postRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        postRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: postRequest) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse{
                print("Status code \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do{
                let json = try JSONSerialization.jsonObject(with: validData, options: [])
                completion(.success(json))
            } catch let serializationDataError{
                completion(.failure(serializationDataError))
            }
        }.resume()
    }
    
    func createUrlComponents(path: String) -> URLComponents{
        var componentURL = URLComponents()
        componentURL.scheme = "https"
        componentURL.host = "rebel-api.azure-api.net"
        componentURL.path = path
        
        return componentURL;
    }

}
