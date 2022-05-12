//
//  BottomBar.swift
//  AnimBless
//
//  Created by iBlessme on 05.05.2022.
//

import SwiftUI

struct BottomBar: View {
    
    let items: [BottombarItem]
    @Binding var selectedIndex: Int
    
    init(selectedIndex: Binding<Int>, items: [BottombarItem]){
        self._selectedIndex = selectedIndex
        self.items = items
    }
    
    func itemView(at index: Int) -> some View{
        Button{
            withAnimation{self.selectedIndex = index}
        }label: {
            BottomBarItemView(isSelected: index == selectedIndex, item: items[index])
        }
    }
    
    
    var body: some View {
        HStack(alignment: .bottom){
            ForEach(0..<items.count){index in
                self.itemView(at: index)
                
                if index != self.items.count - 1 {
                    Spacer()
                }
                
            }
        }
        .padding()
        .frame(width: 400.0)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -2)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct BottomBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomBar(selectedIndex: .constant(0), items: [BottombarItem(icon: "list.star", title: "топ-аниме", color: .purple), BottombarItem(icon: "hand.thumbsup.fill", title: "ваш топ", color: .pink), BottombarItem(icon: "list.and.film", title: "список аниме", color: .blue)])
    }
}

struct BottomBarItemView: View{
    
    let isSelected: Bool
    let item: BottombarItem
    
    var body: some View{
        HStack{
            Image(systemName: item.icon)
                .imageScale(.large)
                .foregroundColor(isSelected ? item.color : .primary)
            if isSelected{
                Text(item.title)
                    .foregroundColor(item.color)
                    .fontWeight(.bold)
            }
        }
        .padding()
        .background(Capsule().fill(isSelected ? item.color.opacity(0.2) : Color.clear))
    }
}
