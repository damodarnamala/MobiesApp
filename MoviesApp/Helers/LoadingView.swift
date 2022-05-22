//
//  LoadingView.swift
//  MoviesApp
//
//  Created by Damodar Namala on 06/05/22.
//

import Foundation
import SwiftUI

struct LoadingView<Content>: View where Content: View {
    @Binding var isShowing: Bool
    var content: () -> Content
    
    var body: some View {
            self.content()
                .disabled(self.isShowing)
                .overlay {
                    VStack {
                        Text("Loading...")
                            .font(.title3)
                            .foregroundColor(.primary)
                        ActivityIndicator(isAnimating: .constant(true), style: .large)
                    }
                    
                    .frame(width: 300, height: 150, alignment: .center)
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(16)
                    .opacity(self.isShowing ? 1 : 0)
                }
            
    }
}


struct ActivityIndicator: UIViewRepresentable {
    
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
