import ProjectDescription

let project = Project(
    name: "StoreIt",
    organizationName: "M O DE ARAUJO TECNOLOGIA DA INFORMACAO LTDA",
    targets: [
        Target(
            name: "StoreIt",
            platform: .iOS,
            product: .app,
            bundleId: "com.turingitservices.storeit",
            infoPlist: "StoreIt/Info.plist",
            sources: ["StoreIt/**"],
            resources: [
                "StoreIt/Resources/**",
            ]
        ),
        Target(
            name: "StoreItTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.turingitservices.storeit.tests",
            sources: ["StoreItTests/**"],
            dependencies: [
                .target(name: "StoreIt")
            ]
        )
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