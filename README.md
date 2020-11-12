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
 
**Instructions for end user**
* User will need to install the Server Monitoring Notifications Android Package Kit (APK) on the Android mobile device.  

**Instructions for admin user**

* Admin user will need to create the list of app users in Firestore Authentication services using email address/password authentication mechanism. The password will be the default password and it can be reset by the end user. 
  
* Admin user will need to set up a cloud Firestore database users collection.  
  This NoSQL database collection will have the following user fields: uid, email, fcmToken (device or web client FCM registration key)
  
* Admin user will need to set up the Firestore Cloud Messaging.  

## Getting Started
* User sign in to the android app using his/her email/password combination created by the Admin user. User has the option to set a new password.
* Admin user starts the Spring Booot micro services to send the server monitoring notifications. 

## License
Copyright (C) Mustapha Friha 2020. 

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />This app is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.


## User Stories
* As a User, I am presented with a page to login to the app on Android phone

As a **User**, I want to **view the login page on Android phone** so I can **log in to the app**.  
** Acceptance criteria**
   * Login page is displayed

As a **User**, I want to **reset my default app password** so I can **log in to the app with the new password**.  
** Acceptance criteria**
   * Reset password link displayed on the Login page
   * Clicking on the reset password link will send an email to the user to change the password
   * User is able to login using the new password

As a **User**, I want to **log in to the app** so I can **view the notifications**.  
** Acceptance criteria**
   * User is able to login using his credentials (email/password)
   * Error message is displayed in case of logging error (wrong email or password)
   
As a **User**, I want to **view the list of notifications** so I can **review the server issues**.  
** Acceptance criteria**
   * The list page of notifications is displayed. 
   * The list is refreshed automatically when new notifications are added
   * The list page contain a link to view the notification detail

As a **User**, I want to **view the detail of the notification** so I can **take action on the server to resolve the issue**.  
** Acceptance criteria**
   * The notification detail page is displayed. 
   
As a **Admin**, I want to **start/stop the Spring Boot micro services** so I can **send/stop server notifications**.
** Acceptance criteria**
   * Admin user has shell script available to start/stop the Spring Boot micro services. 

As a **Admin**, I want to **have access to the app Firebase console** so I can **manage the users and server notifications**.
** Acceptance criteria**
   * Admin user has read/write access to the Firebase console and can manage the app Firebase services. 


