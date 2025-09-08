---
title: Can't configure Out of Office messages in OWA
description: Discusses a problem in which users can't configure Out of Office messages in Outlook Web App or Exchange Control Panel in an Active Directory multi-domain environment. Provides a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: batre, jmartin, v-six
ms.custom: 
  - sap:Clients and Mobile\Can't Connect to Mailbox with OWA
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
ms.date: 01/24/2024
---
# Users receive an error (object couldn't be found) and can't configure Out of Office messages in Outlook Web App or Exchange Control Panel

_Original KB number:_ &nbsp; 3124055

## Symptoms

Consider the following scenario:

- You have an Active Directory Domain Services (AD DS) multi-domain environment.
- In this environment, Active Directory user accounts are located in a different AD domain than the AD domain in which Exchange Server 2016 is installed. For example, Exchange Server 2016 is installed in Child.Contoso.com and user accounts are located in contoso.com.

In this scenario, users can't configure an Out of Office message from within Outlook Web App or the Exchange Control Panel (ECP).

Additionally, users receive the following error message:

> The operation couldn't be performed because object 'contoso.com/Users/A2' couldn't be found on 'condc2.child.contoso.com'.

## Workaround

To work around this problem, revert to the classic ECP user interface. To do this, Use follow these steps:

1. Sign in to ECP.
2. On the **Options** menu, expand **Mail**, and then click **Other**.

    :::image type="content" source="media/cannot-configure-out-of-office-message-owa-ecp/select-other-option.png" alt-text="Screenshot of selecting the Other options.":::

3. Click **Go to the earlier version**.

    :::image type="content" source="media/cannot-configure-out-of-office-message-owa-ecp/select-go-to-the-earlier-version.png" alt-text="Screenshot of the Go to the earlier version link.":::

## Status

Microsoft is researching this problem and will post more information in this article when the information becomes available.
