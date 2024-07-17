//
//  BravoScreen.swift
//  Template
//
//  Created by Anthony Pham on 5/20/24.
//

import SwiftUI

struct FeaturesScreen: View {
    
    @StateObject private var viewModel = FeaturesViewModel()
    @State private var selectedTab = 0
    @StateObject private var userRepo = UserRepo.shared
    
    @Binding private var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                if userRepo.isAuthenticated {
                    List {
                        ForEach(viewModel.newItems, id: \.title) { feature in
                            FeaturesCard(title: feature.title, description: feature.description) {
                                path.append(feature.route)
                            }
                        }
                    }
                    .frame(alignment: .leading)
                } else {
                    Button("Login Bitch") {
                        path.append(Route.auth)
                    }
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .auth:
                    AuthHubScreen(path: $path)
                case .authAddInfo(let username):
                    AddNewUserInfoScreen(path: $path, username: username)
                case .authEnterPassword(let username, let status):
                    EnterPasswordScreen(path: $path, username: username, status: status)
                case .authCodeVerification(let verificationType, let username, let password):
                    CodeVerificationScreen(path: $path, verificationType: verificationType, username: username, password: password)
                case .thingIntro:
                    ThingIntroScreen(path: $path)
                case .thing(let thingId):
                    ThingScreen(path: $path, thingId: thingId)
                case .thingBuilder(let thingId, let action, let mode, let steps):
                    ThingBuilderScreen(path: $path, thingId: thingId, action: action, mode: mode, steps: steps, backAction: {
                        path.removeLast()
                    })
                case .filterList:
                    FilterListScreen(path: $path)
                case .uikitView:
                    UIKitViewScreen(path: $path)
                case .mapView:
                    MapScreen(path: $path)
                case .tabbedList:
                    TabbedListScreen(path: $path)
                case .sendPaymentHub:
                    SendPaymentHubScreen(path: $path)
                case .paymentAmount(let accountId):
                    PaymentAmountScreen(path: $path, accountId: accountId)
                default:
                    SnagScreen()
                }
            }
            .onAppear {
                viewModel.fetchItems()
            }
        }
    }
}

//#Preview {
//    FeaturesScreen()
//}
