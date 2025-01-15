//
//  seasonsView.swift
//  BigBangTheory
//
//  Created by Luis Cano  on 2025-01-04.
//


import SwiftUI

struct SeasonsView: View {
    @ObservedObject private var bigBangModel = BigBangViewModel()
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    // Iterar por las temporadas agrupadas
                    ForEach(bigBangModel.groupedEpisodes.keys.sorted(), id: \.self) { season in
                        NavigationLink(value: season) {
                            VStack {
                                // Mostrar la imagen de la temporada
                                Image("season\(season)")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 100)
                                    .cornerRadius(10)
                                // Título de la temporada
                                Text("Season \(season)")
                                    .font(.headline)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Temporadas")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    // Botón para ir a la vista de favoritos
                    NavigationLink(destination: FavoritesView(bigBangModel: bigBangModel)) {
                        VStack {
                            Image(systemName: "star")
                            Text("Favoritos")
                        }
                    }
                    Spacer()
                    // Botón para ir a la vista de episodios vistos
                    NavigationLink(destination: SeenEpisodesView(bigBangModel: bigBangModel)) {
                        VStack {
                            Image(systemName: "video.bubble")
                            Text("Vistos")
                        }
                    }
                    Spacer()
                }
            }
            .navigationDestination(for: Int.self) { season in
                EpisodesBySeasonView(season: season, bigBangModel: bigBangModel)
            }
        }
    }
}




#Preview {
    SeasonsView()
}


