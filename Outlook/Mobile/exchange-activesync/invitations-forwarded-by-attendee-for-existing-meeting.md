---
title: Invitations forwarded by attendee for existing meeting
description: Describes an issue in which attendees can forward meeting invitations for an existing meeting. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Programming Custom Solutions\Add-ins
  - Outlook for iOS and Android
  - CSSTroubleshoot
ms.reviewer: jmartin
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2010 Enterprise
search.appverid: MET150
ms.date: 01/30/2024
---
# Meeting invitations are forwarded by an attendee for an existing meeting

_Original KB number:_ &nbsp; 4014990

## Symptoms

Meeting attendees receive a forwarded meeting invitation from another attendee for an existing meeting.

## Cause

This issue occurs if the Exchange ActiveSync client for the attendee sends a **SmartForward** command for this meeting.

## Resolution

This issue is addressed in the latest Apple iOS (10.3.3) and Apple watchOS (3.2.3) updates. For more information, see the following Apple Knowledge Base articles:

- [About iOS 10 Updates](https://support.apple.com/HT208011)
- [Download watchOS 3.0 -3.2.3 Information](https://support.apple.com/kb/DL1894)

To resolve this issue, all devices that are running iOS or watchOS must be updated to the latest version of the software.

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]

The information and the solution in this document represent the current view of Microsoft Corporation about these problems as of the date of publication. This solution is available through Microsoft or through a third-party provider. Microsoft does not specifically recommend any third-party provider or third-party solution that this article might describe. There might also be other third-party providers or third-party solutions that this article does not describe. Because Microsoft must respond to changing market conditions, this information should not be interpreted to be a commitment by Microsoft. Microsoft cannot guarantee or endorse the accuracy of any information or of any solution that is presented by Microsoft or by any mentioned third-party provider.

Microsoft makes no warranties and excludes all representations, warranties, and conditions whether express, implied, or statutory. These include but are not limited to representations, warranties, or conditions of title, non-infringement, satisfactory condition, merchantability, and fitness for a particular purpose, with regard to any service, solution, product, or any other materials or information. Microsoft is in no way liable for any third-party solution that this article mentions.
