import Foundation
import Prelude
import Lib
import HTML

struct BundleMixxxReferences: Default, ReferencesProtocol {
    private(set) var bundleProgrammingGuide = TreeLabel<Reference>()
    private(set) var applicationBundles = TreeLabel<Reference>()
    private(set) var packagingWithCPack = TreeLabel<Reference>()
    private(set) var usingCPackWithCMake = TreeLabel<Reference>()
    private(set) var dragNDropPackageGenerator = TreeLabel<Reference>()
    private(set) var cPackBundleGenerator = TreeLabel<Reference>()
    private(set) var macOSXBundleVsCPackBundle = TreeLabel<Reference>()

    private(set) var references: References = []

    init() {
        references = build()
    }

    @TreeBuilder
    func build() -> References {
        bundleProgrammingGuide(name: "Bundle Programming Guide", url: "https://developer.apple.com/library/archive/documentation/CoreFoundation/Conceptual/CFBundles/Introduction/Introduction.html") {

            applicationBundles(name: "Application Bundles", url: "https://developer.apple.com/library/archive/documentation/CoreFoundation/Conceptual/CFBundles/BundleTypes/BundleTypes.html#//apple_ref/doc/uid/10000123i-CH101-SW13")
        }
        packagingWithCPack(name: "Packaging with CPack", url: "https://gitlab.kitware.com/cmake/community/-/wikis/doc/cpack/Packaging-With-CPack") {
            usingCPackWithCMake(name: "Using CPack with CMake", url: "https://gitlab.kitware.com/cmake/community/-/wikis/doc/cpack/Packaging-With-CPack#using-cpack-with-cmake")
        }
        dragNDropPackageGenerator(name: "DragNDrop Package generator", url:"https://gitlab.kitware.com/cmake/community/-/wikis/doc/cpack/PackageGenerators#dragndrop-osx-only")
        cPackBundleGenerator(name: "CPack Bundle Generator", url: "https://cmake.org/cmake/help/git-stage/cpack_gen/bundle.html")
        macOSXBundleVsCPackBundle(name: "MACOSX_BUNDLE vs CPACK_BUNDLE", url: "https://stackoverflow.com/a/44629910")
    }
}

var generatingAMacOSBundleForMixxx = WithReferences<Post, BundleMixxxReferences> { ref in
    Post(
        date: Date(day: 9, month: 10, year: 2020),
        rawTitle: "Generating a macOS bundle for Mixxx",
        abstract: """
                    In this post I describe my experience learning CMake and macOS bundles and solving the problem of generating a macOS bundle for Mixxx.
                    This is not a concise step by step guide, but rather an extensive description of everything I've learnt,
                    every problem I've faced, every reference I've read and every solution I've tried.
        """,
        sections: {
            Section(body: """
                            [Mixxx](https://mixxx.org/) is an open source Dj software that relies on
                            [CMake](https://cmake.org/) to be built. I'm one of the few contributors with access to a Mac computer, so I took the task
                            of generating the macOS bundle for the application. I've never worked with CMake or macOS bundles before, so this was a good opportunity for me to learn more.

                            In this post I describe my experience learning CMake and macOS bundles and solving the problem of generating a macOS bundle for Mixxx.
                            This is not a concise step by step guide, but rather an extensive description of everything I've learnt,
                            every problem I've faced, every reference I've read and every solution I've tried.

                            **This post only reflects my experience solving this problem for Mixxx. For other applications and environments, your mileage my vary.**
            """)
            Section(title: "What are macOS bundles?\(ref.bundleProgrammingGuide)",
                    body: """
                            A bundle is just a directory with a specific structure that
                            holds executable code and the resources used by that code.
                            The operating system treats such directories in special ways. For example, a macOS
                            app is a bundle (i.e. a directory). However, macOS presents you the app
                            as a single unit, as it was a file, in order to prevent users to accidentally
                            modify important resources of the app and breaking it.

                            There are different [types of bundles](https://developer.apple.com/library/archive/documentation/CoreFoundation/Conceptual/CFBundles/AboutBundles/AboutBundles.html#//apple_ref/doc/uid/10000123i-CH100-SW7). Depending on its structure and contents
                            a bundle can be:

                            - An application bundle
                            - A framework bundle
                            - A plug-in bundle

                            However, for the task at hand we are only concerned about application bundles.
                """) {
                Section(title: "Structure of an application bundle\(ref.applicationBundles)",
                        body: """
                                The basic structure of a Mac app bundle is very simple. At the top-level of the bundle there is a directory named Contents. This directory contains everything, including the resources, executable code, private frameworks, private plug-ins, and support files needed by the application.

                                **The basic structure of a macOS application**
                                ```
                                MyApp.app/
                                   Contents/
                                      Info.plist
                                      MacOS/
                                      Resources/
                                ```

                                The *Info.plist* file contains configuration information for the application. The system relies on the presence of this file to identify relevant information about your application and any related files.

                                The *MacOS* directory contains the application’s standalone executable code. Typically, this directory contains only one binary file with your application’s main entry point and statically linked code. **However, you may put other standalone executables (such as command-line tools) in this directory as well**.

                                The *Resources* directory contains all of the application’s resource files. Resources are data files that live outside your application’s executable file like images, icons, sounds, strings files, configuration files, and data files (among others).
                    """)
            }
        }
    )
}

