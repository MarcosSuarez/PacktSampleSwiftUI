//
//  ContentView.swift
//  PacktSampleSwiftUI
//
//  Created by Marcos Suárez on 22/10/22.
//

import SwiftUI

struct MenuView: View {
    @State var characters: [Character] = []
    // MARK: - Gesture properties
    @GestureState var isDragging: Bool = false
    @State var offsetY: CGFloat = 0
    
    @State var currentActiveIndex: Int = 0
    
    var body: some View {
        NavigationView(content: {
            HStack {
                ScrollViewReader(content: { proxy in
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 0) {
                            ForEach(characters) { character in
                                MenuListBy(character: character)
                                    .id(character.index)
                            }
                        }
                        .padding(.top, 15)
                    }
                    /*
                    .onChange(of: currentActiveIndex) { newValue in
                        // MARK: - Scrolling to current index
                        if isDragging {
                            withAnimation(.easeIn(duration: 0.15)) {
                                proxy.scrollTo(newValue, anchor: .top)
                            }
                        }
                    }
                     */
                })
                .navigationTitle("SwiftUI animations")
                CustomScroller()
            }
        }).navigationViewStyle(.stack)
    }
    
    // MARK: - Custom Scroller
    @ViewBuilder
    func CustomScroller() -> some View {
        GeometryReader { geo in
            let rec = geo.frame(in: .named("SCROLLER"))
            VStack(spacing: 0) {
                ForEach($characters) { $character in
                    // MARK: - To find each alphabet origin on the screen
                    GeometryReader { innerGeo in
                        let origin = innerGeo.frame(in: .named("SCROLLER"))
                        HStack(spacing: 0) {
                            Text(character.value)
                                .font(.callout)
                                .fontWeight(character.isCurrent ? .bold : .semibold)
                                .foregroundColor(character.isCurrent ? .black : .gray)
                                .scaleEffect(character.isCurrent ? 1.4 : 1)
                                .frame(width: origin.size.width, height: origin.size.height, alignment: .trailing)
                                .offset(x: character.pushOffset)
                                .animation(.easeInOut(duration: 0.2), value: character.pushOffset)
                                .animation(.easeInOut(duration: 0.2), value: character.isCurrent)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                        character.rect = origin
                                    }
                                }
                            Rectangle()
                                .fill(.gray)
                                .frame(width: 20, height: 0.8)
                                .offset(x: 15)
                        }
                        
                        // MARK: - Displaying only for first item
                        ZStack() {
                            if characters.first?.id == character.id {
                                ScrollerKnob(character: $character, rect: rec)
                            }
                        }
                    }
                    .frame(width: 20)
                }
            }
        }
        .frame(width: 55)
        .padding(.trailing, 10)
        .coordinateSpace(name: "SCROLLER")
        .padding(.vertical, 15)
        .onAppear {
            characters = fecthCharacters()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                characterElevation()
            }
        }
    }
    
    @ViewBuilder
    func ScrollerKnob(character: Binding<Character>, rect: CGRect) -> some View {
        Circle()
            .fill(.black)
            .offset(x: 35, y: offsetY)
            .gesture(
                // MARK: - Drag Gesture
                DragGesture(minimumDistance: 5)
                    .updating($isDragging, body: { _, out, _ in
                        out = true
                    })
                    .onChanged { value in
                        // MARK: - Setting location
                        var translation = value.location.y
                        // MARK: - Limiting Tranlation
                        translation = min(translation, rect.maxY - 20)
                        translation = max(translation, rect.minY)
                        offsetY = translation
                        characterElevation()
                    }
                    .onEnded { value in
                        // MARK: - Setting to last Character location
                        if characters.indices.contains(currentActiveIndex) {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                offsetY = characters[currentActiveIndex].rect.minY
                            }
                        }
                    })
    }
    
    // MARK: - Checking for character elevation when gesture is started
    func characterElevation() {
        // We're going to verify offset lies in the Character region with the help of CGRect's default contain's property
        if let index = characters.firstIndex(where: { character in
            character.rect.contains(CGPoint(x: 0, y: offsetY))
        }) {
            updateElevation(index: index)
        }
    }
    
    // MARK: - Update elevation
    func updateElevation(index: Int) {
        // MARK: - modified indices array
        var modifiedIndicies: [Int] = []
        
        // MARK: - updating side offset
        characters[index].pushOffset = -20
        characters[index].isCurrent = true
        currentActiveIndex = index
        modifiedIndicies.append(index)
        
        // MARK: - Updating top and bottom 3 offset's in order to create a curve animation
        let othersOffsets: [CGFloat] = [-15, -10, -5]
        for index_ in othersOffsets.indices {
            let newIndex = index + (index_ + 1)
            // MARK:- Top indixes (Negative)
            let newIndex_Negative = index - (index_ + 1)
            
            if verifyAndUpdate(index: newIndex, offset: othersOffsets[index_]) {
                modifiedIndicies.append(newIndex)
            }
            
            if verifyAndUpdate(index: newIndex_Negative, offset: othersOffsets[index_]) {
                modifiedIndicies.append(newIndex_Negative)
            }
        }
        // MARK: - Setting remainig all other Characters offset to zero
        for index_ in characters.indices {
            if !modifiedIndicies.contains(index_) {
                characters[index_].pushOffset = 0
                characters[index_].isCurrent = false
            }
        }
    }
    
    // MARK: - Safety check
    func verifyAndUpdate(index: Int, offset: CGFloat) -> Bool {
        if characters.indices.contains(index) {
            characters[index].pushOffset = offset
            // Since its not the main offset
            characters[index].isCurrent = false
            return true
        }
        return false
    }
    
    // MARK: - Example view row for each alphabet
    @ViewBuilder
    func MenuListBy(character: Character) -> some View {
        VStack (alignment: .leading, spacing: 15){
            Text(character.value)
                .font(.largeTitle.bold())
            
            ForEach(1...4, id: \.self) { _ in
                HStack(spacing: 10) {
                    Circle()
                        .fill(character.color)
                        .frame(width: 45, height: 45)
                    
                    VStack (alignment: .leading, spacing: 8){
                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                            .fill(character.color.opacity(0.6))
                            .frame(height: 20)
                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                            .fill(character.color.opacity(0.4))
                            .frame(height: 20)
                            .padding(.trailing, 80)
                    }
                }
            }
        }
        .padding(15)
    }
    
    // MARK: - Fetching Characters
    func fecthCharacters() -> [Character] {
        let alphabets: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var characters: [Character] = []
        
        characters = alphabets.compactMap { Character(value: String($0))}
        
        // MARK: - Sample Color's
        let colors: [Color]
        if #available(iOS 15.0, *) {
            colors = [.red, .yellow, .pink, .orange, .cyan, .indigo, .purple, .blue]
        } else {
            colors = [.red, .yellow, .pink, .orange, .green, .gray, .purple, .blue]
        }
        
        // MARK: - Setting Index and random color.
        for index in characters.indices {
            characters[index].index = index
            characters[index].color = colors.randomElement()!
        }
        return characters
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
