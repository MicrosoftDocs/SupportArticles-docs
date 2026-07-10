---
title: Troubleshoot Push Notifications in Customer Insights - Journeys
description: Troubleshoot push notifications in Dynamics 365 Customer Insights - Journeys. Fix device registration failures, plus Android and iOS sending errors. Start now.
ms.date: 07/06/2026
ms.reviewer: alfergus, v-shaywood
ms.custom: "sap:Real-time journeys channels: text messages, push notifications, more\Push notification issues in real-time"
search.audienceType: 
  - admin
  - customizer
  - enduser
---

# Troubleshoot push notifications in Customer Insights - Journeys

## Summary

This article helps you troubleshoot push notification problems in Dynamics 365 Customer Insights - Journeys. It explains why a contact might receive multiple push notifications. It also covers device registration failures, such as a registration status request that returns `HTTP 400` or a `Provided API token is not valid` error message. For Android, it addresses sending errors like `Provided service account JSON is incorrect` and `PROJECT_NOT_PERMITTED`. For iOS, it addresses sending errors like `BadDeviceToken` and Firebase-wrapped device tokens. Find the symptom that matches your error to identify the cause and the fix.

## A contact receives multiple push notifications

A contact receives more than one copy of the same push notification. This problem happens for one of the following reasons:

- You send push notifications from multiple journeys to the same audience member (contact).
- Multiple audience members have the same device token.

To fix this problem, check the following items:

- Review your journeys to make sure they don't send the same push notification to the same contact.
- Make sure each contact is registered with a unique device token.

## Device registration problems

### Device registration API returns 202 but nothing happens

The device registration public API responds asynchronously, which is why the response status code is `HTTP 202` (Accepted) and not `HTTP 200` (OK). The request starts the registration process, but this status code doesn't necessarily mean the operation succeeded. You need to call a separate [device registration status API](/dynamics365/customer-insights/journeys/developer-push-device-registration#device-registration-status) to check the registration results. Use the `RegistrationRequestId` returned by the device registration API to request the registration status. If the response doesn't return a `RegistrationRequestId`, add the `x-ms-track-registration` header and set it to `true`.

### Device registration fails and the registration status request returns 400

This issue has two common causes:

- You provided the wrong `ApiToken` or `MobileAppId` value. Make sure these values come from the **Developer Information** section of the CRM.
- You used the wrong organization ID in the public API URL. Make sure you use the value from the **Developer Information** tab and call the API for the correct CRM environment.

### Registration status API shows "Provided API token is not valid"

This error means the `ApiToken` value in the device registration API request body doesn't match the token for the mobile application. The correct token is in the **Access tokens** section of the **Developer Information** tab in the mobile application configuration in the CRM. To fix this problem, take the correct token from the mobile application and use the matching mobile application ID in the request.

### Registration status API shows "Sending a test invisible notification failed for the given device token"

As part of the device registration process, Customer Insights sends an invisible test push notification to the device token. If that notification fails, registration also fails. The following sections provide platform-specific troubleshooting steps for Android and iOS. Use the steps for your platform to find and fix the cause of the failed test notification.

## Push notification problems on Android

### Push notification fails with "Provided service account JSON is incorrect"

This error usually means you uploaded the wrong file. A common mistake is to use a `google-service.json` file, which belongs in the source code of the mobile app and shouldn't be used in the CRM. To send push notifications, Customer Insights needs the correct service account JSON file uploaded in the mobile application CRM user interface. For information on getting correct file, see [Transition Android push notifications to Firebase Cloud Messaging (FCM) tokens for authentication](/dynamics365/customer-insights/journeys/push-notification-fcm-token-transition).

### Push notification fails with a PROJECT_NOT_PERMITTED error code

The **Firebase In-App Messaging API** service probably isn't turned on. In the Firebase Console, go to **Google Cloud**, find **Firebase In-App Messaging API**, and turn it on.

### Customer Insights reports a successful send but no notification appears

Customer Insights sends push notifications by using a data payload format. You must change the mobile application code to receive the push notification payload and render it as a popup. For more information, see [Receive push notifications on devices](/dynamics365/customer-insights/journeys/developer-notifications).

For more information about data payload formats in Firebase, see [Firebase Cloud Messaging message types](https://firebase.google.com/docs/cloud-messaging/customize-messages/set-message-type).

### Push notification fails with an unclear Firebase error code or message

Customer Insights sends push notifications directly through Firebase servers. If a submission fails, the failure response comes directly from the Firebase server. Review the Firebase [ErrorCode](https://firebase.google.com/docs/reference/fcm/rest/v1/ErrorCode) reference documentation for all possible error codes and their meanings.

## Push notification problems on iOS

For iOS notification problems, you can use third-party websites, such as `https://apnspush.com/`, to help troubleshoot. These websites let you quickly test push notification submission and see whether your changes work.

### Push notification fails with a BadDeviceToken error code

The most common cause of this error is a mismatch between the device token environment and the CRM configuration. When an iOS application generates a device token, it generates the token for either Sandbox or Production mode. Make sure you set the same app mode in the CRM and use the same app mode credentials in the CRM mobile application.

### Push notification fails for iOS device tokens wrapped by Firebase

Customer Insights doesn't currently support iOS device tokens that use FCM. Make sure the device token used for iOS device registration is an original Apple Push Notification service (APNS) device token in the correct format. The token includes only hexadecimal characters, such as `0123456789ABCDEF`, and doesn't exceed 64 characters.

### Push notification fails with an unclear APNS error code or message

Customer Insights sends push notifications directly through APNS servers. If a submission fails, the failure response comes directly from the APNS server. Review [Communicating with APNs](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/CommunicatingwithAPNs.html#//apple_ref/doc/uid/TP40008194-CH11-SW17) for all possible error codes and their meanings.

## Related content

- [Push notification setup overview](/dynamics365/customer-insights/journeys/push-setup-overview)
- [Push notification application configuration](/dynamics365/customer-insights/journeys/push-notifications-setup)
- [User mapping for push notifications](/dynamics365/customer-insights/journeys/developer-push-user-mapping)

[!INCLUDE [Third-party information and solution disclaimer](../../../../includes/third-party-information-solution-disclaimer.md)]
