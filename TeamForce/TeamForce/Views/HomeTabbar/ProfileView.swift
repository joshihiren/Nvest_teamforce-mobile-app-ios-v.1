//
//  ProfileView.swift
//  TeamForce
//
//  Created by Hiren Joshi on 19/01/21.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            Rectangle()
            Text("Profile View")
                .foregroundColor(OrangeColor)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
