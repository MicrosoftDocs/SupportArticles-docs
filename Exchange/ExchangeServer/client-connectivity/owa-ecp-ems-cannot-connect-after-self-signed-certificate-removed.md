---
title: OWA, ECP, or EMS can't connect after removing a self-signed certificate from Exchange Back End website
description: Fixes an issue that several client protocols such as ECP, OWA, Exchange ActiveSync, and Exchange Management Shell can't connect. Because you removed the Microsoft Exchange Self-Signed certificate from the Exchange Back End website, and cleared the IIS cache.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2013 Enterprise
search.appverid: MET150
ms.date: 01/24/2024
---
# Unable to open OWA, ECP, or EMS after a self-signed certificate is removed from the Exchange Back End website

_Original KB number:_ &nbsp;2779694

## Symptoms

Consider the following scenario when you're using Microsoft Exchange Server 2013 or Exchange Server 2016:

- You remove the Microsoft Exchange Self-Signed certificate from the Exchange Back End website by using Certificates MMC, `Remove-Exchangecertificate`, IIS Manager, or another method.
- You clear the IIS cache by restart or `IISReset`.

In this scenario, several client protocols such as Exchange Control Panel (ECP), Outlook Web App (OWA), Exchange ActiveSync, and Exchange Management Shell (EMS) can't connect. The following issues may occur:

- OWA and ECP display a blank page.
- Exchange ActiveSync users can't receive emails.
- EMS can't connect and displays the following error:

    ```console
    New-PSSession : [xy.local.contoso.com] Processing data from remote server xy.local.contoso.com failed with the
    following error message: The WinRM Shell client cannot process the request. The shell handle passed to the WSMan Shell
    function is not valid. The shell handle is valid only when WSManCreateShell function completes successfully. Change
    the request including a valid shell handle and try again. For more information, see the about_Remote_Troubleshooting
    Help topic.
    At line:1 char:1
    + New-PSSession -ConnectionURI "$connectionUri" -ConfigurationName Microsoft.Excha ...
    + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        + CategoryInfo          : OpenError: (System.Manageme....RemoteRunspace:RemoteRunspace) [New-PSSession], PSRemotin
       gTransportException
        + FullyQualifiedErrorId : -2144108212,PSSessionOpenFailed
    Failed to connect to an Exchange server in the current site.
    Enter the server FQDN where you want to connect.:
    ```

## Cause

During the setup process, a self-signed certificate called Microsoft Exchange is bound to the Exchange Backend website on port 444. The certificate is for communication between the Default Web Site and Exchange Back End websites. When the certificate is removed, the Default Web Site can't proxy connections to the Exchange Back End website.

## Resolution

To resolve this issue, add the certificate back to the Exchange Back End website by creating a new self-signed certificate, and then bind it to the Exchange Back End website.

> [!NOTE]
> These steps should be taken on the Exchange Mailbox server role.

1. Start Management Shell on the Mailbox server.
1. Type *New-ExchangeCertificate*.
    > [!NOTE]
    > If you're prompted to overwrite the default certificate, select **No**.
1. Start **IIS Manager** on the Mailbox Server.
1. Expand **Site**, highlight **Exchange Back End**, and select **Bindings** from the **Actions** pane in the right side column.
1. Select **Typehttps** on Port 444.
1. Select **Edit** and select the Microsoft Exchange certificate.
1. From an administrator command prompt, run `IISReset`.
