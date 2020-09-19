---
layout: post
title:  "Generating a macOS bundle for Mixxx"
---

**~~~~~~~REWRITE INTRO**

[Mixxx](https://mixxx.org/) is an open source Dj software that relies on
[CMake](https://cmake.org/) to be built. I'm one of the few contributors with access to a Mac computer, so I took the task
of generating the macOS bundle for the application. I've never worked with CMake or macOS bundles before, so this was a good opportunity for me to learn more.

In this post I describe my experience learning CMake and macOS bundles and solving the problem of generating a macOS bundle for Mixxx.
This is not a concise step by step guide, but rather an extensive description of everything I've learnt,
every problem I've faced, every reference I've read and every solution I've tried.

**This post only reflects my experience solving this problem for Mixxx. For other applications and environments, your mileage my vary.**

## What are macOS bundles?

A bundle is just a directory with a specific structure that
holds executable code and the resources used by that code<sup>[[1]](#ref-bundle-programming-guide)</sup>.
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

**XXXX Explain that a bundle can contain more than one executable. One bundle with several executables vs several bundles
Is this applicable to the specific case of app bundle**

## Generating a bundle with CMake and CPack

*CPack* is a tool that helps creating installers or installation packages for our application
for each operating system we support.

Just like CMake has several *generators* to write the input files for several build systems,
CPack ha several *generators* to create different types of packages and installers
for different platforms<sup>[[2]](#ref-packaging-with-cpack)</sup>.

There are two main generators for macOS bundles: the *DragNDrop* generator and the *Bundle* generator.

CPack is a standalone tool that reads a configuration file usually named CPackConfig.cmake.
However, CMake comes with a CPack module, which will automatically generate an
appropriate CPack configuration file<sup>[[2.1]](#ref-using-cpack-with-cmake)</sup>.
The only thing we need to do to set it up is to include the module in our CMakeLists.txt:
```cmake
include(CPack)
```

In order to use the CPack Bundle generator we need three things, each defined in a CMake variable<sup>[[3]](#ref-cpack-bundle-generator)</sup>:

- `CPACK_BUNDLE_NAME`: The bundle name
- `CPACK_BUNDLE_ICON`: The bundle icon
- `CPACK_BUNDLE_PLIST`: The bundle plist

We must set these variables before we include CPack in order for them to take effect.

## Acknowledgements

I want to thank Jan Holthuis. A lot of what's described in this post
is based on his previous work trying to generate a macOS
bundle, while he had no access to a Mac!

I want to also thank the Mixxx community for their collective work
in making the best Dj software in the world and their relentless will to help
fellow developers.

## References

1. <span id="ref-bundle-programming-guide" class="ref">[Bundle Programming Guide (developer.apple.com)](https://developer.apple.com/library/archive/documentation/CoreFoundation/Conceptual/CFBundles/Introduction/Introduction.html)</span>
2. <span id="ref-packaging-with-cpack" class="ref">[Packaging with CPack (gitlab.kitware.com/cmake)](https://gitlab.kitware.com/cmake/community/-/wikis/doc/cpack/Packaging-With-CPack)</span>
    1. <span id="ref-using-cpack-with-cmake" class="ref">[Using CPack with CMake](https://gitlab.kitware.com/cmake/community/-/wikis/doc/cpack/Packaging-With-CPack#using-cpack-with-cmake)</span>
3. <span id="ref-cpack-bundle-generator" class="ref">[CPack Bundle Generator (cmake.org)](https://cmake.org/cmake/help/git-stage/cpack_gen/bundle.html)</span>

https://gitlab.kitware.com/cmake/community/-/wikis/doc/cpack/PackageGenerators#dragndrop-osx-only

9. <span class="ref">[MACOSX_BUNDLE vs CPACK_BUNDLE](https://stackoverflow.com/a/44629910)</span>