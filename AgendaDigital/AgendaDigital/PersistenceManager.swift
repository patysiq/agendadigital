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
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //return paths[0]
        return paths.first!
    }
}
