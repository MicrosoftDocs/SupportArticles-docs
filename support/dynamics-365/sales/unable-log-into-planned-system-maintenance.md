---
title: Unable to log into after planned System Maintenance
description: This article provides a resolution for the problem where you are unable to log into Microsoft Dynamics CRM Online by using the web client.
ms.reviewer: debrau, chanson
ms.date: 03/31/2021
ms.subservice: d365-sales-access
---
# After planned System Maintenance, a user cannot log into Microsoft Dynamics CRM Online

This article helps you resolve the problem where you are unable to log into Microsoft Dynamics CRM Online by using the web client.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 2715248

## Symptoms

After a planned System Maintenance period, a user is unable to log into Microsoft Dynamics CRM Online using the web client due to the following error message:

> You have signed in with a Windows Live ID that is not part of an organization. You can try signing in with another Windows Live ID that is a member of an organization.

## Cause

This is a known issue that Microsoft is currently investigating.

## Resolution

To restore the user's access Microsoft Dynamics CRM Online, follow these steps:

1. Sign-in to Microsoft Dynamics CRM Online with a user that has permissions to resend user invitations. By default the System Administrator role has the permissions.
1. In Microsoft Dynamics CRM Online, click **Settings**, click **Administration**, and click **Users**.
1. Open the affected user record.
1. In the ribbon, click **Send Invitation**.
1. Click **Ok** in the **Confirm Invitation Reset** dialog box.

Afterwards, the user experiencing the issue may accept the invitation to regain access to Microsoft Dynamics CRM Online.

## More information

If you are the administrator and you are getting the error message and no other user in the system has the permissions to resend the user invite then you will need to contact Microsoft Support.
