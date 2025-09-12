---
title: Mail-enabled groups aren't synchronized to Microsoft 365
description: Discusses an issue in which mail-enabled groups that have an email address aren't synced from an on-premises environment to Microsoft 365.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Groups, Lists, Contacts, Public Folders
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: willfid, v-six
appliesto: 
  - Exchange Online
  - Azure Active Directory
  - Microsoft 365
search.appverid: MET150
ms.date: 01/24/2024
---
# Mail-enabled groups that have an email address aren't synchronized to Microsoft 365

_Original KB number:_ &nbsp; 2508722

## Problem

When you use the Microsoft Azure Active Directory Sync Tool to sync your on-premises Active Directory Domain Services (AD DS) environment to Microsoft 365, you notice that mail-enabled groups that have an email address aren't synced to Microsoft 365.

This issue occurs if a display name isn't specified for the on-premises mail-enabled group.

## Solution

> [!IMPORTANT]
> This section contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more info about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To fix this issue, make sure that the on-premises mail-enabled group has a display name. You can use a tool such as Active Directory Service Interfaces Editor (ADSI Edit) or the LDP tool to populate the `displayName` attribute for the mail-enabled group in the on-premises AD DS environment.

The following procedure describes how to edit a display name by using ADSI Edit.

1. On a domain controller or a computer on which the Windows Server Administration Toolkit is installed, click **Start**, click **Run**, type `adsiedit.msc` in the **Open** box, and then click **OK**.

   :::image type="content" source="media/mail-enabled-groups-not-synchronized/run-box.png" alt-text="Screenshot of the Run dialog box.":::

2. Right-click **ADSI Edit**, and then click **Connect to**.

   :::image type="content" source="media/mail-enabled-groups-not-synchronized/connect-to.png" alt-text="Screenshot of the A D S I Edit window.":::

3. Under **Connection Point**, click **Select a well known Naming Context**, and then make sure that **Default naming context** is selected in the drop-down box.

   :::image type="content" source="media/mail-enabled-groups-not-synchronized/name.png" alt-text="Screenshot of the Connection Settings dialog box selecting a well known Naming Context and the Default naming context.":::

4. In the navigation pane on the left side, in the AD DS hierarchy, locate the mail-enabled group that isn't synced to Microsoft 365. Right-click the group, and then click **Properties**.

   :::image type="content" source="media/mail-enabled-groups-not-synchronized/group-properties.png" alt-text="Screenshot of the navigation pane showing mail-enabled groups.":::

5. Click **Filter**, and then clear the **Show only attributes that have values** option.

   :::image type="content" source="media/mail-enabled-groups-not-synchronized/clear-option.png" alt-text="Screenshot of the Accounting Admin Properties dialog box showing the Filter and the Show only attributes that have values option.":::

6. On the **Attribute Editor** tab, locate the `displayName` attribute, and then double-click it.

   :::image type="content" source="media/mail-enabled-groups-not-synchronized/displayname-attribute.png" alt-text="Screenshot of the Accounting Admin Properties dialog box showing the Attribute Editor tab and the displayName attribute.":::

    In this example, the value of the `displayName` attribute is set to **\<not set>**. This is reason why the group isn't synced to Microsoft 365.

7. In the **Value** box, enter a display name for the group, and then click **OK**.

   :::image type="content" source="media/mail-enabled-groups-not-synchronized/enter-value.png" alt-text="Screenshot of the String Attribute Editor dialog box showing the Value box.":::

8. Exit ADSI Edit.
9. Set the value of the FullSyncNeeded registry entry to 1. To do this, follow these steps:

   1. Open Registry Editor. To do this, click **Start**, click **Run**, type `regedit`, and then press Enter.
   2. In Registry Editor, locate the following registry subkey:  

      `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSOLCoExistence`

   3. Right-click the `FullSyncNeeded` registry entry, and then click **Modify**.
   4. Type **1** in the **Value data** box, and then click **OK**.
   5. Exit Registry Editor.

10. Force directory synchronization or wait for the Azure Active Directory Sync Tool to sync the on-premises mail-enabled group to Microsoft 365.

## More information

For more info about how to install and to use ADSI Edit (Adsiedit.msc), go to [ADSI Edit (adsiedit.msc)](/previous-versions/windows/it-pro/windows-server-2003/cc773354(v=ws.10)).

For more info about how to install and to use the LDP tool (Ldp.exe), go to [Ldp Overview](/previous-versions/windows/it-pro/windows-server-2003/cc772839(v=ws.10))

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
