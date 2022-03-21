//
//  FitnessView.swift
//  TeamForce
//
//  Created by Hiren Joshi on 19/01/21.
//

import SwiftUI

struct FitnessView: View {
    var body: some View {
        ZStack {
            Rectangle()
            Text("Fitness View")
                .foregroundColor(OrangeColor)
        }
    }
}

struct FitnessView_Previews: PreviewProvider {
    static var previews: some View {
        FitnessView()
    }
}
