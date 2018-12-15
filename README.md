# Insta-weather

Simple weather app created with the intention of demonstrating the Bloc library and architecture for Flutter, and to practice some of the basic concepts related to Flutter UI.

# Usage

The app allows the user to retrieve the current weather conditions of the user's location. It allows the user to specify a city by its name and country (support for countries is small, this can be improved in the future), or by using the geolocalization capabilities of the device. Once one of the two methods is used, the details for the specified city are shown in a different screen.

# Features

## Full implementation of the Bloc and Flutter-Bloc libraries to demonstrate how an application can be structured using Events and Streams for communication.
## Usage of the Geolocator library to obtain the current position and a Geocoder to obtain the city name based on that position. This also handles run-time permissions if used on Android devices with Marshmallow or more recent versions.
## Conversion from Celsius to Fahrenheit quantities for temperatures.
## Network calls using the Http library, with a client configuration, abstracted with a Repository and Provider interface, which uses custom Exceptions to handle network errors.
## Ample usage of Stateless and Stateful widgets.
## Nesting of layouts to increase legibility and maintainance of the code base.

# Room for Improvement

Given the restriction of time for the creation of this project, I could not implement the following intended features:
## Use Shared Preferences to store the last queried city and the default system for temperature.
## Improve Navigation to be able to change city without restarting the app.
## Improve the details screen with a prettier design and animations.
