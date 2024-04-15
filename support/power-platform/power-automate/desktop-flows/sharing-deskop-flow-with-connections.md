---
title: Can't execute a shared desktop flow after changing the connection
description: Provides a resolution for the issue that a co-owner receives an error when executing a shared desktop flow if the ownership of the connection is changed.
author: quseleba
ms.author: quseleba
ms.reviewer: pefelesk, quseleba, kvivek, tapanm
ms.date: 03/23/2023
ms.custom: sap:Desktop flows\Working with Power Automate for desktop
---

# Can't execute a shared desktop flow when a co-owner uses another connection

## Symptoms

Desktop flows containing connections used by cloud connectors can be shared just as every other desktop flow can.

For the time being, though, such a flow, if modified by multiple owners, may result in erroneous behavior.

Consider the following scenario as an example:

- Co-owner A creates a desktop flow that utilizes SharePoint connector actions. It results in a working SharePoint connection that co-owner A owns.
- Co-owner A shares the desktop flow with co-owner B.
- Co-owner B tries to execute the desktop flow and receives an error since they don't have access to the SharePoint connection that the flow references.
- Co-owner B modifies the SharePoint action to use a connection that co-owner B owns and saves the flow.
- Co-owner B can now execute the flow successfully. However, co-owner A is now receiving an error since they don't own the SharePoint connection in use (it's owned by co-owner B).

When this issue occurs, the desktop flow will be saved in an erroneous state even if the connection is left unchanged. In the above scenario, for example, co-owner B saving the flow with an added desktop flow action will result in a failed execution for every co-owner of the desktop flow.

## Resolution

To solve this issue, you can create copies of desktop flows dedicated to every co-owner who will work on them. In the above scenario, for example, create two copies of the desktop flow. The copy of the desktop flow for co-owner A uses a SharePoint connection owned by co-owner A. And the copy of the desktop flow for co-owner B uses a SharePoint connection owned by co-owner B.
