import ProjectDescription

let infoPlist: [String: Plist.Value] = [
    "CFBundleShortVersionString": "1.0",
    "CFBundleVersion": "1",
    "UIBackgroundModes": "remote-notification",
    "UILaunchStoryboardName": "LaunchScreen"
]

let baseSettings: SettingsDictionary = [
    "ENABLE_PREVIEWS": "YES",
    "DEVELOPMENT_TEAM": "29346794D4",
    "ASSETCATALOG_COMPILER_APPICON_NAME": "AppIcon",
    "CURRENT_PROJECT_VERSION": "1",
    "GENERATE_INFOPLIST_FILE": "YES"
]

let baseProjectSettings: SettingsDictionary = [:]

func debugSettings() -> SettingsDictionary {
    var settings = baseSettings
    settings["ENABLE_TESTABILITY"] = "YES"
    return settings
}

func releaseSettings() -> SettingsDictionary {
    var settings = baseSettings
    return settings
}

func debugProjectSettings() -> SettingsDictionary {
    var settings = baseProjectSettings
    settings["MTL_ENABLE_DEBUG_INFO"] = "INCLUDE_SOURCE"
    settings["ONLY_ACTIVE_ARCH"] = "YES"
    settings["SWIFT_OPTIMIZATION_LEVEL"] = "Onone"
    return settings
}

func releaseProjectSettings() -> SettingsDictionary {
    var settings = baseProjectSettings
    settings["VALIDATE_PRODUCT"] = "YES"
    settings["MTL_ENABLE_DEBUG_INFO"] = "NO"
    settings["SWIFT_COMPILATION_MODE"] = "wholemodule"
    return settings
}

let project = Project(
    name: "StoreIt",
    organizationName: "M O DE ARAUJO TECNOLOGIA DA INFORMACAO LTDA",
    settings: .settings(configurations: [
        .debug(name: "Debug", settings: debugProjectSettings()),
        .release(name: "Release", settings: releaseProjectSettings())
    ]),
    targets: [
        Target(
            name: "StoreIt",
            destinations: [.iPhone, .iPad],
            product: .app,
            bundleId: "com.turingitservices.storeit",
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["StoreIt/**"],
            resources: [
                "StoreIt/Resources/**",
            ],
            entitlements: "StoreIt/StoreIt.entitlements",
            settings: .settings(configurations: [
                .debug(name: "Debug", settings: debugSettings()),
                .release(name: "Release", settings: releaseSettings())
            ])
        ),
        Target(
            name: "StoreItTests",
            destinations: [.iPhone],
            product: .unitTests,
            bundleId: "com.turingitservices.storeit.tests",
            infoPlist: .default,
            sources: ["StoreItTests/**"],
            dependencies: [
                .target(name: "StoreIt")
            ]
        ),
    ],
    schemes: [
        Scheme(
            name: "StoreIt-Debug",
            shared: true,
            buildAction: .buildAction(targets: ["StoreIt"]),
            testAction: .targets(["StoreItTests"]),
            runAction: .runAction(executable: "StoreIt")
        ),
        Scheme(
            name: "StoreIt-Release",
            shared: true,
            buildAction: .buildAction(targets: ["StoreIt"]),
            runAction: .runAction(executable: "StoreIt")
        )
    ]
)
