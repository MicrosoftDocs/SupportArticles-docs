---
title: Connectivity issues when root certificate isn't updated
description: To fix connectivity issues, install the latest root certificate updates to make sure that the client computer is up to date and secure.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Configure Devices - Windows\Trusted Certificates
ms.reviewer: kaushika, franknov
---
# Connectivity issues may occur when the Baltimore CyberTrust root certificate is not installed

This article fixes connectivity issues that may occur when the Baltimore CyberTrust root certificate isn't installed.

## Symptoms

Connectivity issues may occur on client computers when the following conditions are true:

- The client computers use Microsoft Intune and have the automatic root certificate mechanism disabled.
- The Baltimore CyberTrust root certificate is not installed.

## Solution

If the automatic root certificate update mechanism is disabled on a client computer, install the latest root certificates to resolve this issue and make sure that the client computer is up to date and secure.

You can use the [Microsoft Update Catalog](https://catalog.update.microsoft.com/v7/site/home.aspx) to find the latest root certificate updates. You can search for **root update** and then download the latest root update package. Root update packages are cumulative. Therefore, you have to install only the latest package to receive all root certificates in the program.

For more information about the root certificate program and about other ways to install the package, see [Configure Trusted Roots and Disallowed Certificates](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn265983(v=ws.11)?redirectedfrom=MSDN).

## More information

Microsoft maintains the list of root certificates that are distributed by the Windows Root Certificate Program on the program website. For more information about the Windows Root Certificate Program and the list of certification authorities (CAs) who are members, see [Release notes - Microsoft Trusted Root Certificate Program](/security/trusted-root/release-notes).

Root certificate update mechanisms are available in different versions of Windows. This includes the automatic root update mechanisms. For more information about how to update the root certificate list in different versions of Windows, see the following article:

[Configure Trusted Roots and Disallowed Certificates](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn265983(v=ws.11)?redirectedfrom=MSDN)

By default, the automatic root update mechanism is enabled in different versions of Windows. However, if this mechanism is disabled, and if the clients do not have the Baltimore CyberTrust root certificate installed, connectivity issues with Microsoft Intune may occur. Clients may no longer be able to access the Microsoft Intune infrastructure to receive updates, policies, and other such resources. Therefore, the clients may no longer be up to date and secure. New enrollments on such clients may also have issues.

For more information about Microsoft Intune and resources that are available to the clients by using Microsoft Intune, see [Release notes - Microsoft Trusted Root Certificate Program](/security/trusted-root/release-notes).
