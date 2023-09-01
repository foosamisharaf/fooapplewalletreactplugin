# fooapplewalletreactplugin

FooAppleWallet port to react

## Installation

First you need to add the following source lines to your Podfile:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
source 'git@github.com:foodeveloper/foopods.git'
```

Run the followiing command to add fooapplewalletreactplugin package:

```sh
yarn add fooapplewalletreactplugin@ssh://git@github.com:foodeveloper/Hybrid-React-Plugin-Foo-Inapp-Provisioning.git
```

Run pod install inside ios directory:

```sh
cd ios
pod install
```

## Usage

```js
import { setHostName , addCardForUserId , addCardForPanId , type CardUserIdDetails, type CardPanIdDetails, deviceSupportsAppleWallet  } from 'fooapplewalletreactplugin';

// ...
```


---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
