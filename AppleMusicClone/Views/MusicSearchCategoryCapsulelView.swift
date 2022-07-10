//
//  MusicSearchCategoryCapsulelView.swift
//  AppleMusicClone
//
//  Created by 박성수 on 2022/07/08.
//

import SwiftUI

struct MusicSearchCategoryCapsulelView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State var categories: [CategoryModel] = CategoryModel.list
    @State var selectedNum: Int = 0
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 15) {
                    ForEach(categories) { category in
                        ZStack {
                            Capsule()
                                .foregroundColor(category.selected ?  Color(.systemPink) : Color(.clear))
                            Button(action: {
                                Task {
                                    var tempSaveCategory = categories[ categories.firstIndex { $0.selected == true } ?? 0]
                                    tempSaveCategory = CategoryModel(id: tempSaveCategory.id, categoryTitle: tempSaveCategory.categoryTitle, selected: false)
                                    withAnimation {
                                        categories[ categories.firstIndex { $0.selected == true } ?? 0] = tempSaveCategory
                                        categories[ categories.firstIndex { $0.categoryTitle == category.categoryTitle } ?? 0 ] = CategoryModel(id: category.id, categoryTitle: category.categoryTitle, selected: category.selected ? false : true)
                                    }
                                }
                            }, label: {
                                Text(category.categoryTitle)
                                    .font(.body)
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                            })
                        }
                        .frame(width: CGFloat(category.categoryTitle.count * 15 + 20), height: 30)
                    }
                }
//                .padding()
            }
        }
    }
}

struct MusicSearchCategoryCapsulelView_Previews: PreviewProvider {
    static var previews: some View {
        MusicSearchCategoryCapsulelView()
            .previewLayout(.sizeThatFits)
    }
}
