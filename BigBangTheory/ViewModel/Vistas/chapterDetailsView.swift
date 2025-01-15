//
//  chapterDetailsView.swift
//  BigBangTheory
//
//  Created by Luis Cano  on 2025-01-04.
//

import Foundation
import SwiftUI



struct ChapterDetailsView: View {
    @ObservedObject var bigBangModel: BigBangViewModel
    let chapterModel: BigBang

    var body: some View {
        Form {
            Section {
                LabeledContent("Título", value: chapterModel.name)
                LabeledContent("Fecha de estreno", value: chapterModel.airdate)
                LabeledContent("Duración (min)", value: String(chapterModel.runtime))
                // Nuevo: Toggle para marcar como "Visto"
                Toggle("Visto", isOn: Binding(
                    get: { bigBangModel.seenEpisodes.contains(chapterModel.id) },
                    set: { isSeen in
                        bigBangModel.toggleSeen(episodeID: chapterModel.id, isSeen: isSeen)
                    }
                ))
                // Nuevo: Calificación con estrellas
                HStack {
                    Text("Calificación")
                    Spacer()
                    RatingView(rating: Binding(
                        get: { bigBangModel.episodeRatings[chapterModel.id] ?? 0 },
                        set: { newRating in
                            bigBangModel.rateEpisode(episodeID: chapterModel.id, rating: newRating)
                        }
                    ))
                }
            } header: {
                Text("Datos del capítulo")
            }

            Section {
                Image(chapterModel.image)
                    .resizable()
                    .scaledToFit()
            } header: {
                Text("Imagen del capítulo")
            }

            Section {
                LabeledContent("Resumen del capítulo", value: chapterModel.summary)
                    .labelsHidden()
            } header: {
                Text("Resumen del capítulo")
            }
        }
        .navigationTitle("Detalles del capítulo")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Componente para mostrar estrellas de calificación
struct RatingView: View {
    @Binding var rating: Int

    var body: some View {
        HStack {
            ForEach(1...3, id: \.self) { star in
                Image(systemName: star <= rating ? "star.fill" : "star")
                    .foregroundColor(.yellow)
                    .onTapGesture {
                        rating = star
                    }
            }
        }
    }
}


