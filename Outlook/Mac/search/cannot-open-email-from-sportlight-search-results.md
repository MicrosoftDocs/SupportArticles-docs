---
title: Cannot open email from Spotlight search results
description: Discusses that you receive an Outlook cannot open the file because it is not associated with the default identity error when trying to open an email message from the Spotlight search results in macOS X.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Mac
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2016 for Mac
  - Outlook for Microsoft 365 for Mac
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook cannot open the file because it is not associated with the default identity error occurs

_Original KB number:_ &nbsp; 2741583

## Symptoms

When you try to open an email message from the Spotlight search results in macOS X, you receive one of the following error messages depending on the version of the product:

Outlook 2016 for Mac:

> Outlook cannot open the file because it is not associated with the default profile.

Outlook for Mac 2011:

> Outlook cannot open the file because it is not associated with the default identity.

## Cause

This issue occurs because the Spotlight search is returning a result from an Outlook profile or identity that is not your default. This behavior may start occurring after you rebuild your Outlook profile or identity, or create a new one.

## Resolution - Method 1: Delete other Outlook profiles or identities

> [!NOTE]
> When you delete an Outlook profile or identity, all email messages and data in the database that are associated with that profile or identity are also deleted. Before you use this method, verify that you do not need any of the associated data.

Outlook 2016 for Mac:

1. Quit Outlook 2016 for Mac.
2. Select **Go** > **Applications**.
3. Right-Click Microsoft Outlook, and select **Show Package Contents**.
4. Expand **Contents**, **SharedSupport**, and open **Outlook Profile Manager**.

    > [!NOTE]
    > You can create an alias for the Outlook Profile Manager, and move it to your desktop or another convenient location if you prefer.  
    > Press and hold the **Option** key while you select the **Outlook** icon.

5. Select the profile that you want to delete, and then select the minus sign (-) at the bottom of the window.

Outlook for Mac 2011:

1. Quit Outlook for Mac 2011.
2. Press and hold the **Option** key while you select the **Outlook** icon to start the Microsoft Database Utility.
3. Select the identity that you want to delete, and then select the minus sign (-) at the bottom of the window.

## Resolution - Method 2: Exclude other Outlook profiles or identities from Spotlight indexing

1. On the **Apple** menu, select **System Preferences**.
2. Select **Spotlight**.
3. Select **Privacy**.
4. Select the plus sign **(+)** at the bottom of the window.
5. Locate one of the following directories, depending on your version of Outlook for Mac:

    **Outlook 2016 for Mac:**

    /Users/\<Username>/Library/Group Containers/UBF8T346G9.Office/Outlook/Outlook 15 Profiles/\<profile name>

    **Outlook for Mac 2011:**

    /Users/\<username>/Documents/Microsoft User Data/Office 2011 Identities/\<Identity Name>

6. Select the identity or profile folder that you want to exclude from Spotlight indexing, and then select **Choose**.

    > [!NOTE]
    > After you select an identity or profile, it will be displayed in the **Privacy** section. Directories that are listed in this section are no longer indexed by Spotlight.

7. Repeat steps 4-6 for any additional profiles or identities that you want to exclude.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-information-disclaimer.md)]

## More information

Outlook 2016 for Mac uses Outlook Profiles while Outlook for Mac 2011 uses Outlook Identities. This article references both Profiles and Identities and it applies for both versions of the product.
