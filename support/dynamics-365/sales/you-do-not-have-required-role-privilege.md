---
title: You don't have required role or privilege
description: Provides a solution to a privilege issue that occurs when you try to use the Dynamics 365 App for Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# You don't have required role or privilege to complete this action error occurs in Microsoft Dynamics 365 App for Outlook

This article provides a solution to an error that occurs when you try to use the Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 4555675

## Symptoms

When attempting to use the Dynamics 365 App for Outlook, you see the following message:

> "You don't have required role or privilege to complete this action. Please contact your administrator to get necessary access."

## Cause

This message can appear when a user without the System Administrator role tries to open Dynamics 365 App for Outlook ,and their mailbox is configured with a Dynamics 365 Sandbox environment with Admin mode turned enabled. When Admin Mode is enabled, only users with the System Administrator role can access the environment.

## Resolution

Disable Admin Mode.

## More information

[Manage Sandbox instances](/dynamics365/admin/manage-sandbox-instances)
