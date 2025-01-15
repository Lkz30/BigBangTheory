//
//  accesory_functions.swift
//  BigBangTheory
//
//  Created by Luis Cano  on 2025-01-04.
//

import Foundation
import SwiftUI

struct AccesoryFunctions {
    
    var url : URL {
        Bundle.main.url(forResource: "BigBang", withExtension: "json")!
    }
    
    func loadJSON() -> [BigBang] {
        do{
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([BigBang].self, from: data)
        } catch {
            print("Error decoding JSON: \(error)")
        }
        return []
    }
    
    func saveJSON( toSave : [BigBang] ) {
        
    }
    
    func groupEpisodesBySeason(episodes: [BigBang]) -> [Int: [BigBang]] {
        return Dictionary(grouping: episodes, by: { $0.season })
    }
    
    
}
