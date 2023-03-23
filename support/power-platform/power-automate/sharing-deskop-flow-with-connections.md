---
title: Sharing a desktop flow with connections to other co-owners
description: Desktop flows containing connections used by cloud connectors can be shared as every other desktop flow. For the time being though, such a flow, if modified by multiple owners, may result in erroneous behavior.
ms.author: pefelesk
ms.reviewer: pefelesk
ms.date: 03/23/2023
ms.subservice: power-automate-desktop-flows
---

# Sharing a desktop flow with connections to other co-owners

Desktop flows containing connections used by cloud connectors can be shared as every other desktop flow.

For the time being though, such a flow, if modified by multiple owners, may result in erroneous behavior.

## Example:

- Co-owner A creates a desktop flow that utilizes SharePoint connector actions (resulting in a working SharePoint connection co-owner A owns).
- Co-owner A shares the desktop flow with co-owner B.
- Co-owner B tries to execute the desktop flow and receives an error since they do not have access to the SharePoint connection that the flow references.
- Co-owner B modifies the SharePoint action to use a connection that co-owner B owns, and saves the flow.
- Co-owner B can now execute the flow successfully. However, co-owner A is now receiving an error since they do not own the SharePoint connection in use (owned by co-owner B).
 

When this happens, the desktop flow will be saved in an erroneous state even if the connection is left unchanged. In the above scenario for example, co-owner B saving the flow with added desktop flow action will result in a failed execution for every co-owner of the desktop flow.
 

## Proposed approach:

Create copies of desktop flows dedicated to every co-owner who will work on them. In the above scenario for example, create two copies of the desktop flow. Copy of desktop flow for co-owner A uses SharePoint connection owned by co-owner A. And copy of desktop flow for co-owner B uses SharePoint connection owned by co-owner B. 

