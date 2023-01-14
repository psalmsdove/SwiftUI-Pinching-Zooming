//
//  ContentView.swift
//  Pinch
//
//  Created by Ali Erdem Kökcik on 14.01.2023.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Property
    
    @State private var isAnimating: Bool = false
    @State private var imageScale: CGFloat = 1
    @State private var imageOffset: CGSize = .zero
    
    // MARK: Function
    
    func resetImageState(){
        return withAnimation(.spring()){
            imageScale = 1
            imageOffset = .zero
        }
    }
    
    // MARK: Content
    
    var body: some View {
        VStack {
            NavigationView{
                ZStack{
                    // MARK: Page Image
                    Image("magazine-front-cover")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .padding()
                        .shadow(radius: 12)
                        .opacity(isAnimating ? 1 : 0)
                        .offset(x: imageOffset.width, y: imageOffset.height)
                        .animation(.linear(duration: 1), value: isAnimating)
                        .scaleEffect(imageScale)
                    // MARK: 1- Tap Gesture
                        .onTapGesture(count: 2, perform: { // Count here is the tap count.
                            if imageScale == 1 {
                                withAnimation(.spring()) {
                                    imageScale = 5 // Scale-up.
                                        }
                                    } else {
                                        resetImageState() // Back to default.
                            }
                        })
                    // MARK: 2- Drag Gesture
                        .gesture(
                            DragGesture()
                                .onChanged{ value in
                                    withAnimation(.linear(duration: 1)){
                                        imageOffset = value.translation
                                    }
                                }
                                .onEnded{ _ in
                                    if imageScale <= 1{
                                        resetImageState()
                                    }
                                }
                        )
                } // ZSTACK
                .navigationTitle("Pinch & Zoom")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear(perform: {
                    withAnimation(.linear(duration: 1)){ //It will open in 1 sec when the app opens up.
                        isAnimating = true
                    }
                })
            } // NAVIGATION
            .navigationViewStyle(.stack) // This will avoid using the sidebar on iPad devices.
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
