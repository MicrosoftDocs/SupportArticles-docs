---
title: Enabling enhanced presence privacy mode updates presence status of contacts
description: Describes an issue that causes Lync users to have to add other Lync users with whom they want to share their presence to their Lync 2013 client's contact list.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: miadkins
ms.custom: 
  - CSSTroubleshoot
ms.author: v-six
appliesto: 
  - Lync Server 2013
  - Lync Server 2010 Enterprise Edition
  - Lync Server 2010 Standard Edition
ms.date: 03/31/2022
---

# Enabling Lync Server enhanced presence privacy mode updates the presence status of some Lync contacts to "unavailable"

## Summary

The default Microsoft Lync 2013 client presence configuration displays the presence of all the contacts that are added to the Lync client's contact list. Enabling enhanced presence privacy mode for a Lync Server pool, site, or service will affect the presence state of some of the Lync user's contacts. After the enhanced presence privacy mode is enabled for Lync clients, Lync users will have to add other Lync users with whom they want to share their presence to their Lync client's contact list. If this action is not taken, the user's their contacts will show a presence status of **unavailable** in the contact list of the subscribing Lync client. 

### How to determine whether enhanced presence privacy mode is enabled

#### Lync client

The information that follows presents the steps that you should follow to confirm that the Lync enhanced presence privacy mode is enabled for the Lync clients on the Microsoft Lync Server network. To confirm that the Lync client that has contacts that display a presence status of **unavailable** is using the Lync enhanced presence privacy mode, follow these steps:

**On Windows 8**

1. Press the Windows Function key to access the home page.   
2. Click the Lync client icon.   

**On Windows 7**

1. Click Start, and then click All Programs.   
2. Start the installed version of the Lync client.   

To confirm that the enhanced presence privacy mode is enabled on the Lync client, follow these steps:

1. On the Lync **Show** menu, click **Tools**, and then click **Options**.   
2. Click the **Status** option.   
3. If the Lync enhanced presence privacy mode is enabled, the you see the following two options:

   - **I only want people in contacts to see my presence**   
   - **I want everyone to be able to see my presence**   
   
> [!NOTE]
> The **I only want people in contacts to see my presence** option is the default for the enhanced presence privacy mode policy.

#### Lync Server

If the Lync enhanced presence privacy mode is not enabled for the Lync client that has the issue with the presence status for its contacts, follow these to confirm that the enhanced presence privacy mode is configured on the Lync Server network.

Follow these steps on a computer that supports the installation of the Lync Server Administrative tools for confirmation that the Lync Server network has the enhanced presence privacy mode enabled.

**On Windows Server 2012**

1. Press the Windows Function key to access the home page.   
2. Click the Lync Server Management Shell icon.   

**On Windows Server 2008**

1. Click **Start**, and then click **All Programs**.   
2. Click the Microsoft Lync Server folder, and then double-click the **Lync Server Management Shell** option.   
3. In the Lync Server Management Shell command prompt, type the following command:

   Get-CsPrivacyConfiguration   

If enhanced presence privacy mode is enabled for the specified Lync Server network, you see the following information in the listed configuration:

EnablePrivacyMode : True

> [!NOTE]
> The Lync Server privacy configuration policy can be set at the pool, site, or service (User Services) level.

If **EnablePrivacyMode** is set to false for all its displayed instances that are returned from the Get-CsPrivacyConfiguration Windows PowerShell command, the enhanced presence privacy mode is not the cause of the Lync contact presence issue.

For more information about how to use the Lync Server enhanced presence privacy mode policy configurations, see the following documentations:

- [Configuring enhanced presence privacy mode in Lync Server 2013](/lyncserver/lync-server-2013-configuring-enhanced-presence-privacy-mode)
- [Get-CsPrivacyConfiguration](/powershell/module/skype/Get-CsPrivacyConfiguration)
- [Set-CsPrivacyConfiguration](/powershell/module/skype/Set-CsPrivacyConfiguration)

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
