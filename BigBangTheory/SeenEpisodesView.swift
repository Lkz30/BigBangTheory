import SwiftUI

struct SeenEpisodesView: View {
    @ObservedObject var bigBangModel: BigBangViewModel

    var body: some View {
        List {
            ForEach(bigBangModel.getSeenEpisodes(), id: \.id) { episode in
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
        .navigationTitle("Episodios Vistos")
    }
}
