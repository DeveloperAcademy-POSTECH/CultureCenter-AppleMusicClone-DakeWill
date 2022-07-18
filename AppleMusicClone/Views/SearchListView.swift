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
    @Environment(\.isSearching) var isSearching
    @ObservedObject var searchViewModel: SearchViewModel
    @Binding var searchText: String
    @State private var albums: MusicItemCollection<Album> = []
    @State private var isPicked: SearchPick = .AppleMusic
    @State private var recentlySearched: [Album] = []
    @State var isActive: Bool = false
    @State var selectedItem: Int?
    var body: some View {
        VStack{
            if isSearching {
                Picker("", selection: $isPicked) {
                    ForEach(SearchPick.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: UIScreen.main.bounds.width * 0.88)
                if searchText == "" {
                    List {
                        HStack {
                            Text("최근 검색한 항목")
                            Spacer()
                            Text("지우기")
                                .foregroundColor(.accentColor)
                        }
                        ForEach(searchViewModel.recentlySearchedAlbum.sorted(by: {$0.sentDate > $1.sentDate}), id:\.self) { album in
                            CustomAlbumCell(album: album)
                        }
                    }
                } else {
                    List(albums) { album in
                        Button(action: {
                            selectedItem = albums.firstIndex(of: album)
                        }, label: {
                            ArtistCell(album: album)
                        }).background(
                            NavigationLink(destination: AlbumDetailView(album: album), tag: albums.firstIndex(of: album) ?? 0, selection: $selectedItem) {
                                EmptyView()
                            }.hidden()
                        )
                    }
                }
            }
            
        }
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.large)
        .onChange(of: searchText,
                  perform: requestUpdatedSearchResults
        )
        .onAppear {
            searchViewModel.fetchRecentlySearchedList()
        }
    }
    
    /*
     request function from SampleCode of Musickit
     https://developer.apple.com/documentation/musickit/using_musickit_to_integrate_with_apple_music
     */
    private func requestUpdatedSearchResults(for searchText: String) {
        Task {
            do {
                // Issue a catalog search request for albums matching the search term.
                _ = await MusicAuthorization.request()
                var searchRequest = MusicCatalogSearchRequest(term: searchText, types: [Album.self])
                searchRequest.limit = 10
                let searchResponse = try await searchRequest.response()
                // Update the user interface with the search response.
                self.apply(searchResponse, for: searchText)
            } catch {
                print("Search request failed with error: \(error).")
            }
        }
    }
    
    @MainActor // Main thread에서 실행됨을 보장함, UI를 그려주는 거랑 같은 쓰레드에서 생성된다고 생각하면 됨
    private func apply(_ searchResponse: MusicCatalogSearchResponse, for searchTerm: String) {
        if self.searchText == searchTerm {
            self.albums = searchResponse.albums
        }
    }
}
