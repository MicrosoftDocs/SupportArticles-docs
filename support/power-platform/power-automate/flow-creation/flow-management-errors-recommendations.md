---
title: Flow Management errors and recommendations
description: Describes Flow Management errors and recommendations.
ms.reviewer: 
ms.date: 03/31/2021
ms.subservice: power-automate-flow-creation
---
# Flow Management errors and recommendations

This article describes Flow Management errors and recommendations.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4515140

## Can't create Flow

- If you're seeing an error when trying to create a Flow with the Common Data Service trigger:

    > "When a record is created, updated, or deleted."

    Because it isn't supported in Flows that aren't hosted in a [solution](/power-automate/overview-solution-flows). You must [create a cloud flow in a solution](/power-automate/create-flow-solution) to use this trigger.

## Can't edit Flow

If you can't edit your Flow, be sure your company IT policies don't block services that are required by Microsoft Flow. See [Limits for automated, scheduled, and instant flows](/power-automate/limits-and-config#required-services) for a list of required services.

## Forms Pro doesn't appear active even though users have a license

Some customers have complained that attempts to use Forms Pro result in an Error Message:  
> "Your IT Department has turned off signup for Microsoft Forms Pro. Contact them to complete signup".

The user might need to sign up for the Microsoft Pro Forms free subscription.
