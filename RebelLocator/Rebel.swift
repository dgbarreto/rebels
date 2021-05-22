//
//  Rebel.swift
//  RebelLocator
//
//  Created by Danilo Barreto on 22/05/21.
//  Copyright © 2021 Danilo Barreto. All rights reserved.
//

import Foundation

struct Rebel: Codable{
    var name: String
    var bioURL: URL
    
    enum CodingKeys: String, CodingKey{
        case name, bioURL = "url"
    }
}
