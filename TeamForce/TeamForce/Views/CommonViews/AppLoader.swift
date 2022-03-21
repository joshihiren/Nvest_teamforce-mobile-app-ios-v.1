//
//  AppLoader.swift
//  TeamForce
//
//  Created by Hiren Joshi on 27/01/21.
//

import SwiftUI
import Foundation
import UIKit

private let vLoader = UIView()
private let activityIndicatorView = UIActivityIndicatorView.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))

struct AppLoader: View {
    @State var animationAmount: CGFloat = 1
    
    var body: some View {
        Button("Loading..."){
        }
        .padding(40)
        .background(Color.red)
        .foregroundColor(Color.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.red)
                .scaleEffect(animationAmount)
                .opacity(Double(2 - animationAmount))
                .animation(
                    Animation.easeInOut(duration:2)
                        .repeatForever(autoreverses: false)
                )
        )
        .onAppear {
            self.animationAmount = 2
        }
    }
}


struct AppLoader_Previews: PreviewProvider {
    static var previews: some View {
        AppLoader(animationAmount: 1.0)
    }
}


struct RRLoader {
    
    static func startLoaderToAnimating(_ isMask: Bool = true)  {
        
        DispatchQueue.main.async {
            if isMask {
                vLoader.frame = UIScreen.main.bounds
                vLoader.backgroundColor = UIColor.black.withAlphaComponent(0.2)
                AppScene.window?.addSubview(vLoader)
            }
            
            //activityIndicatorView.color = UIColor.blue
            //activityIndicatorView.hidesWhenStopped = true
            activityIndicatorView.center = CGPoint(x: Screen_width * 0.5, y: Screen_height * 0.5)
            AppScene.window?.addSubview(activityIndicatorView)
            
            //UIApplication.shared.isNetworkActivityIndicatorVisible = true
            activityIndicatorView.startAnimating()
        }
    }
    
    static func stopLoaderToAnimating() {
        delaymain(delay: 1) {
            //UIApplication.shared.isNetworkActivityIndicatorVisible = false
            activityIndicatorView.stopAnimating()
            vLoader.removeFromSuperview()
        }
    }
}
