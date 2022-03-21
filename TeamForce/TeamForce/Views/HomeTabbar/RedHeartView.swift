//
//  RedHeartView.swift
//  TeamForce
//
//  Created by Hiren Joshi on 19/01/21.
//

import SwiftUI

struct RedHeartView: View {
    var body: some View {
        ZStack {
            Rectangle()
            Text("RedHeart view")
                .foregroundColor(OrangeColor)
        }
    }
}

struct RedHeartView_Previews: PreviewProvider {
    static var previews: some View {
        RedHeartView()
    }
}
