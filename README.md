# Server Monitoring Notifications

**Author:** Mustapha Friha

## Executive Summary
Most of the commercial enterprise server monitoring tools just send email notifications and/or open a server incident ticket to alert interested recipients when specific conditions are raised. Those tools are expensive and hard to customize to meet the specific needs of a company.

I am going to develop a simple and easy a real time server monitoring solution for this class project. I came up with this class project idea from a recent work experience.  There was no monitoring of the server's system resources like disk usage. The server was accessed manually everyday and its system resources checked. Automated alerts were needed to notify any issues about the health of the server. I will simply call the application: Server Monitoring Notifications. Because of the time constraints to deliver this project, the app will not be a fully fledged monitoring tool but it will lay the groundwork of a tool monitoring notifications system. 

One of the goal of the app is to have it available on different platforms. The app will be developed as an hybrid app which can be run on iOS and Android mobile devices and also and on the web. Having a single codebase for all platforms makes it much more easy to develop and maintain the app. I will be using Flutter SDK for the UI. The Flutter framework uses the Dart language. Both are open source frameworks developed by Google and they are one of the preferred hybrid development frameworks by mobile and web developers. Some of the features and qualities of Flutter are: rich library of widgets, high productivity, great performance, fast and simple development with hot reload capability to view instantly the changes.

Google Firebase platform will also be used. The following Firebase services will be used:
* Firebase authentication services will provide the sign-in mechanisms to the app. 
* Firebase cloud firestore (cloud-hosted NoSQL database) will store information about the mobile devices and/or web client interested in receiving server monitoring notifications. 
* Firebase Cloud Messaging (FCM) will be used as a router (dispatcher) of the notifications to the mobile devices and/or web clients.  

Those Firebase services are needed to build the app fast, without managing infrastructure.

The server monitoring services will run as a Spring Boot micro services on the server. The Spring Boot services will integrate with Firebase Cloud Messaging (FCM) to push the monitoring notifications to the mobile devices and/or web clients. 

The Server Monitoring Notifications app will be tested using an Android device. If time permits, I will again test the app using the web client version produced from the same codebase.  

## Installation
 
###Instructions for end-user

- User will need to install the Server Monitoring Notifications Android Package Kit (APK) on the Android mobile device.  
Not needed - User will need to signup to the app using an email address and password combination.
Not needed - User will receive a verification email sent to the email address used during the signup. 
Not needed - User will need to confirm the email address by clicking the link sent in the verification email.

Instructions for admin user
---------------------------

- Admin user will need to create the list of app users in Firestore Authentication services using email address/password 
  authentication mechanism. 

No need - Admin user has access to the user sign in authentication information stored on the Firestore database. 
  Admin functions such as password reset, disable account and delete account are available.
  
- Admin user will need to set up a cloud Firestore database users collection . 
  This NoSQL database collection will have the following user fields: uid, email, fcmToken (device or web client FCM registration key)

