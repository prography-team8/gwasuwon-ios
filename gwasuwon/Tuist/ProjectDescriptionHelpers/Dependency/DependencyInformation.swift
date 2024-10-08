//
//  DependencyInformation.swift
//  ProjectDescriptionHelpers
//
//  Created by 김동준 on 5/30/24
//

import Foundation

let dependencyInfo: [DependencyInformation: [DependencyInformation]] = [
    .App: [.RootFeature, .DI, .Data, .KakaoSDKUser],
    .RootFeature: [.SignInFeature, .SignUpFeature, .HomeFeature, .ComposableArchitecture, .TCACoordinators],
    .BaseFeature: [.ComposableArchitecture],
    .SignInFeature: [.DesignSystem, .ComposableArchitecture, .BaseFeature, .Domain],
    .SignUpFeature: [.DesignSystem, .ComposableArchitecture, .BaseFeature, .Domain],
    .HomeFeature: [.DesignSystem, .ComposableArchitecture, .BaseFeature, .Domain, .QRScanner, .Util],
    .Domain: [.DI, .Dependencies],
    .Data: [.Domain, .KakaoSDKUser],
    .DI: [.Swinject],
    .QRScanner: [],
    .DesignSystem: [.Util]
]

public enum DependencyInformation: String {
    case App = "App"
    case RootFeature = "RootFeature"
    case BaseFeature = "BaseFeature"
    case SignInFeature = "SignInFeature"
    case SignUpFeature = "SignUpFeature"
    case HomeFeature = "HomeFeature"
    case ComposableArchitecture = "ComposableArchitecture"
    case DesignSystem = "DesignSystem"
    case TCACoordinators = "TCACoordinators"
    case Domain = "Domain"
    case Data = "Data"
    case DI = "DI"
    case Swinject = "Swinject"
    case Dependencies = "Dependencies"
    case QRScanner = "QRScanner"
    case KakaoSDKUser = "KakaoSDKUser"
    case Util = "Util"
}

public enum UtilsDependencyInformation: String, CaseIterable {
    case QRScanner = "QRScanner"
    case Util = "Util"
}
