//
//  SearchListView.swift
//  AppleMusicClone
//
//  Created by 최동권 on 2022/07/04.
//

import SwiftUI
import MusicKit


enum SearchPick: String, CaseIterable {
    case AppleMusic
    case storageBox
}

struct SearchListView: View {
    
    @ObservedObject var viewModel = SearchListViewModel()
    
    @Binding var searchText: String
    
    @State var songs: MusicItemCollection<Artist> = []
    @State private var albums: MusicItemCollection<Album> = []
    @State private var isPicked: SearchPick = .AppleMusic
    @State private var recentlySearched: [Album] = []
    @Environment(\.isSearching) var isSearching
    
    var body: some View {
        List(songs) { song in
            
            if !songs.isEmpty {
                HStack {
                    //                        ArtworkImage(song.artwork!, width: 75)
                    //                        Color(song.artwork?.backgroundColor ?? ".black" as! CGColor)
                    //                        Text(song.artwork?.alternateText ?? "none")
                    VStack (alignment: .leading) {
                        Text(song.name)
                            .lineLimit(1)
                            .foregroundColor(.primary)
                        ForEach(song.genreNames ?? [""], id:\.self) { genre in
                            Text(genre)
                        }
                        //                            Text(song.artistName)
                        //                                .lineLimit(1)
                        //                                .foregroundColor(.secondary)
                    }
                    .onTapGesture {
//                        viewModel.storeRecentlySearched(album: song)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.large)
        .onChange(of: searchText,
                  perform: requestUpdatedSearchResults
        )
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack{
                    if isSearching {
                        Picker("", selection: $isPicked) {
                            ForEach(SearchPick.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                        .frame(width: UIScreen.main.bounds.width * 0.88)
                    }
                }
            }
        }
    }
    
    private func requestUpdatedSearchResults(for searchText: String) {
        Task {
            do {
                // Issue a catalog search request for albums matching the search term.
                _ = await MusicAuthorization.request()
                var searchRequest = MusicCatalogSearchRequest(term: searchText, types: [Artist.self])
                searchRequest.limit = 10
                let searchResponse = try await searchRequest.response()
                // Update the user interface with the search response.
                await self.apply(searchResponse, for: searchText)
            } catch {
                print("Search request failed with error: \(error).")
            }
        }
    }
    
    @MainActor // Main thread에서 실행됨을 보장함, UI를 그려주는 거랑 같은 쓰레드에서 생성된다고 생각하면 됨
    private func apply(_ searchResponse: MusicCatalogSearchResponse, for searchTerm: String) {
        if self.searchText == searchTerm {
            self.albums = searchResponse.albums
            self.songs = searchResponse.artists
            print(searchResponse.artists)
        }
    }
}
//
//struct SearchListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchListView()
//    }
//}


