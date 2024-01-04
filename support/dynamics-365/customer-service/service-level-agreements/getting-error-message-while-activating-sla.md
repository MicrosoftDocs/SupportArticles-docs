---
title: Getting error message while activating SLA
description: Provides a resolution for the issue getting error message while activating SLA.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 01/04/2023
---
# Getting error message while activating SLA

This article provides a resolution for getting an error message while activating SLA.

## Symptoms

Getting error message "String or binary data would be truncated in table '{0}', column '{1}'. Truncated value: {2} " while trying to activate an SLA.

## Cause

The attribute "changedAttributeList" of an SLA entity was hitting the limit of field MAXLENGTH based on the number/name of the field configured in the SLA conditions. MAXLENGTH of changedAttributeList is 4000.

## Resolution

To mitigate this issue, the suggestion is for the users to break down their existing SLA structure. 

Let's use an example for better understanding:

Imagine there's an original SLA, let's call it SLA 1, which includes 10 SLA items. The recommendation is for the users to create a new SLA, let's call it SLA 2. From the original SLA 1, the user can transfer 5 SLA items to the new SLA 2. This means that SLA 2 will now have 5 items, and the remaining 5 items will stay within the existing SLA 1.
As a result, the user will end up with two SLAs, each containing 5 SLA items. This approach aims to streamline and manage the SLAs more effectively based on specific requirements.
