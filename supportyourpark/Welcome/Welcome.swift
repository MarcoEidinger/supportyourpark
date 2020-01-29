import SwiftUI
import UIKit

struct WelcomeCard: View {
    var body: some View {
        ZStack {
            Text("Hello World").foregroundColor(.black)
            Color.red
        }
    }
}

//struct WelcomePageViewController: View {
//
//    @EnvironmentObject var userData: UserData
//    var body: some View {
//        PageViewController(controllers: <#T##[UIViewController]#>, currentPage: <#T##Binding<Int>#>)
//    }
//}
//
//
//struct WelcomePageViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        Home()
//            .environmentObject(UserData())
//    }
//}
