//
//  ContentView+Password.swift
//
//  Created by Hiren Joshi on 17/01/2021.
//  Copyright © 2021 Hiren Joshi. All rights reserved.
//

import SwiftUI
import Combine


struct PasswordToggleField : View {
    typealias Validator = (String) -> String?
    
    @Binding var hidden:Bool
    
    @ObservedObject var field:FieldValidator<String>
    
    init( value:Binding<String>, checker:Binding<FieldChecker>, hidden:Binding<Bool>, validator:@escaping Validator ) {
        self.field = FieldValidator(value, checker:checker, validator:validator )
        self._hidden = hidden
    }

    var body: some View {
        
        VStack {
            Group {
                if( hidden ) {
                    SecureField( "Password", text:$field.value)
                }
                else {
                    TextField( "Password", text:$field.value)
                }
            }
        }
        .onAppear {
            self.field.doValidate()
        }

    }
}

