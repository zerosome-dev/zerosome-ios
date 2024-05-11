import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/


public extension Project {
    /// 프로젝트 정의하는 함수 생성
    static func makeProject(
        name: String,
        organizationName: String = Environment.organizationName,
        targets: [Target],
        isXconfigSet: Bool = false,
        additionalFiles: [FileElement] = []
    ) -> Project {
        guard !targets.isEmpty else { return .init(name: "ErrorProject")}
        
        // target이 앱인 경우에만 사용
        let isProductApp = targets.contains { target in target.product == .app }
        
        // target -> app인 경우에만 Setting
        var setting: Settings?
        if isProductApp, isXconfigSet {
            setting = Settings.settings(configurations: [
                .debug(name: "Debug", xcconfig: .relativeToRoot("Projects/App/Resources/Config/Secrets.xcconfig")),
                .release(name: "Release", xcconfig: .relativeToRoot("Projects/App/Resources/Config/Secrets.xcconfig")),
            ], defaultSettings: .recommended)
        } else {
            setting = .settings(base: [:],
                                configurations: [.debug(name: .debug),
                                                 .release(name: .release)],
                                defaultSettings: .recommended)
        }
        
        var scheme: [Scheme] = []
        if isProductApp {
            scheme =  [.makeScheme(target: .debug, name: name)]
        }
        
        return Project(
            name: name,
            organizationName: organizationName,
            options: .options(
                defaultKnownRegions: ["en", "ko"],
                developmentRegion: "ko"
            ),
            settings: setting,
            targets: targets,
            schemes: scheme,
            additionalFiles: additionalFiles
        )
    }
}
