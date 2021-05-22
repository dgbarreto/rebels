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

    func fetchRebels(){
//        var baseURL = URL(string: baseURLString)
//        var composedURL = URL(string: "/rebels", relativeTo: baseURL)
//
//        print(baseURL!)
//        print(composedURL?.absoluteString ?? "Erro no unwrap da URL")
        
        var componentURL = URLComponents()
        componentURL.scheme = "https"
        componentURL.host = "rebel-api.azure-api.net"
        componentURL.path = "/rebels"
        
        print(componentURL.url!)
    }
}
