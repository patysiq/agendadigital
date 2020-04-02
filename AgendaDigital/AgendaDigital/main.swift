#!/usr/bin/swift
//
//  main.swift
//  AgendaDigital
//
//  Created by Anderson Alencar on 13/03/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//

import Foundation

let manager = PersistenceManager()

while true {
    let response = menu()
    switch response {
    case 1:
        if let note = register() {
            manager.addNote(note: note)
            manager.saveNotes()
        } else {
            print("Erro na criação de uma nova nota, tente novamente por favor!")
        }
    case 2:
        let indexNote = listAndSelectNote(manager: manager)
        if let indexNote = indexNote {
            manager.updateNote(indexNote: indexNote) == true ? print("\nCompromisso Editado!\n"):print("\nAlgo de errado ocorreu!\n")
        }
    case 3:
        let indexNote = listAndRemoveNote(manager: manager)
        if let indexNote = indexNote {
            manager.deleteNote(indexNote: indexNote) == true ? print("\nCompromisso Cancelado!\n"):print("\nAlgo de errado ocorreu!\n")
        }
    case 4:
        let success = manager.loadNotes()
        success == true ? listNote(notes: manager.notes):print("Não há compromissos cadastrados !\n")
    case 5:
        let success = manager.loadNotes()
        if success{
            let activityTimes = activitiesReport(notes: manager.notes)
            showMetrics(times: activityTimes)
        } else {
            print("\nNenhum compromisso cadastrado atualmente !\n")
        }
    default:
        print("\nOpção inválida\n")
    }
}








