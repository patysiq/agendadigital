//
//  modeloDados.swift
//  AgendaDigital
//
//  Created by Anderson Alencar on 13/03/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//

import Foundation

struct Note: Codable {
    var date: DateComponents
    var description: String
    var duration: DateComponents
    var category: Categories
    var status: Bool
}

enum Categories: CaseIterable{
    case study
    case personal
    case finances
}

extension Categories: Codable {
    
    enum Key: CodingKey {
        case rawValue
    }
    
    enum CodingError: Error {
        case unknownValue
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let rawValue = try container.decode(Int.self, forKey: .rawValue)
        switch rawValue {
        case 0:
            self = .study
        case 1:
            self = .personal
        case 2:
            self = .finances
        default:
            throw CodingError.unknownValue
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        switch self {
        case .study:
            try container.encode(0, forKey: .rawValue)
        case .personal:
            try container.encode(1, forKey: .rawValue)
        case .finances:
            try container.encode(2, forKey: .rawValue)
        }
    }
}
