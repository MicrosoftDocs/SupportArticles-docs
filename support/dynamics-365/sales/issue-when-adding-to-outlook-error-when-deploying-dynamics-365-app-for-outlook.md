---
title: Issue when adding to outlook error when deploying Dynamics 365 App for outlook
description: Unable to deploy Dynamics 365 App for outlook and you receive an error that states issue when adding to outlook. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# "Issue when adding to outlook" error occurs when deploying Microsoft Dynamics 365 App for outlook

This article provides a resolution for the error **Issue when adding to outlook** that may occur when deploying Microsoft Dynamics 365 App for outlook.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4528578

## Symptoms

While deploying app for outlook from Microsoft Dynamics CE, you will see an error in red in front of users mailbox **Issue when adding to outlook**. If you select to see more details, you see the message **Invalid data source operation**.

If you navigate to Manage addins from a user's mailbox, you will see the following error:

> Could not locate Client Access Virtual Directory Object with InternalURl stamped for ECP, service.

> [!NOTE]
> For an Office addin to be deployed to a user's mailbox in Microsoft Exchange Server, `AppsForOfficeEnabled` should be true. You can the following command to check the configuration settings through Exchange Management Shell (EMS).  
`Get-OrganizationConfig | Format-List AppsForOfficeEnabled`

## Cause

This is due to the Discovery search from Exchange Admin Center (EAC). Whenever discovery search is performed for the first time using EAC in Exchange Server 2013, it will check for the following 6 internal URLs in the background and it will cache it locally.

- Found URL: `https://e15-cas.contoso.com/owa`
- Found URL: `https://e15-cas.contoso.com/ecp`
- Found URL: `https://e15-cas.contoso.com/EWS/Exchange.asmx`
- Found URL: `https://e15-cas.contoso.com/Microsoft-Server-ActiveSync`
- Found URL: `https://e15-cas.contoso.com/OAB`
- Found URL: `https://e15-cas.contoso.com/mapi`

[GlobalServiceUrls.DiscoverUrlsIfNeeded] Successfully found all needed VDirs

## Resolution

Make sure all the required virtual directories are present and internal URLs are published on those virtual directories.

For more information on how to configure Exchange virtual directories, see [Configure mail flow and client access on Exchange servers Step 4: Configure external URLs](/Exchange/plan-and-deploy/post-installation-tasks/configure-mail-flow-and-client-access?view=exchserver-2019#step-4-configure-external-urls&preserve-view=true).
