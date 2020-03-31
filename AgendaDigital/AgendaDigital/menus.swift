//
//  menus.swift
//  AgendaDigital
//
//  Created by Anderson Alencar on 13/03/20.
//  Copyright © 2020 Anderson Alencar. All rights reserved.
//

import Foundation

func menu() -> Int? {
    print("--------------------------------------------------")
    print("#         Bem-Vindo a sua Agenda Digital         #")
    print("#      ------------------------------------      #")
    print("#                                                #")
    print("#             Escolha uma opção:                 #\n")
    print(" 1 - Cadastrar novo Compromisso \n 2 - Editar Compromisso \n 3 - Cancelar Compromissos \n 4 - Listar Compromissos \n 5 - Relatório de Atividade")
    print(" \n Digite: ", terminator: " ")
    let response = readLine()

    if let response = response {
        return Int(response)
    } else {
        return nil
    }
    
}
