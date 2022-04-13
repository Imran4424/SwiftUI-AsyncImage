//
//  ContentView.swift
//  AsyncImage
//
//  Created by Shah Md Imran Hossain on 13/4/22.
//

import SwiftUI

struct ContentView: View {
    private let imageURL: String = "https://credo.academy/credo-academy@3x.png"
    
    var body: some View {
        // MARK: - 1. Basic
//        AsyncImage(url: URL(string: imageURL))
        
        // MARK: - 2. Scale
//        AsyncImage(url: URL(string: imageURL), scale: 3.0)
                
        // MARK: - 3. Place holder
//        AsyncImage.init(url: URL(string: imageURL)) { image in
//            image
//                .resizable()
//                .scaledToFit()
//        } placeholder: {
//            Image(systemName: "photo.circle.fill")
//                .resizable()
//                .scaledToFit()
//                .frame(maxWidth: 128)
//                .foregroundColor(.purple)
//                .opacity(0.5)
//        }
//        .padding(40)
        
        // MARK: - 4. Image Extension
//        AsyncImage.init(url: URL(string: imageURL)) { image in
//            image.imageModifier()
//        } placeholder: {
//            Image(systemName: "photo.circle.fill")
//                .iconModifier()
//        }
//        .padding(40)

        // MARK: - 5. Phase
//        AsyncImage(url: URL(string: imageURL)) { phase in
//            // Success: The image is successfully loaded
//            // Failure: The image failed to load with an error
//            // Empty: No image is loaded
//
//            if let image = phase.image {
//                image.imageModifier()
//            } else if phase.error != nil {
//                Image(systemName: "ant.circle.fill").iconModifier()
//            } else {
//                Image(systemName: "photo.circle.fill")
//                                .iconModifier()
//            }
//        }
//        .padding(40)


        // MARK: - 6. Animation
        AsyncImage(
            url: URL(string: imageURL),
            transaction: Transaction(
                animation: .spring(response: 0.5,
                                   dampingFraction: 0.6,
                                   blendDuration: 0.25)
            )
        ) { phase in
            // Success: The image is successfully loaded
            // Failure: The image failed to load with an error
            // Empty: No image is loaded
            
            switch phase {
                case .success(let image):
                    image.imageModifier()
//                        .transition(.move(edge: .bottom))
//                        .transition(.slide)
                        .transition(.scale)
//                        .transition(.opacity)
                case .failure(_):
                    Image(systemName: "ant.circle.fill").iconModifier()
                case .empty:
                    Image(systemName: "photo.circle.fill")
                        .iconModifier()
                    
                @unknown default:
                    ProgressView()
            }
        }
        .padding(40)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Image {
    func imageModifier() -> some View {
        self.resizable()
            .scaledToFit()
    }
    
    func iconModifier() -> some View {
        self.imageModifier()
            .frame(maxWidth: 128)
            .foregroundColor(.purple)
            .opacity(0.5)
    }
}
