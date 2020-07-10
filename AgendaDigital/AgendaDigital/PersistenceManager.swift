//
//  PersistenceManager.swift
//  AgendaDigital
//
//  Created by Anderson Alencar on 30/03/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//

import Foundation

class PersistenceManager {
    var notes = [Note]()
    
    func loadNotes() -> Bool {
        let dir = getDocumentsDirectory()
        let fileURL = dir.appendingPathComponent("notes.json")
        let fileExist = FileManager.default.fileExists(atPath: fileURL.path)
        if fileExist {
            do {
                let jsondata = try Data(contentsOf: fileURL)
                notes = try JSONDecoder().decode([Note].self, from: jsondata)
            } catch {
                print(error.localizedDescription)
            }
            return true
        } else {
            return false
        }
    }
    
    
    func saveNotes() {
        do {
            let jsonData = try JSONEncoder().encode(notes)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            let filename = getDocumentsDirectory().appendingPathComponent("notes.json")
            try jsonString.write(to: filename, atomically: true, encoding: .utf8)
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    
    func addNote(note: Note) {
        _ = loadNotes()
        notes.append(note)
    }
    
    func deleteNote(indexNote: Int) -> Bool {
        _ = loadNotes()
        notes.remove(at: indexNote)
        saveNotes()
        
        return notes.isEmpty != true ? true:false
     }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //return paths[0]
        return paths.first!
    }
    
    func updateNote(indexNote: Int) -> Bool {
        
        var newNote = manager.notes[indexNote]
        print("\n1 - Data ou Hora do compromisso: ")
        print("2 - Descrição")
        print("3 - Duração")
        print("4 - Categoria")
        print("5 - Repetir")
        print("Digita qual campo deseja editar:", terminator: " ")
        let field = readLine()
            
        if let field = field, let intFild = Int(field){
            switch intFild {
            case 1:
                newNote.date = getDate()
            case 2:
                newNote.description = getDescription()
            case 3:
                newNote.duration = getDuration()
            case 4:
                newNote.category = getCategory()
            case 5:
                newNote.status = getStatusNote()
            default:
                print("\nEntrada Incorreta")
                return false
            }
            manager.notes[indexNote] = newNote
            manager.saveNotes()
            return true
        } else {
             print("\nEntrada Incorreta\n")
            return false
        }
    }
}
