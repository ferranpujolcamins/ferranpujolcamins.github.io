---
layout: post
title:  "Generating a macOS bundle for Mixxx"
excludeFromMenu: true
---

<div class="banner">
This post is still a work in progress
</div>

[Mixxx](https://mixxx.org/) is an open source Dj software that uses
[CMake](https://cmake.org/) as its build system. In this post I describe my experience learning about macOS bundles, how CMake deals with them, and solving the problem of generating a macOS bundle for Mixxx.
This is not a concise step by step guide, but rather an extensive description of everything I've learnt,
every problem I've faced, every reference I've read and every solution I've tried.

**This post only reflects my experience solving this problem for Mixxx. For other applications and environments, your mileage my vary.**

## What are macOS bundles?<sup>[[1]](#ref-bundle-programming-guide)</sup>

A bundle is just a directory with a specific structure that
contains executable code and the resources needed by that code.
The operating system treats such directories in special ways. For example, a macOS
app is a bundle (i.e. a directory). However, macOS presents you the app
as a single unit, as it was a file, in order to prevent users to accidentally
modify important resources of the app and breaking it.

There are different [types of bundles](https://developer.apple.com/library/archive/documentation/CoreFoundation/Conceptual/CFBundles/AboutBundles/AboutBundles.html#//apple_ref/doc/uid/10000123i-CH100-SW7). Depending on its structure and contents
a bundle can be:

- An application bundle
- A framework bundle
- A plug-in bundle

For the task at hand we are only concerned about application bundles.

### Structure of an application bundle<sup>[[1.1]](#ref-application-bundles)</sup>
A Mac app bundle has a simple basic structure: there's a top-level directory named Contents. All the contents of the bundle are inside this directory, including the resources, executable code, private frameworks, private plug-ins and support files that the application needs.

**The basic structure of a macOS application**
```
MyApp.app/
   Contents/
      Info.plist
      MacOS/
      Resources/
```

The *Info.plist* file holds configuration information for the application. macOS looks into this file to gather relevant information about your application.

The *MacOS* directory contains the standalone executable code of the application. In most cases, this directory contains only one binary file: your application's main executable. **However, you can also put additional standalone executables (such as command-line tools) in this directory**.

The *Resources* directory contains all of the application’s resource files. Resources are data files that live outside your application’s executable file like images, icons, sounds, strings files, configuration files, and data files (among others).

## Generating a bundle with CMake and CPack

*CPack* is a tool that helps creating installers or installation packages for our application
for each operating system we support.

Just like CMake has several *generators* to write the input files for several build systems,
CPack ha several *generators* to create different types of packages and installers
for different platforms<sup>[[2]](#ref-packaging-with-cpack)</sup>.
There are two main generators for macOS bundles: the *DragNDrop* generator and the *Bundle* generator.

The *DragNDrop* generator does not allow multiple executables inside a single bundle; it enforces a 1:1 bundle-to-executable relationship.<sup>[[3]](#ref-drag-n-drop-package-generator)</sup>

On the other hand, the *Bundle* generator does support multiple executables inside a single bundle. This is the generator we are going to use with Mixxx. The reason being that the [Aoide music library management system](https://gitlab.com/uklotzde/aoide-rs) will probably be integrated with Mixxx in the not so distant future, and this will require Mixxx to ship with a binary for the Aoide server.

CPack is a standalone executable that reads a configuration file usually named `CPackConfig.cmake`.
However, CMake comes with a CPack module, which will automatically generate an
appropriate CPack configuration file<sup>[[2.1]](#ref-using-cpack-with-cmake)</sup>.
The only thing we need to do to set it up is to include the module in our CMakeLists.txt:
```cmake
include(CPack)
```

In order to use the CPack Bundle generator we need to define three CMake variables<sup>[[4]](#ref-cpack-bundle-generator)</sup>:

- `CPACK_BUNDLE_NAME`: The bundle name
- `CPACK_BUNDLE_ICON`: The bundle icon
- `CPACK_BUNDLE_PLIST`: The bundle plist

We must set these variables before we include CPack in order for them to take effect.

## References

<ol class="nestedList">
    <li>
        <span id="ref-bundle-programming-guide" class="ref">
            <a href="https://developer.apple.com/library/archive/documentation/CoreFoundation/Conceptual/CFBundles/Introduction/Introduction.html">Bundle Programming Guide <small>(developer.apple.com)</small></a>
        </span>
        <ol class="nestedList">
            <li>
                <span id="ref-application-bundles" class="ref">
                    <a href="https://developer.apple.com/library/archive/documentation/CoreFoundation/Conceptual/CFBundles/BundleTypes/BundleTypes.html#//apple_ref/doc/uid/10000123i-CH101-SW13">Application Bundles</a>
                </span>
            </li>
        </ol>
    </li>
    <li>
        <span id="ref-packaging-with-cpack" class="ref">
            <a href="https://gitlab.kitware.com/cmake/community/-/wikis/doc/cpack/Packaging-With-CPack">Packaging with CPack <small>(gitlab.kitware.com/cmake)</small></a>
        </span>
        <ol class="nestedList">
            <li>
                <span id="ref-using-cpack-with-cmake" class="ref">
                    <a href="https://gitlab.kitware.com/cmake/community/-/wikis/doc/cpack/Packaging-With-CPack#using-cpack-with-cmake">Using CPack with CMake</a>
                </span>
            </li>
        </ol>
    </li>
    <li>
        <span id="ref-drag-n-drop-package-generator" class="ref">
            <a href="https://gitlab.kitware.com/cmake/community/-/wikis/doc/cpack/PackageGenerators#dragndrop-osx-only">DragNDrop Package generator <small>(gitlab.kitware.com/cmake)</small></a>
        </span>
    </li>
    <li>
        <span id="ref-cpack-bundle-generator" class="ref">
            <a href="https://cmake.org/cmake/help/git-stage/cpack_gen/bundle.html">CPack Bundle Generator  <small>(cmake.org)</small></a>
        </span>
    </li>
    <li>
        <span class="ref">
            <a href="https://stackoverflow.com/a/44629910">MACOSX_BUNDLE vs CPACK_BUNDLE <small>(stackoverflow.com)</small></a>
        </span>
    </li>
</ol>