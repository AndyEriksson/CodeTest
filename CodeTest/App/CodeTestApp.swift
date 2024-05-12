//
//  Created by Andy on 2024-05-07.
//

import SwiftUI

@main
struct CodeTestApp: App {
    
    private let networkService = NetworkService()
    
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: MainViewModel(networkService: networkService))
        }
    }
    
}
