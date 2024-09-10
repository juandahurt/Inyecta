# Inyecta
This is just a VERY simple dependencies injector.

## Usage

```swift
// first, create a container
let container = Container
// and then, you can register a service
container.register {
    YourService()
}

// ...
// when you want to get an instance of a certain service
let service = container.resolve(YourService.self) // notice that this funtion returns an optional
```

### Registration type
There are **two** options for registering a service: 
- Singleton: You will always get the same instance.
- Factory: The closure that you passed on the registration will be called every time you try to resolve the instance. 


That's it :)