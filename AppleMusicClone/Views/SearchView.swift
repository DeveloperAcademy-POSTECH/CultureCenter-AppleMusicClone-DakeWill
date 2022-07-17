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
    @State private var isPicked: SearchPick = .AppleMusic
    @ObservedObject var searchViewModel = SearchViewModel()
    var body: some View {
        NavigationView {
            VStack {
                SearchListView(searchViewModel: searchViewModel, searchText: $searchText)
            }
        }
        .searchable(text: $searchText,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "아티스트, 노래, 가사 등")
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
