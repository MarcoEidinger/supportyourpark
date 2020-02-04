import SwiftUI
import URLImage

struct CircleImage: View {
    var imageURL: URL?
    
    var body: some View {
        URLImage(imageURL!,
                 delay: 0.10,
                 processors: [ Resize(size: CGSize(width: 75.0, height: 75.0), scale: UIScreen.main.scale) ],
                 content: {
                    $0.image
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
        })
    }
}
