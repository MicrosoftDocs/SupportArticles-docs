---
title: Common issues when using SIP devices with Teams
description: Troubleshoots common issues that occur when you use compatible SIP devices with Microsoft Teams.
ms.date: 05/21/2025
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:SIP Gateway
  - CI159602
ms.reviewer: scapero, chasing
---

# Common issues when you use SIP devices with Teams

SIP Gateway enables your organization to use any compatible SIP device with Microsoft Teams. This article lists some common issues that might occur when you use a compatible SIP device to make and receive calls through Teams, and provides steps to help you troubleshoot these issues.

## I can't onboard my device

1. Verify that you're using a [compatible SIP device](/microsoftteams/sip-gateway-plan#compatible-devices).
1. Make sure that you reset the device to the factory default settings.
1. Verify that [the SIP Gateway provisioning server's URL](/microsoftteams/sip-gateway-configure#set-the-sip-gateway-provisioning-server-url) begins in "HTTP", not "HTTPS". For example, use `http://noam.ipp.sdg.teams.microsoft.com`, not `https://noam.ipp.sdg.teams.microsoft.com`.
1. Check whether the device can connect to SIP Gateway. Verify that the connection isn't blocked by your firewall or proxy server, and that the required HTTPS endpoints and TCP/UDP ports are open. For more information, see the list of items that follows "Before you can configure SIP Gateway" in [Configure SIP Gateway](/microsoftteams/sip-gateway-configure).

## Web app authentication fails when I try to sign in

1. Make sure that you're using the correct credentials. Sign in to the Teams app by using the same credentials to check whether the credentials are correct.
1. If your organization uses Conditional Access, make sure that the IP address of SIP Gateway is excluded. For more information, see [Configure conditional access](/microsoftteams/sip-gateway-configure#configure-conditional-access).

## My device doesn't update after I sign in successfully

1. Check whether the [requirements to use SIP Gateway](/microsoftteams/sip-gateway-plan#requirements-to-use-sip-gateway) are met. To use SIP Gateway, Teams users must have a phone number that has PSTN calling enabled.
1. Check whether SIP Gateway policy is set correctly. For more information, see [Enable SIP Gateway for the users in your organization](/microsoftteams/sip-gateway-configure#enable-sip-gateway-for-the-users-in-your-organization).
1. Check whether another user from a different tenant signed in to the device, but didn't sign out gracefully. If they didn't, have that user sign in and sign out again.
1. Check whether the device can connect to SIP Gateway. Verify that the connection isn't blocked by your firewall or proxy server, and that the required HTTPS endpoints and TCP/UDP ports are open. For more information, see the list of items that follows "Before you can configure SIP Gateway" in [Configure SIP Gateway](/microsoftteams/sip-gateway-configure).

## My device isn't listed in the Teams admin center

1. Make sure that you're using a [compatible SIP device](/microsoftteams/sip-gateway-plan#compatible-devices).
1. Verify that you've successfully onboarded the device to SIP Gateway. For more information, see [Configure SIP Gateway](/microsoftteams/sip-gateway-configure).
1. Make sure that you've [signed in](/microsoftteams/sip-gateway-configure#user-pairing-and-sign-in) to the device at least one time.

## My device is listed in the Teams admin center, but shows wrong state

The SIP device state isn't accurately reflected if the device user isn't signed in. Therefore, check whether you're signed in to the device.

- If you're signed in, refresh the Teams admin center to display the updated state.
- If you're signed out, the device will appear as offline.

## I can't sign in to my device remotely

1. Verify that you've [enrolled the device](/microsoftteams/sip-gateway-configure#provision-and-enroll-sip-devices-as-common-area-phones) correctly.
1. Try [local sign-in](/microsoftteams/sip-gateway-configure#user-pairing-and-sign-in).

## My device signs itself out

1. Verify that [SIP Gateway is enabled for the users in your organization](/microsoftteams/sip-gateway-configure#enable-sip-gateway-for-the-users-in-your-organization).
1. Check whether your settings have been changed. For example, check whether your phone number was removed.

## My device displays the wrong time

1. Check the DHCP settings. For more information, see [Using DHCP](/microsoftteams/sip-gateway-configure#using-dhcp).
1. Check the device's web application. For more information, see the device manufacturer documentation.

## My device shows the wrong language

1. [Setting the SIP device's UI language](/microsoftteams/sip-gateway-configure#set-a-sip-devices-ui-language) is done on the SIP Gateway provisioning server. Check the language code string in the provisioning server URL. For example, `http://emea.ipp.sdg.teams.microsoft.com/lang_de` sets the language to German.
1. Check the device's web application. For more information, see the device manufacturer documentation.

## I can't register my device to Teams

1. Check whether the device can connect to SIP Gateway. Verify that the connection isn't blocked by your firewall or proxy server, and that the required HTTPS endpoints and TCP/UDP ports are open. For more information, see the list of items that follows "Before you can configure SIP Gateway" in [Configure SIP Gateway](/microsoftteams/sip-gateway-configure).
1. Check whether other SIP devices experience the same issue. If they do, the service might not be available.
1. [Restart your device](/microsoftteams/sip-gateway-configure#restart-a-sip-device), and try again.

## I can't make calls

1. Check whether your device is registered.
1. [Restart your device](/microsoftteams/sip-gateway-configure#restart-a-sip-device), and try again.
1. Test whether you can make the same call (to the same remote address) in the Teams app.

## I can't receive calls

1. Check whether your device is registered.
1. [Restart your device](/microsoftteams/sip-gateway-configure#restart-a-sip-device), and try again.
1. Test whether you can receive the same call (from the same remote address) in the Teams app.

## I can't enroll my device by using a one-time verification code

Currently, enrolling SIP devices by dialing \*55\* followed by a [one-time verification code](/microsoftteams/devices/sip-gateway-configure#provision-and-enroll-sip-devices-as-common-area-phones) isn't available in the GCC environment. 

To work around this issue, use the [Zero Touch Common Area Phone sign-in](/microsoftteams/devices/sip-gateway-configure#zero-touch-common-area-phone-sign-in) method.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
