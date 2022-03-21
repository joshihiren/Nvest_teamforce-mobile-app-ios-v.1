//
//  LottieLoader.swift
//  Lottie-SwiftUI
//
//  Created by Tom Baranes on 11/02/2020.
//  Copyright © 2020 tbaranes. All rights reserved.
//

import SwiftUI
import Lottie

struct LottieLoader: UIViewRepresentable {
    
    let animationView = AnimationView()
    var filename: String = "Loading"
    var loopMode: LottieLoopMode = .loop
    var animationSpeed: CGFloat = 0.5

    func makeUIView(context: UIViewRepresentableContext<LottieLoader>) -> UIView {
        let animation = Animation.named(filename)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.animationSpeed = animationSpeed
        animationView.tintColor = UIColor.init(OrangeColor)
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false

        let view = UIView()
        view.addSubview(animationView)
        [animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
         animationView.widthAnchor.constraint(equalTo: view.widthAnchor)].forEach {
            $0.isActive = true
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieLoader>) {

    }

}
