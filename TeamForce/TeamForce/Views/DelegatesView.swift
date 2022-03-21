import SwiftUI

struct DelegatesView: View, MyProtocol {
    @State var text: String = "My Text"
    var body: some View {
        NavigationView {
            VStack {
                Text(text)
                NavigationLink(destination: SecondView(delegate: self)) {
                    Text("2nd View")
                }
            }
        }
    }
    
    func myFunc() {
        text = "Changed Text"
    }
}

protocol MyProtocol {
    func myFunc()
}

struct SecondView: View {
    var delegate: MyProtocol
    var body: some View {
        Button(action: {
            self.delegate.myFunc()
        }) {
            Text("ChangeText")
        }
    }
}

struct DelegatesView_Previews: PreviewProvider {
    static var previews: some View {
        DelegatesView()
    }
}
