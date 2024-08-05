---
title: Scanning using a scanner may cause a TWAIN aware application to hang
description: Provides a resolution for the issue that scanning using a scanner may cause a TWAIN aware application to hang
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Print, Fax, and Scan\Windows Fax and Scan (Client), csstroubleshoot
---
# Scanning using a scanner may cause a TWAIN aware application to hang

This article provides a resolution for the issue that scanning using a scanner may cause a TWAIN aware application to hang.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 982436

Source: Microsoft Support

## Rapid publishing

Rapid publishing articles provide information directly from within the microsoft support organization. The information contained herein is created in response to emerging or unique topics, or is intended supplement other knowledge base information.

## Symptoms

When a 32-bit TWAIN aware application scans using a WIA driver on a 64-bit Windows Vista or Windows 7 system, the TWAIN application may stop responding.

## Cause

If you leave the scan dialog open for about 10 minutes before you push the [Scan] button, the message used to transfer the scanned image from the WIA driver to the TWAIN application is not sent to the TWAIN application.

## Resolution

This problem can be avoided by doing either of the followings:

- Scan image soon after you open the scan dialog.

- Use a WIA aware application, not a TWAIN aware application.

## More information

This behavior is by design.

## Disclaimer

Microsoft and/or its suppliers make no representations or warranties about the suitability, reliability, or accuracy of the information contained in the documents and related graphics published on this website (the "materials") for any purpose. The materials may include technical inaccuracies or typographical errors and may be revised at any time without notice.

To the maximum extent permitted by applicable law, Microsoft and/or its suppliers disclaim and exclude all representations, warranties, and conditions whether express, implied, or statutory, including but not limited to representations, warranties, or conditions of title, non infringement, satisfactory condition or quality, merchantability and fitness for a particular purpose, with respect to the materials.
