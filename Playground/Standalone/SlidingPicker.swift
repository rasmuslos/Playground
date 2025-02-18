//
//  SlidingPicker.swift
//  Playground
//
//  Created by Rasmus Krämer on 18.02.25.
//

import SwiftUI

struct SlidingPicker: View {
    @Binding var selection: String
    let values: [String]
    
    @ScaledMetric private var fontSize: CGFloat = 14
    @ScaledMetric private var capsuleHeight: CGFloat = 32
    
    private var textWidth: [Int: CGFloat] {
        Dictionary(uniqueKeysWithValues: values.enumerated().map {
            ($0.offset, NSString(string: $0.element).size(withAttributes: [.font: UIFont.systemFont(ofSize: fontSize)]).width)
        })
    }
    
    private var selectionIndex: Int {
        values.firstIndex(of: selection) ?? 0
    }
    
    private var capsuleWidth: CGFloat {
        // width of the selected value + 8 units padding on each side
        (textWidth[selectionIndex] ?? 0) + 16
    }
    private var xOffset: CGFloat {
        // width of all previous values + the padding in between
        (0..<selectionIndex).reduce(0) { $0 + (textWidth[$1] ?? 0) } + CGFloat(selectionIndex) * 16
    }
    
    @ViewBuilder
    private var valueButtons: some View {
        LazyHStack(spacing: 16) {
            ForEach(values, id: \.hashValue) { value in
                Button(value) {
                    selection = value
                }
                .buttonStyle(.plain)
                .font(.system(size: fontSize))
            }
        }
        .padding(8)
    }
    @ViewBuilder
    private var capsule: some View {
        Capsule()
            .fill(Color.accentColor)
            .frame(width: capsuleWidth, height: capsuleHeight)
            .offset(x: xOffset)
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ZStack(alignment: .leading) {
                capsule
                
                valueButtons
                
                valueButtons
                    .foregroundStyle(.white)
                    .mask(alignment: .leading) {
                        capsule
                    }
            }
            .animation(.interactiveSpring(response: 0.4, dampingFraction: 0.75), value: selection)
        }
    }
}

#Preview {
    @Previewable @State var selection = "Season 1"
    SlidingPicker(selection: $selection, values: ["Season 1", "Season 2", "Season 3", "Season 4", "Season 5", "All Episodes"])
}
