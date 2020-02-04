import SwiftUI
import UIKit

struct WelcomeView: View {
    var body: some View {
        VStack {
            PageView([WelcomeCard(), WelcomeCard()]).aspectRatio(3 / 2, contentMode: .fit).background(Color.black)
            Button(action: {
                print("Done")
            }) {
                Text("Press me")
            }
        }
    }
}

struct WelcomeCard: View {
    var body: some View {
        Image("TestMeep")
            .resizable()
//            .aspectRatio(3 / 2, contentMode: .fit)
            .overlay(TextOverlayText())
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
