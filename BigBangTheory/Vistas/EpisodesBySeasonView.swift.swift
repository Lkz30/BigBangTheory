//
//  EpisodesBySeasonView.swift.swift
//  BigBangTheory
//
//  Created by Luis Cano  on 2025-01-10.
//
import SwiftUI

struct EpisodesBySeasonView: View {
    let season: Int
    @ObservedObject var bigBangModel: BigBangViewModel

    var body: some View {
        List {
            // Mostrar episodios favoritos primero
            ForEach(bigBangModel.favoritedEpisodes(for: season), id: \.id) { episode in
                episodeRow(episode: episode)
            }
            // Mostrar episodios no favoritos
            ForEach(bigBangModel.nonFavoritedEpisodes(for: season), id: \.id) { episode in
                episodeRow(episode: episode)
            }
        }
        .searchable(text: $bigBangModel.search, prompt: "Search Episodes")
        .navigationTitle("Season \(season)")
        .navigationDestination(for: BigBang.self) { episode in
            ChapterDetailsView(bigBangModel: bigBangModel, chapterModel: episode)
        }
    }

    // Nueva fila para cada episodio
    private func episodeRow(episode: BigBang) -> some View {
        NavigationLink(value: episode) {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(episode.name)
                        .font(.headline)
                    Text("Season \(episode.season)")
                        .font(.subheadline)
                    Text("Time: \(episode.runtime) min")
                        .font(.footnote)
                }
                Spacer()
                Image(episode.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .clipShape(Rectangle())
                    .cornerRadius(10)
            }
        }
    }
}


