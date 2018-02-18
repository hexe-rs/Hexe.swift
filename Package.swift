import PackageDescription

let package = Package(
    name: "Hexe",
    targets: [
        Target(name: "Hexe", dependencies: ["hexec"]),
    ]
)
