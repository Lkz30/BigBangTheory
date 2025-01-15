//
//  SeenEpisodesView.swift
//  BigBangTheory
//
//  Created by Luis Cano  on 2025-01-10.
//


import SwiftUI

struct SeenEpisodesView: View {
    @ObservedObject var bigBangModel: BigBangViewModel

    var body: some View {
        NavigationStack {
            List {
                ForEach(bigBangModel.getSeenEpisodes(), id: \.id) { episode in
                    NavigationLink(destination: ChapterDetailsView(bigBangModel: bigBangModel, chapterModel: episode)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(episode.name)
                                    .font(.headline)
                                Text("Season \(episode.season)")
                                    .font(.subheadline)
                            }
                            Spacer()
                            Image(episode.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .navigationTitle("Episodios Vistos")
        }
    }
}

