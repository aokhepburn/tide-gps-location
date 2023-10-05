<p align="center">
  <a href="https://github.com/apple/swift"><img src="https://img.shields.io/badge/Swift-FA7343?style=for-the-badge&logo=swift&logoColor=white"></a>   
  <a href=""><img src="https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white"></a>    
  <a href="https://developer.apple.com/xcode/resources/"><img src="https://img.shields.io/badge/Xcode-007ACC?style=for-the-badge&logo=Xcode&logoColor=white"></a>
  <a href="https://github.com/firebase/firebase-ios-sdk"><img src="https://img.shields.io/badge/firebase-ffca28?style=for-the-badge&logo=firebase&logoColor=black"></a>
</p>

<h1 align="center">TIDAL INFORMATION FOR NY HARBOR</h1>
<h3 align="center">A demonstration of a full-stack mobile application for iOS devices that can use GPS data to provide up to date NOAA information.</h3>

## Introduction

This application gives up to date tidal information in New York Harbor based off of a phone's GPS. Given New York's confluence of rivers and its many currents this app attempts to pin point a user's location and give accurate information for the present tidal situation and surface currents that may affect navigation.

Historically there is fantastic observed data that has been working for hundreds of years, that said, it can be clunky to work with so I have tried to make an uncomplicated app that pulls information from NOAA for up to the minute tidal information that is responsive to a user's need in the moment.

## Summary

Utilizing NOAA's <a href="https://tidesandcurrents.noaa.gov/">current predictions</a> the user's GPS location is correlated with the tidal prediction station that is relevant for the user. This is information that is updated automatically as the user's GPS location changes.

<img align="center" src="/demo-assets/gps-onchange-demo.gif"/>

User's can also access current speed in knots from the various check-ins around the harbor. Due to the complexity of these speeds, and how the currents interact with each other I have decided to allow this information to be controlled by the user.

<img align="center" src="/demo-assets/speed-demo.gif"/>

## Future Features

- Adding functionality to the map annotations to allow user's to see the current speed data as they click on the pin.
- A view for looking at the traditional current maps which show the different speeds all over the harbor based on the hour from high or low tide.
- Ability to move the timeline forward, and interactively drop a pin to plan for the future.
- Integrating OpenSeaMaps to replace the basic AppleMaps I am currently using to which has more relevant maritime data.
