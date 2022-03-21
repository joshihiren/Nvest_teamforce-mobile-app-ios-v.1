//
//  NormalTextField.swift
//
//  Created by Hiren Joshi on 2020/01/08.
//  Copyright © 2020 Hiren Joshi. All rights reserved.
//

import SwiftUI

struct NormalTextField: View {
    
    var placeholder:String = ""
    var text:Binding<String>
    
    
    init(_ placeholder:String, text: Binding<String>) {
        self.placeholder = placeholder
        self.text = text
    }
    
    var body: some View {
        TextField(self.placeholder, text: self.text)
    }
    
}

struct SecureTextField: View {
    
    var placeholder:String = ""
    var text:Binding<String>
    
    
    init(_ placeholder:String, text: Binding<String>) {
        self.placeholder = placeholder
        self.text = text
    }
    
    var body: some View {
        SecureField(self.placeholder, text: self.text)
    }
    
}
