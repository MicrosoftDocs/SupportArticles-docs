---
title: Error on configuration due to incorrect time settings
description: This article explains one of the reasons the Microsoft Dynamics CRM for Outlook Client fails to configure correctly.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Error on configuration of Microsoft Dynamics CRM for Outlook due to incorrect time settings

This article provides a resolution for the error **Could not connect to the server from Microsoft Dynamics CRM because your credentials can not be authenticated** that occurs during the configuration of Microsoft Dynamics CRM for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 2909439

## Symptoms

When a user attempts to configure the Microsoft Dynamics CRM for Outlook client, using the Configuration Wizard of Microsoft Dynamics CRM for Outlook, with the parameters:

- Server Information | Server URL: CRM Online

Once the user hits the **Test Connection** button, it displays the following error message:

> Could not connect to the server from Microsoft Dynamics CRM because your credentials can not be authenticated. Check the connection or contact your administrator for more help.

The access using Web works properly.

## Cause

Issue of synchronization of date, time, and timezone of workstation with the Domain Controller of Active Directory or Microsoft Dynamics CRM Online servers.

## Resolution

Check synchronization of date, time, and timezone of workstation and Domain Controller of Active Directory.

If they are in disagreement, apply the `net time /set` command.
