---
title: Error no organization was specified in the configuration file 
description: This article provides a resolution for the problem that occurs when you configure the Microsoft Dynamics CRM Online client.
ms.reviewer: jadenb, ehagen
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# "No organization was specified in the configuration file" error when you configure the Microsoft Dynamics CRM Online Client for Outlook

This article provides a resolution for the problem that occurs when you configure the Microsoft Dynamics CRM Online client.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 2449640

## Symptoms

When you configure the Microsoft CRM Online Client for Outlook, you receive the following error message

> No organization was specified in the configuration file

## Cause

The user has not accepted the invitation to use CRM Online.

## Resolution

To fix this issue, follow these steps:

1. Accept the invitation for the organization by performing one of the two steps:

    1. Have the user click on the link in their email to accept the user invitation. Follow the wizard and accept the terms of service.

    1. Have the user open Internet Explorer, and go to `https://crm.dynamics.com`, have them click on the CRM Online Login button and then enter the Windows Live ID that is added as a user to your CRM Online Organization. Follow the wizard and accept the terms of service.

1. Configure Outlook for the user.
