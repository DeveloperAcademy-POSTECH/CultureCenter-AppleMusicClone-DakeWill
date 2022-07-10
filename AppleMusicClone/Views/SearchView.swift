//
//  SearchView.swift
//  AppleMusicClone
//
//  Created by 박성수 on 2022/06/27.
//
import MusicKit
import SwiftUI

struct SearchView: View {
    @State var searchText: String = ""
    @State private var albums: MusicItemCollection<Album> = []
    
    var body: some View {
        NavigationView {
            VStack {
                if albums.isEmpty {
                    NoData()
                }
                else{
                    List(albums) { album in
                        if !albums.isEmpty {
                            VStack {
                                ArtistCell(album: album)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.large)
        }
        .searchable(text: $searchText,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "아티스트, 노래, 가사 등")
        .onChange(of: searchText,
                  perform: requestUpdatedSearchResults
        )
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
        }
    }
}

struct NoData: View {
    var body: some View {
        VStack {
            Spacer()
            Text("No Data")
            Spacer()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
