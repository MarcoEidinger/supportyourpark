import Combine
import SwiftUI

final class UserData: ObservableObject {
    @Published var parks: [Park] = loadLocalParksFromFile()

    init() {
        _ = loadDonationOptionsFromFile()
    }
}
