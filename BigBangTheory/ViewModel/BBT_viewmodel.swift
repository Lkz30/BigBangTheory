//
//  BBT_viewmodel.swift
//  BigBangTheory
//
//  Created by Luis Cano  on 2025-01-02.
//


import SwiftUI
import Foundation

final class BigBangViewModel: ObservableObject {
    let data: AccesoryFunctions
    
    @Published var search = "" // Texto de búsqueda
    @Published var bigBang: [BigBang] {
        didSet {
            data.saveJSON(toSave: bigBang)
            self.groupEpisodesBySeason()
        }
    }
    @Published var groupedEpisodes: [Int: [BigBang]] = [:] // Episodios agrupados por temporada
    @Published var seenEpisodes: Set<Int> = [] // IDs de episodios marcados como vistos
    @Published var episodeRatings: [Int: Int] = [:] // Ratings de episodios por ID (1-3 estrellas)
    
    init(data: AccesoryFunctions = AccesoryFunctions()) {
        self.data = data
        self.bigBang = data.loadJSON()
        self.groupEpisodesBySeason()
    }
    
    // Agrupa los episodios por temporada
    private func groupEpisodesBySeason() {
        groupedEpisodes = Dictionary(grouping: bigBang, by: { $0.season })
    }
    
    // Filtra episodios según la búsqueda y temporada
    func filteredEpisodes(for season: Int) -> [BigBang] {
        groupedEpisodes[season]?.filter { episode in
            search.isEmpty || episode.name.localizedCaseInsensitiveContains(search)
        } ?? []
    }
    
    // Marca un episodio como visto o no visto
    func toggleSeen(episodeID: Int, isSeen: Bool) {
        if isSeen {
            seenEpisodes.insert(episodeID)
        } else {
            seenEpisodes.remove(episodeID)
        }
    }
    
    // Califica un episodio con estrellas
    func rateEpisode(episodeID: Int, rating: Int) {
        episodeRatings[episodeID] = rating
    }
    
    // Obtiene los episodios favoritos (calificados con al menos 1 estrella) ordenados por rating
    func favoritedEpisodes(for season: Int) -> [BigBang] {
        groupedEpisodes[season]?.filter { episode in
            (episodeRatings[episode.id] ?? 0) > 0
        }.sorted { (episodeRatings[$0.id] ?? 0) > (episodeRatings[$1.id] ?? 0) } ?? []
    }
    
    // Obtiene los episodios no favoritos (sin calificación)
    func nonFavoritedEpisodes(for season: Int) -> [BigBang] {
        groupedEpisodes[season]?.filter { episode in
            (episodeRatings[episode.id] ?? 0) == 0
        } ?? []
    }
}


extension BigBangViewModel {
    // Obtiene todos los episodios marcados como favoritos
    func getFavorites() -> [BigBang] {
        bigBang.filter { episodeRatings[$0.id] ?? 0 > 0 }
            .sorted { (episodeRatings[$0.id] ?? 0) > (episodeRatings[$1.id] ?? 0) }
    }

    // Obtiene todos los episodios marcados como vistos
    func getSeenEpisodes() -> [BigBang] {
        bigBang.filter { seenEpisodes.contains($0.id) }
    }
}



