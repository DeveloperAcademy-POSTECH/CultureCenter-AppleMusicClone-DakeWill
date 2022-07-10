//
//  Category.swift
//  AppleMusicClone
//
//  Created by 박성수 on 2022/07/10.
//

import Foundation

struct CategoryModel: Identifiable {
    var id: UUID = UUID()
    var categoryTitle: String
    var selected: Bool
}

extension CategoryModel {
    static var list: [CategoryModel] = [
        CategoryModel(categoryTitle: "인기 검색 결과", selected: false),
        CategoryModel(categoryTitle: "아티스트", selected: false),
        CategoryModel(categoryTitle: "앨범", selected: false),
        CategoryModel(categoryTitle: "노래", selected: false),
        CategoryModel(categoryTitle: "플레이리스트", selected: false),
        CategoryModel(categoryTitle: "라디오 에피소드", selected: false),
        CategoryModel(categoryTitle: "스테이션", selected: false),
        CategoryModel(categoryTitle: "뮤직비디오", selected: false),
        CategoryModel(categoryTitle: "프로필", selected: false)
    ]
}
