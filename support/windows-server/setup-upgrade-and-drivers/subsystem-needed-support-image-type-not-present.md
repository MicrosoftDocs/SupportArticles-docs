---
title: Fail to run applications on Windows Server Core
description: Provides a solution to an issue where you fail to run or install applications on a Windows Server computer running as a Server Core
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:installing-or-upgrading-windows, csstroubleshoot
---
# Message "Subsystem needed to support the image type is not present" error when installing or running applications on Server Core

This article helps fix an error (Subsystem needed to support the image type is not present) that occurs when you run or install applications on a Windows Server computer running as a Server Core.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 974727

## Rapid publishing

Rapid publishing articles provide information directly from within the Microsoft support organization. The information contained herein is created in response to emerging or unique topics, or is intended supplement other knowledge base information.

## Symptom

When you run or install applications on a Windows Server computer running as a Server Core, you receive the following message:

> "The subsystem needed to support the image type is not present"

## Cause

The 32-bit subsystem support has been removed from the server, either manually or through an automated build process. This can be confirmed by running the following command:

`dism /online /get-features /format:table`

Examine and confirm the following output:

> ServerCore-WOW64 | Disabled

## Resolution

To enable the 32-bit subsystem:

1. Logon to the Server Core computer as an administrator.

2. Run the following command exactly as shown:

    `DISM.EXE /online /enable-feature /featurename:ServerCore-WOW64`

    > [!Note]  
    > The feature name 'ServerCore-WOW64' is case-sensitive.

3. Restart the computer when prompted.

## More information

To reproduce this scenario:  

To enable the 32-bit subsystem:

1. Logon to the Server Core computer as an administrator.

2. Run the following command exactly as shown:

    `DISM.EXE /online /enable-feature /featurename:ServerCore-WOW64`

    > [!Note]
    > The feature name 'ServerCore-WOW64' is case-sensitive.

3. Restart the computer when prompted.

Any applications that are compiled with 32-bit code will not run on Server Core when the 32-bit subsystem has been removed. This issue also includes the installers of 64-bit applications, where the installer itself contains 32-bit code.

## References

For more information, review:  
[What's New in the Server Core Installation Option](https://technet.microsoft.com/library/dd883268%28ws.10%29.aspx)  

## Disclaimer

Microsoft and/or its suppliers make no representations or warranties about the suitability, reliability, or accuracy of the information contained in the documents and related graphics published on this website (the "materials") for any purpose. The materials may include technical inaccuracies or typographical errors and may be revised at any time without notice.

To the maximum extent permitted by applicable law, Microsoft and/or its suppliers disclaim and exclude all representations, warranties, and conditions whether express, implied, or statutory, including but not limited to representations, warranties, or conditions of title, non-infringement, satisfactory condition or quality, merchantability and fitness for a particular purpose, with respect to the materials.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
