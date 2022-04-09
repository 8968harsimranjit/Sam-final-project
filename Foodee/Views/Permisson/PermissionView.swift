

import SwiftUI

struct PermissionView: View {
    var body: some View {
        GeometryReader{ proxy in
            VStack{
                
                ZStack{
                    Image("food1")
                }.frame(height:proxy.size.height / 3)
                
                Text("Foodee")
                    .font(.title)
                
                Text("Find delicious food near you")
                    .font(.headline)
                
                Spacer()
                
                Button(action: {}) {
                    Text("Get Started")
                }
                .padding()
                .frame(width: proxy.size.width - 50)
                .background(Color.yellow)
                .cornerRadius(50)
                .shadow(radius: 10)
                .foregroundColor(.white)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionView()
    }
}
