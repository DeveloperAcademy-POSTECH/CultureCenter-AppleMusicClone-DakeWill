//
//  MainView.swift
//  AppleMusicClone
//
//  Created by 박성수 on 2022/06/27.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ListenNowView()
                .tabItem {
                    Image(systemName: "play.circle.fill")
                    Text("Listen Now")
                }
            RadioView()
                .tabItem {
                    Image(systemName: "dot.radiowaves.left.and.right")
                    Text("Radio")
                }
            LibraryView()
                .tabItem {
                    Image(systemName: "music.note.house.fill")
                    Text("Library")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
