---
title: Mobile device can't connect via ActiveSync
description: Describes a scenario in which a mobile device can't connect to Exchange Online in Microsoft 365 by using Exchange ActiveSync. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: willfid, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# A mobile device can't connect to Exchange Online by using Exchange ActiveSync

_Original KB number:_ &nbsp; 2427193

## Symptoms

A user's mobile device can't connect to Microsoft Exchange Online in Microsoft 365 through Microsoft Exchange ActiveSync. However, the mobile device previously could connect.

## Cause

This issue can occur for many reasons. These include, but aren't limited to, the following:

- The device can't connect to the Internet service provider (ISP) or to the Internet.
- The device isn't set up correctly.
- The Exchange Online mailbox server that supports the connection isn't available because of maintenance or an outage issue.

## Resolution - Step 1: Confirm that ActiveSync is enabled for the user

1. Sign in to the [Microsoft 365 portal](https://portal.office.com) as an admin.
2. Select **Admin**, and then select **Exchange** to open the Exchange admin center.
3. In the left navigation pane, select **recipients**, and then select **mailboxes**.
4. In the list of mailboxes, double-click the user, and then select **mailbox features**.
5. Under **Mobile Devices**, take the following actions:
   1. If you see **Disable Exchange ActiveSync**, this means that ActiveSync is enabled for the user. See **Step 2: Confirm that the mobile device isn't blocked by an ActiveSync quarantine rule** of this article.
   2. If you see **Enable Exchange ActiveSync**, this means that ActiveSync isn't enabled for the user. Select **Enable Exchange ActiveSync**, select **Yes** when you're prompted, and then select **Save**.

6. After you re-enable ActiveSync, try to set up the device again.

## Resolution - Step 2: Confirm that the mobile device isn't blocked by an ActiveSync quarantine rule

1. In the Exchange admin center, select **mobile**, and then select **mobile device access**.
2. Confirm that the user's mobile device isn't in the list of quarantined devices.

## Resolution - Step 3: Confirm that ActiveSync can be set up by using Autodiscover

The Autodiscover service makes it easier to set up Outlook and mobile phones. The Autodiscover service uses a user's email address and password to automatically set up a user's profile.

To troubleshoot this issue further, run the Exchange ActiveSync Autodiscover test in Microsoft Remote Connectivity Analyzer. If the user is using a local wireless network to connect to Exchange Online, the user should run both tests to make sure that the local network allows for connections to the ActiveSync endpoints.

### Test Exchange Online ActiveSync access externally by using Remote Connectivity Analyzer

> [!NOTE]
> Admins may want to guide users through running Remove Connectivity Analyzer if this is necessary. The Exchange ActiveSync Autodiscover test requires the users to enter their credentials.

1. In a web browser, browse to the [Microsoft Remote Connectivity Analyzer tool](https://www.testconnectivity.microsoft.com/tests/o365).

2. Enter your Microsoft 365 sign-in credentials.

   :::image type="content" source="media/mobile-device-cannot-connect-via-activesync/enter-sign-in-credentials.png" alt-text="Screenshot of entering your Microsoft 365 sign-in credentials.":::

3. Select **Perform Test**, and then wait while the details pane is displayed.

   :::image type="content" source="media/mobile-device-cannot-connect-via-activesync/perform-test.png" alt-text="Screenshot of selecting Perform Test in the Remote Connectivity Analyzer window.":::

4. Review the test results.

   :::image type="content" source="media/mobile-device-cannot-connect-via-activesync/test-results.png" alt-text="Screenshot of Test Details in the Remote Connectivity Analyzer window.":::

5. Take one of the following actions:

   - If the test passes, set up the mobile device.
   - If the test fails, confirm that the Autodiscover service is set up correctly. For more information, see the following resources:
     - If all mailboxes in your organization are in Exchange Online, add an Autodiscover CNAME record. For more information, see [Add DNS records to connect your domain](/microsoft-365/admin/get-help-with-domains/create-dns-records-at-any-dns-hosting-provider?view=o365-worldwide&preserve-view=true) and [External Domain Name System records for Microsoft 365](/microsoft-365/enterprise/external-domain-name-system-records?view=o365-worldwide&preserve-view=true).
     - If you have an Exchange hybrid deployment, set up the Autodiscover public DNS records for your existing SMTP domains to point to an on-premises Exchange server. For more information, see [Hybrid deployment prerequisites](/exchange/hybrid-deployment-prerequisites).

## Resolution - Step 4: Set up the mobile device without using Autodiscover (if you don't want to use Autodiscover)

We recommend that you use Autodiscover when you try to set up mobile devices. However, if you want to set up a mobile device without using Autodiscover, use the procedure that is described on one of the following Microsoft websites:

- [Set up email in Outlook for iOS mobile app](https://support.microsoft.com/office/set-up-email-in-outlook-for-ios-mobile-app-b2de2161-cc1d-49ef-9ef9-81acd1c8e234)
- [Set up email on a BlackBerry](https://support.microsoft.com/office/set-up-email-on-a-blackberry-8231fa3b-e551-4f45-b522-778406662f55)
- [Set up email on Windows Phone](https://support.microsoft.com/office/set-up-email-on-windows-phone-181a112a-be92-49ca-ade5-399264b3d417)
- [Set up email on an Android phone or tablet](https://support.microsoft.com/office/set-up-email-in-the-outlook-for-android-app-886db551-8dfa-4fd5-b835-f8e532091872)

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
