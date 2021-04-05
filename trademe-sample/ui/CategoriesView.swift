//
//  CategoriesView.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 18/10/20.
//  Copyright © 2020 Leonel Quinteros. All rights reserved.
//

import SwiftUI

class CategoryList: ObservableObject {
    @Published var categories: [CategoryModel] = []
}

struct CategoriesView: View {
    
    @State var isLoading: Bool = true
    
    var list = CategoryList()
   
    var body: some View {
        
        NavigationView {
            List(list.categories) { category in
                CategoryNavigationItem(category: category)
            }
            .navigationBarTitle(Text("Categories"))
            .redacted(reason: isLoading ? /*@START_MENU_TOKEN@*/.placeholder/*@END_MENU_TOKEN@*/ : [])
        
        }.onAppear(perform: {
            CategoryProvider().retrieve { result in
                switch result {
                case .success(let response):
                    list.categories = response
                    break
                case .failure(_):
                    break
                }
                isLoading.toggle()
            }
        })
    }
}

struct CategoryNavigationItem: View {
    
    let category: CategoryModel
    
    var body: some View {
        NavigationLink(destination: Text("Hola \(category.name)")) {
            Image(systemName: "pencil.and.outline")
            VStack(alignment: .leading) {
                Text(category.name)
                Text("\(category.number) items")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
