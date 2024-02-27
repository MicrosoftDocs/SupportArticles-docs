---
title: Email stays in Outbox until manually send or receive
description: This article provides a resolution for the issue that email messages remain in your Outbox until you manually initiate a Send/Receive operation.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gregmans
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Microsoft Office Outlook 2003
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Email stays in the Outbox folder until you manually initiate a send/receive operation in Outlook

_Original KB number:_ &nbsp; 2797572

## Symptoms

When you send an e-mail message in Microsoft Outlook, the message may remain in your Outbox folder as shown in the following figure.

:::image type="content" source="media/email-stays-in-outbox-until-manually-send-or-receive/outbox-folder-in-outlook.png" alt-text="Screenshot shows an email message stuck in the Outbox folder." border="false":::

When this problem occurs, the message remains in your Outbox folder until you manually initiate a Send/Receive operation (for example, press F9 or select send or receive).

## Cause

This problem can occur if the **Send immediately when connected** option is not enabled, as shown in the following figure from Outlook 2016.

:::image type="content" source="media/email-stays-in-outbox-until-manually-send-or-receive/send-immediately-when-connected-setting.png" alt-text="Screenshot of the Outlook Options window, where Send immediately when connected option is highlighted in Send and receive area." border="false":::

This setting is tied to the following registry data, so this setting can also be configured by an administrator through a modification of the registry.

Key: `HKEY_CURRENT_USER\Software\Microsoft\Office<x.0>\Outlook\Options\Mail`

or

Policy key: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office<x.0>\Outlook\Options\Mail`

DWORD: Send Mail Immediately  
Value: 0

> [!NOTE]
> In the above registry key paths, <x.0> represents the Outlook version (16.0 = Outlook 2016, Outlook 2019, or Outlook for Microsoft 365, 15.0 = Outlook 2013, 14.0 = Outlook 2010, 12.0 = Outlook 2007, 11.0 = Outlook 2003).

## Resolution

Use the following steps to re-enable the Send immediately when connected option.

- Outlook 2010 and later versions
  1. On the **File** tab, select **Options**.
  2. In the **Outlook Options** dialog box, select **Advanced**.
  3. In the **Send and receive** section, enable **Send immediately when connected**.
  4. Select **OK**.

- Outlook 2007 and Outlook 2003
  1. On the **Tools** menu, select **Options**.
  2. In the **Options** dialog box, select the **Mail Setup** tab.
  3. In the **Send/Receive** section, enable **Send immediately when connected**.
  4. Select **OK**.

> [!NOTE]
> If you are unable to re-enable this setting because it is grayed out, then the setting is being managed by group policy. In this situation, contact your administrator to have this group policy removed.
