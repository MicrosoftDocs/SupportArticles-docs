---
title: Resolve common issues related to SIP Gateway
description: Lists common issues when you use compatible SIP devices with Teams. Provides resolutions.
ms.date: 01/17/2022
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
ms.service: msteams
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Microsoft Teams
ms.custom: CI159602
ms.reviewer: scapero
---

# Resolve common issues related to SIP Gateway

SIP Gateway enables your organization to use any compatible SIP device with Microsoft Teams. This article lists some common issues that may occur when you use an SIP device, and provides resolutions that you can try.  

## I can't onboard my device

1. Verify that you're using a [compatible device](/microsoftteams/sip-gateway-plan#compatible-devices).
1. Make sure that you've reset the device to factory default settings.
1. Verify that [the SIP Gateway provisioning server's URL is correctly set](/microsoftteams/sip-gateway-configure#set-the-sip-gateway-provisioning-server-url) to an HTTP URL.
1. Check if the device can connect to SIP Gateway. For more information, see [Configure SIP Gateway](/microsoftteams/sip-gateway-configure).

## Web app authentication fails when I try to sign in

1. Make sure that you're using the correct credentials. Use the same credentials to sign in to the Teams app to verify.
1. If your organization uses Conditional Access, make sure that the IP address of SIP Gateway is excluded. For more information, see [Configure conditional access](/microsoftteams/sip-gateway-configure#configure-conditional-access).

## My device isn't updated after I sign in successfully

1. Check if the [requirements to use SIP Gateway](/microsoftteams/sip-gateway-plan#requirements-to-use-sip-gateway) are met. Teams users must have a phone number with PSTN calling enabled to use SIP Gateway.
1. Check if SIP Gateway policy is set correctly. For more information, see [Enable SIP Gateway for the users in your organization](/microsoftteams/sip-gateway-configure#enable-sip-gateway-for-the-users-in-your-organization).
1. Check if another user from a different tenant had signed in to the device, but didn't sign out gracefully. If so, have that user sign in, then sign out.
1. Check if the device can connect to SIP Gateway. For more information, see [Configure SIP Gateway](/microsoftteams/sip-gateway-configure).

## My device isn't listed in the Teams admin center

1. Make sure that you're using a [compatible device](/microsoftteams/sip-gateway-plan#compatible-devices).
1. Verify that you've successfully onboarded the device to SIP Gateway. For more information, see [Configure SIP Gateway](/microsoftteams/sip-gateway-configure).
1. Make sure that you've [signed in](/microsoftteams/sip-gateway-configure#user-pairing-and-sign-in) to the device at least once.

## My device is listed in the Teams admin center, but shows wrong state

SIP device state isn't reflected when the device's user isn't signed in. Therefore, check if you've signed in to the device.

- If you've signed in, refresh the Teams admin center to show the updated state.
- If you've signed out, the device shows as offline.

## I can't sign in to my device remotely

1. Verify that you've [enrolled the device](/microsoftteams/sip-gateway-configure#provision-and-enroll-sip-devices-as-common-area-phones) correctly. 
1. Try [local sign-in](/microsoftteams/sip-gateway-configure#user-pairing-and-sign-in).

## My device signs out by itself

1. Verify that [SIP Gateway is enabled for the users in your organization](/microsoftteams/sip-gateway-configure#enable-sip-gateway-for-the-users-in-your-organization).
1. Check if your settings have changed. For example, your phone number was removed.
1. Check if you connect the device to a new IP address.

## My device displays the wrong time

1. Check DHCP settings. For more information, see [Using DHCP](/microsoftteams/sip-gateway-configure#using-dhcp).
1. Check the device's web settings. For more information, see [Configure SIP Gateway](/microsoftteams/sip-gateway-configure).

## My device shows the wrong language

1. [Setting the SIP device's UI language](/microsoftteams/sip-gateway-configure#set-a-sip-devices-ui-language) is done in the SIP Gateway provisioning server. Check the language code string in the provisioning server URL. For example, `http://emea.ipp.sdg.teams.microsoft.com/lang_de` sets the language to German.
1. Check the device's web app.

## I can't register my device to Teams

1. Check if the device can connect to SIP Gateway. For more information, see [Configure SIP Gateway](/microsoftteams/sip-gateway-configure).
1. Check if other SIP devices experience the same issue. If so, service may not be available.
1. Restart your device, and try again.

## I can't make calls

1. Check if your device is registered.
1. Restart your device, and try again.
1. Test if you can make the same call (to the same remote address) in the Teams app.

## I can't receive calls

1. Check if your device is registered.
1. Restart your device, and try again.
1. Test if you can receive the same call (from the same remote address) in the Teams app.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
