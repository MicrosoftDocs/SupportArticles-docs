---
title: Lync conferencing feature fails for a mandatory user profile
description: Describes Lync conferencing feature fails for a mandatory user profile.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Lync 2010
  - Lync 2010 Attendee
  - Microsoft Lync 2013
ms.date: 03/31/2022
---

# Lync conferencing feature fails when the user is signed in using a mandatory user profile

## Symptoms

This issue will occur in the following two scenarios:

### Scenario 1

This issue can occur using Microsoft Lync 2013 or Microsoft Lync 2010.

1. The Lync client Meet Now feature will open:

    The Lync 2013 Group Conversation window with the following error notification:

    **An error occurred during the Lync meeting**

    The Lync 2010 Group Conversation window with the following error notification:

    **An error occurred during the online meeting**

2. Click on the notification listed above and the following error information will be displayed in a Microsoft Lync dialog:

    **When contacting your support team, reference error ID 16389 (source ID 0)**

### Scenario 2

This issue can also occur using Microsoft Outlook 2013, Microsoft Outlook 2010or Microsoft Outlook 2007:

#### Microsoft Outlook 2013 or Microsoft Outlook 2010

1. Open Microsoft Outlook on the Windows client-based computer.
2. Choose Calendar from the Outlook Navigation menu.
3. On the Outlook Calendar toolbar click on the New Lync Meeting or Lync Online Meeting button.

    The following error information will be displayed in a Microsoft Lync 2013 dialog:

    **Create Lync meeting failed. Make sure that Lync is running and signed-in and try again**

    The following error information will be displayed in a Microsoft Lync 2010 dialog:

    **Create online meeting failed. Make sure that Lync is running and signed-in and try again**

#### Microsoft Outlook 2007

1. Open Microsoft Outlook 2007 on the Windows client-based computer.
2. Choose the Lync Online Meeting button from the Outlook 2007 Online meeting toolbar.

    The following error information will be displayed in a Microsoft Lync 2013 Dialog:

    **Create Lync meeting failed. Make sure that Lync is running and signed-in and try again**

    The following error information will be displayed in a Microsoft Lync 2010 Dialog:

    **Create online meeting failed. Make sure that Lync is running and signed-in and try again**

## Cause

This issue occurs when users sign into the Lync client using a Windows Active Directory Domain Services mandatory profile. Mandatory profiles are read-only user profiles. Since changes to the mandatory profile cannot be saved, the design of the Public Key Infrastructure (PKI) functionality does not allow this operation. This causes the creation of the secure keys that are needed for the creation of the focus for the Lync conference to fail.

## Resolution

Do not sign into the Lync client using a Windows Active Directory Domain Services mandatory profile when planning to use the conferencing features of the Lync client.

## More Information

For detailed information on using Mandatory profiles with Windows server and client-based computers:

[Design customization the default local user profile when preparing an image of Windows](https://support.microsoft.com/kb/973289)

For more detailed information on Crypto API functionality with Mandatory profiles:

[RSACryptoServiceProvider fails when used with mandatory profiles](
/archive/blogs/alejacma/rsacryptoserviceprovider-fails-when-used-with-mandatory-profiles)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
