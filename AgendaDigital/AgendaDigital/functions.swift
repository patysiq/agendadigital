//
//  functions.swift
//  AgendaDigital
//
//  Created by Anderson Alencar on 13/03/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//

import Foundation


//Register Functions
func register() -> Note? {
    
    var dateNote = DateComponents()
    var descriptionNote: String
    var durationNote = DateComponents()
    var categoryNote: Categories
    var statusNote: Bool
    
    dateNote = getDate()
    descriptionNote = getDescription()
    durationNote = getDuration()
    categoryNote = getCategory()
    statusNote = getStatusNote()
    
    let note = Note(date: dateNote, description: descriptionNote, duration: durationNote, category: categoryNote, status: statusNote)
    return note
}



func getDate() -> DateComponents{

    var responseDate = DateComponents()
    var response: String?
    
    while responseDate.day == nil {
        print("Digite a data do compromisso (xx/xx/xxxx):",terminator: " ")
        response = readLine()
        let date = response?.split(separator: "/")

        if let date = date {
            if let day  = Int(date[0]), let month = Int(date[1]), let year = Int(date[2]) {
                responseDate.day = day
                responseDate.month = month
                responseDate.year = year
            } else {
                print("\nEntrada Inválida\n")
                continue
            }
        }
    }
    
    while responseDate.hour == nil {
        print("Digite o horário do seu compromisso (hh:mm):",terminator: " ")
        response = readLine()
        let schedule = response?.split(separator: ":")
        if let schedule = schedule {
            if let hour = Int(schedule[0]), let minute = Int(schedule[1]) {
                responseDate.minute = minute
                responseDate.hour = hour
            } else {
                print("\nEntrada Inválida\n")
                continue
            }
        }
    }
    return responseDate
}

//decrição deve ser opcional
func getDescription() -> String{
    
    while true {
        print("Digite a descrição do seu comprimisso: ",terminator : " ")
        let response = readLine()
        if let response = response {
            return response
        }
    }
}

func getDuration() -> DateComponents{

    var date = DateComponents()
    
    while true {
        print("Digite a duração do seu compromisso (hh:mm):",terminator: " ")
        let response = readLine()
        let schedule = response?.split(separator: ":")
        
        if let schedule = schedule {
            if let hour = Int(schedule[0]), let minute = Int(schedule[1]) {
                date.hour = hour
                date.minute = minute
            } else {
                print("\nEntrada Inválida\n")
                continue
            }
            return date
        }
    }
}


//requisitar a categoria a qual o compromisso pertence
func getCategory() -> Categories{
    
    while true {
        print("A qual categoria pertence seu compromisso: ")
        print("1 - Estudos:                               ")
        print("2 - Pessoal:                               ")
        print("3 - Finanças:                              ")
        print("categoria:", terminator: " ")
        let response  = readLine()
        if let response = response, let choice = Int(response) {
            switch choice {
              case 1:
                return Categories.study
              case 2:
                return Categories.personal
              case 3:
                return Categories.finances
              default:
                print("Entrada inválida ! \n")
            }
        }
    }
}

//Retorna se o compromisso é repetitivo, levando-se em conta inicialmente que ele se repete SEMANALMENTE
func getStatusNote() -> Bool{

    while true {
        print("Seu compromisso é semanal?")
        print("1 - Não")
        print("2 - Sim")
        print("repetir? ",terminator: " ")
        let response = readLine()
        if let response = response, let choice = Int(response) {
            if choice == 1 || choice == 2 {
                return choice == 1 ? false:true
            } else {
                print("\nEntrada Inválida ! \n")
                continue
            }
        } else {
            print("\nEntrada Inválida ! \n")
            continue
        }
    }
}


// Edit Note Functions

func listAndSelectNote(manager: PersistenceManager) -> Int? {
    let success = manager.loadNotes()
    
    if success {
        print("\n#          Compromissos          #")
        print("#        ---------------         #\n")

        for (index, note) in manager.notes.enumerated() {
            print("Compromisso: \(index+1) - \(note.date.day!)/\(note.date.month!)/\(note.date.year!) - \(note.date.hour!):\(note.date.minute!)")
            print("Description: \(note.description) \n")
        }
        while true {
            print("Digite o número do compromisso que deseja editar:",terminator: " ")
            let response = readLine()
            if let reponse = response, let choice = Int(reponse) {
                return choice-1
            } else {
                 print("Entrada inválida !")
                continue
            }
        }
    } else {
         return nil
    }
}

// Remove Note

func listAndRemoveNote(manager: PersistenceManager) -> Int? {
let success = manager.loadNotes()

if success {
    print("\n#          Compromissos          #")
    print("#        ---------------         #\n")

    for (index, note) in manager.notes.enumerated() {
        print("Compromisso: \(index+1) - \(note.date.day!)/\(note.date.month!)/\(note.date.year!) - \(note.date.hour!):\(note.date.minute!)")
        print("Description: \(note.description) \n")
    }
    while true {
        print("Digite o número do compromisso que deseja cancelar:",terminator: " ")
        let response = readLine()
        if let reponse = response, let choice = Int(reponse) {
            return choice-1
        } else {
             print("Entrada inválida !")
            continue
        }
    }
} else {
     return nil
}
    

}

