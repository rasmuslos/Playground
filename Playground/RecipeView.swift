//
//  ContentView.swift
//  Test
//
//  Created by Rasmus Krämer on 24.08.24.
//

import SwiftUI
import TipKit

struct RecipeView: View {
    @State private var expanded: [Int: Bool] = [:]
    @State private var ingredientsSheetPresented = false
    
    @State private var amount = 10
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    Text("Hausgemachte Schokokekse mit einer Kombination aus zarter Schokolade und süßem Karamell. Der Teig ist einfach zuzubereiten und die Kekse backen goldbraun und lecker.")
                        .padding(.horizontal, 20)
                    
                    LazyVGrid(columns: [.init(), .init(), .init(), .init(), .init()], spacing: 8) {
                        HighlightGridItem(title: "20m", description: "Cooking")
                        HighlightGridItem(title: "15m", description: "Wait")
                        
                        EditAmountMenu(amount: $amount) {
                            HighlightGridItem(title: "\(amount)", description: "Cookies")
                        }
                        
                        HighlightGridItem(title: "4,5", description: "Sterne")
                        HighlightGridItem(title: "23.01", description: "Zuletzt")
                    }
                    .padding(.horizontal, 20)
                    
                    LazyVStack(spacing: 12) {
                        HStack(alignment: .firstTextBaseline) {
                            Text("Zubereitung")
                                .bold()
                                .font(.title2)
                            
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Label("Kochen", systemImage: "frying.pan")
                                    .labelStyle(.iconOnly)
                            }
                            .buttonStyle(.plain)
                            .bold()
                            .font(.footnote)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 10)
                            .background(.orange)
                            .clipShape(.rect(cornerRadius: .infinity))
                        }
                        
                        StepSection(title: "Trockene Zutaten", description: "Die Zutaten vermgengen.", ingredients: ["160 g Mehl", "Teelöffel Backpulver", "1 Teelöffel Salz"])
                        StepSection(title: "Flüssige Zutaten", description: "In einer anderen Schüssel die Butter mit beiden Zuckern vermischen. Für einige Minuten zu einer Paste schlagen. Anschließend das Ei und die Vanillie hinzugegen.", ingredients: ["120 g Butter", "100 g Braunen Zucker", "70 g Zucker", "1 Ei", "1 Teelöffel Vanille"])
                        StepSection(title: "Schokoladenstückchen", description: "Die Schokolade zerkleinern und die Stücke in den Teig geben. Nur mit einem Spachtel vermengen", ingredients: ["100 g Schokolade"])
                        StepSection(title: "Backen", description: "Die Kekse für 15 Minuten bei 180 °C bei Umluft im Ofen backen.", ingredients: [])
                    }
                    .padding(20)
                    .background(.background.quaternary)
                    
                    // TODO: Nutrition, etc. when i understand them
                }
            }
            .scrollClipDisabled()
            .navigationTitle("Cookies")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        ingredientsSheetPresented.toggle()
                    } label: {
                        Label("Ingredients", systemImage: "carrot.fill")
                            .labelStyle(.iconOnly)
                    }
                }
            }
            .sheet(isPresented: $ingredientsSheetPresented) {
                List {
                    IngredientRow(ingredient: "160 g Mehl")
                    IngredientRow(ingredient: "Teelöffel Backpulver")
                    IngredientRow(ingredient: "120 g Butter")
                    IngredientRow(ingredient: "100 g Braunen Zucker")
                    IngredientRow(ingredient: "70 g Zucker")
                    IngredientRow(ingredient: "1 Ei")
                    IngredientRow(ingredient: "1 Teelöffel Vanille")
                    IngredientRow(ingredient: "100 g Schokolade")
                }
                .padding(.top, -40)
                .navigationTitle("Ingredients")
                .safeAreaInset(edge: .top) {
                    HStack {
                        Text("Ingredients")
                            .font(.title3)
                            .bold()
                        
                        Spacer()
                        
                        EditAmountMenu(amount: $amount) {
                            VStack {
                                Text("\(amount)")
                                    .font(.caption)
                                Text("Cookies")
                                    .font(.caption2)
                            }
                            .foregroundStyle(.secondary)
                        }
                    }
                    .padding(20)
                }
                .safeAreaInset(edge: .bottom) {
                    Button {
                        
                    } label: {
                        Label("Start cooking", systemImage: "pan.fill")
                    }
                    .buttonStyle(.plain)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(.orange, in: .rect(cornerRadius: 12))
                    .padding(20)
                }
                .presentationDetents([.medium, .large])
            }
        }
    }
}

private struct HighlightGridItem: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            
            Text(description)
                .font(.caption)
        }
        .frame(maxWidth: .infinity)
        .padding(8)
        .background(.gray.opacity(0.2))
        .clipShape(.rect(cornerRadius: 8))
    }
}

private struct StepSection: View {
    let title: String
    let description: String
    let ingredients: [String]
    
    @State private var isExpanded = false
    
    var body: some View {
        DisclosureGroup(title, isExpanded: $isExpanded) {
            VStack(alignment: .leading, spacing: 8) {
                ForEach(ingredients, id: \.hashValue) {
                    IngredientRow(ingredient: $0)
                }
                
                Text(description)
                    .padding(.top, ingredients.isEmpty ? 0 : 8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .disclosureGroupStyle(DisclosureGroupStepHeaderStyle())
    }
}
private struct IngredientRow: View {
    let ingredient: String
    
    @State private var toggled = false
    
    var body: some View {
        Button {
            withAnimation {
                toggled.toggle()
            }
        } label: {
            HStack(alignment: .center, spacing: 12) {
                Circle()
                    .fill(toggled ? .orange : .white)
                    .stroke(.gray, lineWidth: 0.4)
                    .frame(width: 20)
                    .overlay {
                        if toggled {
                            Image(systemName: "checkmark")
                                .font(.caption2)
                        }
                    }
                
                Text(ingredient)
                
                Spacer()
            }
            .contentShape(.rect)
        }
        .buttonStyle(.plain)
    }
}

private struct DisclosureGroupStepHeaderStyle: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 0) {
            Button {
                withAnimation {
                    configuration.isExpanded.toggle()
                }
            } label: {
                HStack {
                    configuration.label
                        .font(.headline)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .font(.subheadline)
                        .rotationEffect(.degrees(configuration.isExpanded ? 0 : -90))
                        .animation(.linear, value: configuration.isExpanded)
                }
                .contentShape(.rect)
            }
            .buttonStyle(.plain)
            
            configuration.content
                .padding(.top, 8)
                .frame(maxHeight: configuration.isExpanded ? .infinity : 0, alignment: .top)
                .clipped()
        }
    }
}

private struct EditAmountMenu<Content: View>: View {
    @Binding var amount: Int
    
    @ViewBuilder let label: Content
    
    var body: some View {
        Menu {
            ControlGroup {
                Button {
                    amount -= 1
                } label: {
                    Label("Less", systemImage: "minus")
                }
                
                Text("\(amount)")
                
                Button {
                    amount += 1
                } label: {
                    Label("More", systemImage: "plus")
                }
            }
            .controlGroupStyle(.compactMenu)
        } label: {
            label
        }
        .buttonStyle(.plain)
        .menuActionDismissBehavior(.disabled)
        .popoverTip(EditAmountTip())
    }
}
private struct EditAmountTip: Tip {
    var title: Text {
        .init("Edit serving size")
    }
    
    var message: Text? {
        .init("You can edit the serving size of your meal here.")
    }
    
    var image: Image? {
        .init(systemName: "fork.knife")
    }
}

#Preview {
    RecipeView()
}
