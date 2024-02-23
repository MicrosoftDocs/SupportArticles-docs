---
title: Manager cannot respond to a meeting invite
description: Provides a resolution for the issue that a manger can't respond to a meeting invitation in Microsoft Outlook.
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
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
search.appverid: MET150
ms.date: 10/30/2023
---
# Manager is unable to respond to a meeting invite

_Original KB number:_ &nbsp; 2697959

## Symptoms

When a manager (in a manager-delegate pair) opens a meeting invite, they do not see the **Accept**, **Tentative**, or **Decline** options under the **Change Response** control. Instead, they see only **No Response Required** in the Respond section of the ribbon, as shown in the following figure.

:::image type="content" source="media/manager-cannot-respond-to-meeting-invite/no-response-required.png" alt-text="Screenshot for the ribbon of a meeting invite." border="false":::

Normally, the manager sees the **Accept**, **Tentative**, and **Decline** options under the Change Response control on the ribbon, as shown in the following figure.

:::image type="content" source="media/manager-cannot-respond-to-meeting-invite/change-response.png" alt-text="Screenshot for the options under the Change Response control on the ribbon." border="false":::

## Cause

This problem occurs when the following data exists in the Windows Registry.

Key: HKEY_CURRENT_USER\Software\Microsoft\Office\x.0\Outlook\Options\Calendar  
DWORD: DisableResponseButtons  
Value: 1

or

Key: HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\x.0\Outlook\Options\Calendar  
DWORD: DisableResponseButtons  
Value: 1

The *x.0* in the above registry hives will either be 14.0 for Outlook 2010, or 12.0 for Outlook 2007.

## Resolution

Use the following steps to change the value of `DisableResponseButtons` to zero (0) in the non-policy section of the Windows Registry.

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

1. Exit Outlook.
2. Start Registry Editor.

    In Windows Vista and in Windows 7:

    Select **Start**, type *regedit* in the **Start Search** box, and then press Enter.
    If you are prompted for an administrator password or for confirmation, type the password, or select **Allow**.

    In Windows XP:

    Select **Start**, select **Run**, type *regedit*, and then select **OK**.

3. Locate and then select the following registry key:

   `HKEY_CURRENT_USER\Software\Microsoft\Office\x.0\Outlook\Options\Calendar`

   The *x.0* in the above key path is 14.0 for Outlook 2010 and 12.0 for Outlook 2007.

4. Select the `DisableResponseButtons` value.
5. On the **Edit** menu, select **Modify**.
6. Type *0*, and then select **OK**.
7. Exit Registry Editor.
8. Start Outlook.

> [!NOTE]
> If the `DisableResponseButtons` value is listed under the \Polices hive, the setting is being administered using group policy. See your administrator to change this value in the registry.

## More information

If a manager is configured with the default delegate setting where they receive informational meeting items, they will not be able to act on a meeting invite if they view it in the reading pane. This is demonstrated in the following figure.

:::image type="content" source="media/manager-cannot-respond-to-meeting-invite/meeting-invite-reading-pane.png" alt-text="Screenshot for the reading pane of a meeting invite.":::

However, the manager can accept or decline a meeting if they open the meeting invite in an inspector window (double-click on the item to open it). If `DisableResponseButtons`=**1** in the registry, then they will not be able to act on meeting invites when they open them.
