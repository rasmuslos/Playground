//
//  ListStyles.swift
//  Playground
//
//  Created by Rasmus Krämer on 27.01.25.
//

import SwiftUI

struct ListStyles: View {
    @ViewBuilder
    private var list: some View {
        List {
            ForEach(0..<10, id: \.hashValue) {
                Text($0.description)
            }
            
            Group {
                Toggle("CDF", isOn: .constant(false))
                Toggle("GHI", isOn: .constant(true))
            }
            .toggleStyle(.switch)
            
            Section {
                Text("ABC")
            }
            .listSectionSeparator(.visible)
            
            Text("Hello, World!")
                .font(.caption2)
                .padding(.vertical, 2)
                .padding(.horizontal, 8)
                .background(.blue.opacity(0.8), in: .capsule)
        }
    }
    
    var body: some View {
        list
            .listStyle(.inset)
            .padding(20)
    }
}

#Preview {
    ListStyles()
}
