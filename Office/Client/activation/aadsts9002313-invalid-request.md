---
title: Microsoft 365 Apps activation error AADSTS9002313 Invalid Request
description: Troubleshooting steps for the error AADSTS9002313 Invalid Request. Request is malformed or invalid.
author: helenclu
ms.reviewer: vikkarti
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - Activation\SignIn\AADSTS Errors
  - CSSTroubleshoot
  - CI 157587
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 02/11/2025
---

# Microsoft 365 Apps activation error "AADSTS9002313: Invalid Request"

When you try to activate Microsoft 365 apps, you encounter the error message:

> AADSTS9002313: Invalid Request. Request is malformed or invalid.

Try the following troubleshooting methods to solve the problem.

**Note** Some of these troubleshooting methods can only be performed by a Microsoft 365 admin. If you aren’t an admin, see [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b)
<br/><br/>
<details>
<summary><b>Activating Microsoft 365 on Windows 8.1 or earlier</b></summary>

To activate Microsoft 365 Apps, TLS 1.2 must be enabled on the operating system. Some older operating systems, such as Windows 7 SP1, Windows Server 2008 R2, and Windows Server 2012, require an update to enable TLS 1.2 by default.

**Important** Running Microsoft 365 Apps on these older operating systems isn't supported. For more information, see [End of support resources for Office](/deployoffice/endofsupport/resources).

1.	If you are running Windows 7 or Windows Server 2008, make sure that [Service Pack 1]( https://support.microsoft.com/topic/information-about-service-pack-1-for-windows-7-and-for-windows-server-2008-r2-df044624-55b8-3a97-de80-5d99cb689063) is installed.
1.	Enable TLS 1.2 as the default protocol by using [this easy fix]( https://download.microsoft.com/download/0/6/5/0658B1A7-6D2E-474F-BC2C-D69E5B9E9A68/MicrosoftEasyFix51044.msi), and then restart the device.
1.	From Start, select **Control Panel** > **Internet options** > **Advanced settings**.
1.	If **TLS 1.2** isn’t checked, check it, then select **Apply** and **OK**.
1.	Restart the device, and then try activating Microsoft 365 again.
<br/><br/>
</details>

<details>
<summary><b>Make sure Azure Active Directory Authentication Library (ADAL) and Web Account Manager (WAM) are enabled</b></summary>

For more information, see [Disabling ADAL or WAM not recommended for fixing Office sign-in or activation issues](/microsoft-365/troubleshoot/administration/disabling-adal-wam-not-recommended).
<br/><br/>
</details>

<details>
<summary><b>Reset Microsoft 365 activation state</b></summary>

See [Reset activation state for Microsoft 365 Apps for enterprise](/office/troubleshoot/activation/reset-office-365-proplus-activation-state).
<br/><br/>
</details>

## Additional troubleshooting

If the above steps don’t solve the problem, try the steps in the following articles:

- [Microsoft 365 activation network connection issues](./network-connection-issues.md)

- [Microsoft 365 activation sign in errors](./sign-in-issues.md)
