---
title: Behavior when using Office Online Server and SharePoint with multiple zones
description: This article describes the behavior when using Office Online Server and SharePoint with multiple zones.
author: simonxjx
manager: willchen
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.author: arhinesm
---

# Behavior when using Office Online Server and SharePoint with multiple zones

## Issue

The configuration of Office Online Server with multiple alternate access mappings and zones in SharePoint Server.

## Behavior

Office Online Server will use the default zone set in SharePoint Server for the respective web application.

For example:

![alternate access mappings](./media/multiple-alternate-access-mapping-zone/access-mappings.png)

The default zone URL is http://sp2013t. So this is the URL that Office Online Server will use to contact the SharePoint Server.

You can test and make sure that the URL can be accessed from the Office Online Server, if it's not, you will have to correct the connectivity here, or Office Online Server won't work correctly.
