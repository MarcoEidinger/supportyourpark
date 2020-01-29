import SwiftUI

struct FeatureCard: View {
    var park: Park
    
    var body: some View {
        park.featureImage?
            .resizable()
            .aspectRatio(3 / 2, contentMode: .fit)
            .overlay(TextOverlay(park: park))
    }
}

struct TextOverlay: View {
    var park: Park
    
    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [Color.black.opacity(0.6), Color.black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center)
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle().fill(gradient)
            VStack(alignment: .leading) {
                Text(park.name)
                    .font(.title)
                    .bold()
                Text(park.park)
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}

struct FeatureCard_Previews: PreviewProvider {
    static var previews: some View {
        FeatureCard(park: features[0])
    }
}
