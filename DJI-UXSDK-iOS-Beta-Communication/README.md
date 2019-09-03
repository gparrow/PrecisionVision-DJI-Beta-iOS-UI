# DJI iOS UX SDK

The DJI UX SDK speeds up development time by providing UI elements for all core functionalities, and by using it in conjunction with the [DJI Mobile SDK](https://developer.dji.com/mobile-sdk/) you can create a customized mobile app to unlock the full potential of your DJI aerial platform. Using the default UX SDK, an application can be created with no additional lines of code; you can also pick and choose which elements you want to use for maximum UI flexibility.

With the UX SDK 5.0 version we are introducing an easy way to customize all the UI elements, as well as extend the base classes to build your own custom widgets. For more details, see the [UX SDK 5.0 overview](https://github.com/dji-sdk/Mobile-UXSDK-Beta-iOS/wiki).

Check out our [sample app](https://github.com/dji-sdk/Mobile-UXSDK-Beta-iOS/UXSDKBetaSample) to get started.

## Installation

Read the [documentation for installation](https://github.com/dji-sdk/Mobile-UXSDK-Beta-iOS/wiki/Installation) to learn more about including this library in your applications. 

## Documentation

You can find the UX SDK documentation on the [wiki](https://github.com/dji-sdk/Mobile-UXSDK-Beta-iOS/wiki). This includes -
* UX SDK 5.0 overview and main concepts
* Documentation for all the individual widgets
* Contribution guidelines
* Where to get support
 
## How to Contribute

As always, the DJI Dev Team is committed to improving your developer experience. Please follow our guidelines on the [How to Contribute](https://github.com/dji-sdk/Mobile-UXSDK-Beta-iOS/wiki/How-to-Contribute) page on our wiki for filling out any bugs or feature requests, or contribute to the code base. If you have any other questions, please send an email to dev@dji.com. We recommend frequently checking the Github repositories for changes and new releases. 

## Future Plans

This Beta 1 release only contains a small subset of UX SDK elements. We are eager to give you a sneak peek, and are very interested in receiving your feedback and suggestions. Please refer to the release notes for the full list of elements that Beta 1 version makes available.

Our long-term plan is for this framework to reach feature parity with the UX SDK 4.10 release. The core team is currently working on porting the remaining widgets and other APIs to the new architecture and we will open source them in additional future Beta releases as they are completed. We welcome your feedback on the architecture and your ideas for addional widgets, including those not included in prior UX SDK releases, as well as your contributions and PRs for any ***currently open-sourced features***.

We are also very excited about the new SwiftUI and Combine frameworks announced at WWDC 2019. Our long-term plans:
* Fully support both ***Swift and Objective-C*** users by providing Swift-friendly and Swift-native APIs where applicable in UX SDK
* Ensure compatibility with SwiftUI via our use of UIKit as the foundation of UX SDK
* Transition to a reactive approach, similar to the DJI Android UX SDK, while maintaining iOS-centric API design conventions and development-style

## License

DJI UX SDK Beta is released under the MIT license. See [LICENSE](https://github.com/dji-sdk/Mobile-UXSDK-Beta-iOS/blob/master/LICENSE) for details.
