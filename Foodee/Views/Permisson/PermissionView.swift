

import SwiftUI

struct PermissionView: View {
    
    @State var isAnimating = false
    var body: some View {
        GeometryReader{ proxy in
            VStack{
                
                ZStack{
                    ForEach(1..<14){i in             // adding ForEach loop to loop                                      over all the images.
                        Image("food\(i % 7)")
                            .position(
                                x: .random(in: 0...proxy.size.width),
                                y: .random(in: 0...proxy.size.height / 2)
                            )
                            .animation(
                                    .interpolatingSpring(stiffness: 0.5, damping: 0.5)
                                    .repeatForever()
                                    .delay(isAnimating ? .random(in: 0...1): 0)
                                    .speed(isAnimating ? .random(in: 0...1): 0)
                            )
                    }
                    
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
        }.onAppear{
            isAnimating.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionView()
    }
}
