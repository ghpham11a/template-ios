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
    
    @EnvironmentObject
    var appPubs: AppPubs
    
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
                            .padding(0)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 5, leading: 5, bottom: 10, trailing: 5))
                        }
                    }
                    .frame(alignment: .leading)
                } else {
                    Button("Login Bitch") {
                        path.append(Route.auth)
                    }
                }
            }
            .padding(0)
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
                case .proxyCallHub:
                    ProxyCallHubScreen(path: $path)
                case .videoCallHub:
                    VideoCallHubScreen(path: $path)
                case .videoCall(let id):
                    VideoCallScreen(path: $path, id: id, appPubs: appPubs)
                case .chatHub:
                    ChatHubScreen(path: $path)
                case .voiceCallHub:
                    VoiceCallHubScreen(path: $path)
                case .voiceCall(let id):
                    VoiceCallScreen(path: $path, id: id)
                case .schedulerHub:
                    SchedulerHubScreen(path: $path)
                case .schedulerScreen(let userId, let availabilityType):
                    SchedulerScreen(path: $path, userId: userId, availabilityType: availabilityType)
                case .conflicts(let userId, let availabilityType):
                    ConflictsScreen(path: $path, userId: userId, availabilityType: availabilityType)
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
