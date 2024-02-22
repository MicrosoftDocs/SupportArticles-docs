---
title: Outlook can't set OOF status or view Free busy
description: Resolves an issue in which users may be unable to view free or busy data in an Exchange Server 2010 and Exchange Server 2013 coexistence environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: djball
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
ms.date: 10/30/2023
---
# Outlook clients may be unable to set OOF status or view Free busy in an Exchange Server 2013 coexistence environment

_Original KB number:_ &nbsp; 2956962

## Symptoms

In a Microsoft Exchange Server 2010 and Exchange Server 2013 coexistence environment, Outlook clients may be unable to set out of office or view free or busy information. Specifically, clients may experience the following symptoms:

- When you try to schedule meetings, the free or busy times for attendees aren't displayed. Only hash marks are displayed for attendees.
- When you try to set the out of office, attendees may receive the following error message:

    > Your Out of Office settings cannot be displayed, because the server is currently unavailable. Try again later.

Additionally, the HTTP proxy will display the following HTTP exception for each failed proxy request:

> Cannot find the appropriate SOAP header or body.

## Cause

The Internet Information Services (IIS) **uploadReadAheadSize** attribute configures a limit for the number of bytes in the entity body of a request and the number of bytes that a web server will read into a buffer and pass to an ISAPI extension. This issue occurs because the setting for the **uploadReadAheadSize** attribute is too small.

## Resolution

To resolve this issue, increase the size of the IIS **UploadReadAheadSize** setting on the Exchange Server 2013 CAS role. To do this, follow these steps:

1. Open IIS Manager.
2. Expand **Sites**, expand **Default Web Site**, click the **EWS** virtual directory, and then click **Configuration Editor** on the feature page.

    :::image type="content" source="./media/outlook-cannot-set-oof-status-view-busy-free/select-configuration-editor.png" alt-text="Screenshot for selecting Configuration Editor.":::

3. In the **Section** box, expand **system.webServer**, and then click **serverRuntime**.

    :::image type="content" source="./media/outlook-cannot-set-oof-status-view-busy-free/select-serverruntime-node.png" alt-text="Screenshot for selecting the serverRuntime node.":::

4. Set **UploadReadAheadSize** to **49152**.

    :::image type="content" source="./media/outlook-cannot-set-oof-status-view-busy-free/set-uploadreadaheadsize-attribute.png" alt-text="Screenshot for setting the UploadReadAheadSize value.":::

5. Run the `iisreset` command to reset IIS.
