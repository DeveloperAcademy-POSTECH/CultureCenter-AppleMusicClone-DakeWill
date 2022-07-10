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
    
    var body: some View {
        NavigationView {
            VStack{
                SearchListView(searchText: $searchText)
                    .searchable(text: $searchText,
                                placement: .navigationBarDrawer(displayMode: .always),
                                prompt: "search")
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
