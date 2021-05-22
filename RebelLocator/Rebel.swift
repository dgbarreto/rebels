//
//  Rebel.swift
//  RebelLocator
//
//  Created by Danilo Barreto on 22/05/21.
//  Copyright © 2021 Danilo Barreto. All rights reserved.
//

import Foundation

struct Rebel: Encodable{
    var name: String
    var bioURL: URL?
    var birthYear: String
    
    enum CodingKeys: String, CodingKey{
        case name, bioURL = "url", birthYear = "birth_year"
    }

    func encode(to encoder: Encoder)throws{
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(birthYear, forKey: .birthYear)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(bioURL, forKey: .bioURL)
    }
}

extension Rebel: Decodable{
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.bioURL = try container.decode(URL.self, forKey: .bioURL)
        self.birthYear = try container.decodeIfPresent(String.self, forKey: .birthYear) ?? "????"
    }
}
