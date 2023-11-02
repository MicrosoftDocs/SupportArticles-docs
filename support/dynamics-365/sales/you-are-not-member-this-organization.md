---
title: You aren't a member of this organization
description: Provides a resolution to an error that occurs when you sign into Dynamics CRM Online.
ms.reviewer: chanson, dmartens
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-access
---
# You are not a member of this organization error message displays when you signing into Microsoft Dynamics CRM 2011 Online

This article provides a resolution to an error that occurs when you sign into Dynamics CRM Online.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 2652895

## Symptoms

- Symptom 1

    When accessing CRM Online through the Microsoft Office Services Portal, you get the following error message:

    > User `username@organization.onmicrosoft.com` does not belong to organization "OrganizationName". Please check your organization name and try again.

- Symptom 2

    When accessing CRM Online with a Windows Live ID, you get the following error message:

    > You are not a member of this organization  
    You (`liveidusername@live.com`) do not belong to the organization "OrganizationName". Verify the organization name and try to sign in again.

## Cause

- Cause 1

    It's because of being signed into a Dynamics CRM Online organization that is using a Windows Live ID and then trying to signing into a Dynamics CRM organization with a User ID that is associated with your Office 365 Services. The cookies that are used in the Internet Explorer browser sessions are trying to use your previous credentials to sign in.

- Cause 2

    It's because of being signed into a Dynamics CRM Online organization with a User ID that is associated with your Office 365 Services and then trying to sign into a Dynamics CRM organization that is using a Windows Live ID. The cookies that are used in the Internet Explorer browser sessions are trying to use your previous credentials to sign in.

## Resolution

To resolve either of the issues, use one of the following resolutions:

- Resolution 1:

    Select the **Sign Out** button on the page that you see the error on. Then log back in with the correct sign-in to access your Dynamics CRM Online organization.

- Resolution 2:

    Start Internet Explorer in, inPrivateBrowsing mode. Then try to access your Dynamics CRM Online Organization.

## More information

This issue is planned to be addressed in a later release of Dynamics CRM Online.
