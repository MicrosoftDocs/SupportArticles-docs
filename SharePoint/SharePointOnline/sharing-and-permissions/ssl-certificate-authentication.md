---
title: SSL certificate authentication issues
description: This article provides solutions for resolving SSL certificate authentication issues.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Authentication and Authorization\Conditional Access Policy
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# You experience SSL certificate authentication issues when you use SharePoint Online

## Problem

Consider the following scenarios.

### Scenario 1

- You have a custom solution that authenticates with SharePoint Online.

- Your solution is coded to exclusively use the GTE CyberTrust Global Root certificate.

- When you try to use the solution, authentication doesn't finish.

### Scenario 2

- You're using an operating system and browser combination that doesn't have the Baltimore CyberTrust Root certificate installed.

> [!NOTE]
> The symptoms in both scenarios apply only to Microsoft-owned domain names. They don't apply to custom domain names that you've specified for the public website.

## Solution

To resolve this problem, update your operating system or device by installing the Baltimore CyberTrust root certificate, or update your solution to accept the Baltimore CyberTrust Root certificate to authenticate with SharePoint Online.

> [!NOTE]
> As a best practice, we recommend that you don't hard-code trusted root lists for certificate validation. Instead, you should use policy-based root certificate validation that can be updated as industry standards or certificate authorities change.

### For Windows 8, Windows 7, and Windows Vista

The Baltimore CyberTrust root certificate is most frequently installed together with the operating system. The certificate is provided through Windows Update. To resolve this problem if the automatic root certificate doesn't exist and the update mechanism is disabled on a client computer, install the latest root certificates to make sure that the client computer is up-to-date and secure.

You can use the Microsoft Update Catalog to find the latest root certificate updates. You can search for "root update" or the Microsoft Knowledge Base article number for the Windows Root Certificate Program (KB931125), and then download the latest root update package. Root update packages are cumulative. Therefore, you have to install only the latest package to receive all root certificates in the program.

For more information about the root certificate program and about other ways to install the package, click the following article number to go to [Windows Root Certificate Program members](https://support.microsoft.com/help/931125).

### For Windows Phone and Windows Mobile devices

The Baltimore CyberTrust root certificate is included together with Windows Phone 8, Windows Phone 7, Windows Mobile 6, or Windows Mobile 5.

### For Apple iOS devices

The Baltimore CyberTrust certificate is preinstalled on many Apple iOS devices, such as the iPad and iPhone.

For more information, see [Lists of available trusted root certificates in iOS](https://support.apple.com/ht204132).

If the Baltimore CyberTrust certificate isn't present on your device, install the certificate. To do this, download and open the certificate, and then select the option to add the certificate.

> [!NOTE]
> Because device compatibility for certificates may vary, we recommend that you contact your device manufacturer if you encounter any issues that are specific to your device.

### For other devices and operating systems

Generally, most devices and operating systems provide the Baltimore CyberTrust root either together with the operating system or through an update. If you encounter this problem, and because device compatibility for certificates may vary, we recommend that you contact your device manufacturer to determine whether Baltimore support was added to your device or operating system.

## More information

Microsoft changed from the GTE CyberTrust Global Root to the Baltimore CyberTrust Root for all public-facing HTTPs services. We are made this change to stay current with industry-wide security best practices for trusted root certificates. The new root certificate uses a stronger key length and hashing algorithm.

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft doesn't guarantee the accuracy of this third-party contact information.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
