//
//  SignInFeature.swift
//  SignIn
//
//  Created by 김동준
//

import ComposableArchitecture

public struct SignInFeature: Reducer {
    public init() {}

    public struct State: Equatable {
        public init() {}
    }

    public enum Action {
        case onAppear
    }

    public var body: some ReducerOf<SignInFeature> {
        Reduce { _, action in
            switch action {
            case .onAppear:
                break
            }
            return .none
        }
    }
}
