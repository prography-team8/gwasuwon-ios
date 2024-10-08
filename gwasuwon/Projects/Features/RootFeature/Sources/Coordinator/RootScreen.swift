//
//  RootScreen.swift
//  RootFeature
//
//  Created by 김동준 on 6/6/24
//

import ComposableArchitecture
import SignInFeature
import SignUpFeature
import HomeFeature

@Reducer
public struct RootScreen {
    public enum State: Equatable {
        case signIn(SignInFeature.State)
        case signUp(SignUpFeature.State)
        case home(HomeFeature.State)
        case signUpRole(SignUpRoleFeature.State)
        case signUpComplete(SignUpCompleteFeature.State)
        case addClass(AddClassFeature.State)
        case addClassDetail(AddClassDetailFeature.State)
        case addClassDone(AddClassDoneFeature.State)
        case detailClass(DetailClassFeature.State)
        case qrCode(QRFeature.State)
        case qrGenerator(QRGenerationFeature.State)
        case editClass(EditClassFeature.State)
    }

    public enum Action {
        case signIn(SignInFeature.Action)
        case signUp(SignUpFeature.Action)
        case home(HomeFeature.Action)
        case signUpRole(SignUpRoleFeature.Action)
        case signUpComplete(SignUpCompleteFeature.Action)
        case addClass(AddClassFeature.Action)
        case addClassDetail(AddClassDetailFeature.Action)
        case addClassDone(AddClassDoneFeature.Action)
        case detailClass(DetailClassFeature.Action)
        case qrCode(QRFeature.Action)
        case qrGenerator(QRGenerationFeature.Action)
        case editClass(EditClassFeature.Action)

    }

    public init() {}
    public var body: some ReducerOf<RootScreen> {
        Scope(state: \.signIn, action: \.signIn) {
            SignInFeature()
        }
        Scope(state: \.signUp, action: \.signUp) {
            SignUpFeature()
        }
        Scope(state: \.home, action: \.home) {
            HomeFeature()
        }
        Scope(state: \.signUpRole, action: \.signUpRole) {
            SignUpRoleFeature()
        }
        Scope(state: \.signUpComplete, action: \.signUpComplete) {
            SignUpCompleteFeature()
        }
        Scope(state: \.addClass, action: \.addClass) {
            AddClassFeature()
        }
        Scope(state: \.addClassDetail, action: \.addClassDetail) {
            AddClassDetailFeature()
        }
        Scope(state: \.addClassDone, action: \.addClassDone) {
            AddClassDoneFeature()
        }
        Scope(state: \.detailClass, action: \.detailClass) {
            DetailClassFeature()
        }
        Scope(state: \.qrCode, action: \.qrCode) {
            QRFeature()
        }
        Scope(state: \.qrGenerator, action: \.qrGenerator) {
            QRGenerationFeature()
        }
        Scope(state: \.editClass, action: \.editClass) {
            EditClassFeature()
        }
    }
}
