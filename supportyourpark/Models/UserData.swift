import Combine
import SwiftUI

final class UserData: ObservableObject {
    @Published var showFavoritesOnly = false
    @Published var parks: [Park] = loadLocalParksFromFile()
}
