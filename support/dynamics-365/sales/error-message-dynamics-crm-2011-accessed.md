---
title: Error when Dynamics CRM 2011 is accessed through a mobile device
description: This article provides a resolution for the problem that occurs when Dynamics CRM 2011 is accessed through a mobile device.
ms.reviewer: v-anlang
ms.topic: troubleshooting
ms.date: 
---
# Error message when Dynamics CRM 2011 is accessed through a mobile device

This article provides a resolution for the problem that occurs when Dynamics CRM 2011 is accessed through a mobile device.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2632452

## Symptoms

An error message may be received when you try to access Microsoft Dynamics CRM 2011 through a mobile device:

> Unexpected error.
>
> An error has occurred {1}{0}

## Cause

The user is missing a security role assigned to their user account in Dynamics CRM 2011.

## Resolution

Sign in to Microsoft Dynamics CRM 2011 as a user with the System Administrator security role and assign the user receiving the error the proper security role for their Dynamics CRM access level.
