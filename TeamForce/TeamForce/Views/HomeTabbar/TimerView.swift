//
//  TimerView.swift
//  TeamForce
//
//  Created by Hiren Joshi on 19/01/21.
//

import SwiftUI

struct TimerView: View {
    var body: some View {
        ZStack {
            Rectangle()
            Text("Timer View")
                .foregroundColor(OrangeColor)
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
