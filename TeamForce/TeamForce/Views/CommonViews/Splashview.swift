//
//  Splashview.swift
//  TeamForce
//
//  Created by Hiren Joshi on 16/01/21.
//

import Foundation
import SwiftUI

struct SplashIMG: View {
    var body: some View {
        VStack (alignment: .center, spacing: 40) {
            Image.init("TeamForce_LOGO")
            Image.init("TeamForce_Text")
        }
        .animation(.easeIn)
    }
}

struct SplashView: View {
    
    @State var isActive:Bool = false
    
    var body: some View {
        VStack {
            if self.isActive {
                Loginview()
                    .animation(.easeIn)
            } else {
                SplashIMG()
                    .animation(.easeIn)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                self.isActive = true
            }
        }
    }
    
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
