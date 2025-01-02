//
//  Repo.swift
//  BigBangTheory
//
//  Created by Luis Cano  on 2025-01-02.
//

import Foundation

struct Repo {
    var url : URL { // con esto creo una variable que carge el archivo JSON desde su origen
        Bundle.main.url(forResource: "bigbang", withExtension: "json")!
    }
    
    func loadJson() -> BBs { // esta funcion carga el JSON
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(BBs.self, from: data)
        } catch {
            print("Error loading JSON: \(error)")
            return []
        }
    }
    
    func saveJson(_ bigBang: BigBang) { // esta funcion guarda el JSON
        let data = try! JSONEncoder().encode(bigBang)
        try! data.write(to: url)
    }
}
