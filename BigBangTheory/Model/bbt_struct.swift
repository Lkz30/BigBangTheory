//
//  bbt_struct.swift
//  BigBangTheory
//
//  Created by Luis Cano  on 2025-01-02.
//
import Foundation

struct BigBang: Codable { // todos los modelos siempre deben ser un struct
    let id: Int
    let url: URL
    let name: String
    let season, number: Int
    let airdate: String
    let runtime: Int
    let image: String
    let summary: String
}

typealias BBs = [BigBang] // esto es azucar sintactico
 
