//
//  modeloDados.swift
//  AgendaDigital
//
//  Created by Anderson Alencar on 13/03/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//

import Foundation

struct Note {
    var date: DateComponents
    var description: String
    var duration: DateComponents
    var category: Categories
    var status: Bool
}

enum Categories {
    case study
    case personal
    case finances
}
