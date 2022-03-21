//
//  VerificationView.swift
//  TeamForce
//
//  Created by Hiren Joshi on 29/01/21.
//

import SwiftUI

struct VerificationView: View {
    var body: some View {
        ZStack {
            PasscodeFieldView(maxDigits: 6, label: "Enter your pin which we sent on +91 1234567890", pin: "", showPin: false) { (enterpin) in
                print(enterpin)
            }
        }
        .animation(.default)
        .navigationBarHidden(false)
        .navigationBarTitle("")
    }
}

struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationView()
    }
}
