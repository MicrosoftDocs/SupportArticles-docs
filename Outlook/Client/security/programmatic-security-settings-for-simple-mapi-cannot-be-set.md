---
title: Cannot set programmatic security settings for Simple MAPI
description: Discusses an issue in which the programmatic security settings for Simple MAPI cannot be configured by using the existing Outlook Group Policy template.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz, sbradley, gregmans
appliesto: 
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook 2010 programmatic security settings for Simple MAPI cannot be configured by using the Group Policy Object

_Original KB number:_ &nbsp; 2723336

## Symptoms

You configure Microsoft Outlook 2010 security settings by using the Group Policy Object. When you do this, you notice that the programmatic security settings for Simple MAPI cannot be configured successfully.

## Resolution

To resolve this issue, configure the corresponding registry entries. To do this, follow these steps.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Set the value data of one or more of the following registry entries to 1 (PromptUser [default]), to 2 (AutoApprove), or to 0 (AutoDeny):
   - PromptSimpleMAPISend
   - PromptSimpleMAPINameResolve
   - PromptSimpleMAPIOpenMessage

   For example, to set the value data of the PromptSimpleMAPISend registry entry to 1, follow these steps:

   1. Select **Start**, select **Run**, type regedit , and then select **OK**.
   2. Locate and then select the following registry subkey:

      `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\14.0\Outlook\Security`

      > [!NOTE]
      > : If this registry path does not exist, create it manually.

   3. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
   4. Type *PromptSimpleMAPISend*, and then press Enter.
   5. Right-click **PromptSimpleMAPISend**, and then select **Modify**.
   6. In the **Value data** box, type *1*, and then select **OK**.
   7. Exit Registry Editor.

You can deploy this registry data by using one of the following methods:

- Group Policy
- A logon script
- An update file (.msp) that is created by the Office Customization Tool (Outlook 2010)

For more information about how to deploy these Simple MAPI settings by using a custom Group Policy template, see the More Information section.

To deploy the Simple MAPI settings by using a custom Group Policy template, follow these steps:

1. Download and extract the following custom Group Policy template from the Microsoft Download Center:

    [https://download.microsoft.com/download/6/D/1/6D113C3D-4651-4DE3-A501-7B602B0E0DEC/Outlk14-simplemapi.adm](https://download.microsoft.com/download/6/d/1/6d113c3d-4651-4de3-a501-7b602b0e0dec/outlk14-simplemapi.adm)

2. If you do not already have the main Group Policy template for Outlook 2010, download and extract the latest template from the Microsoft Download Center:

    [Office 2010 Administrative Template files (ADM, ADMX/ADML) and Office Customization Tool download](https://www.microsoft.com/download/details.aspx?id=18968)

3. Add the Outlk14.adm file that you downloaded in step 2 to your domain controller.

    > [!NOTE]
    > The steps to add the .adm file to a domain controller vary, depending on the version of Windows that you are running. Also, because you may be applying the policy to an organizational unit (OU) and not to the whole domain, the steps may vary in this aspect of applying a policy. Therefore, check your Windows documentation for more information.

4. Add the custom Outlk14-simplemapi.adm file that you downloaded in step 1 to your domain controller.

5. Under **User Configuration**, expand Classic Administrative Templates (ADM) to locate the policy node for your template.

    > [!NOTE]
    > In Windows XP and Windows Server 2003, expand Administrative Templates.

6. For **Exchange Security Form** settings to be set by using Group Policy, you must set the **Outlook Security Mode** setting to **Use Outlook Security Group Policy**. To locate that policy setting, expand **Classic Administrative Templates (ADM)**, expand **Microsoft Outlook 2010**, expand **Security**, and then select **Security Form Settings**. In the details pane, double-click **Outlook Security Mode**. Enable the policy, and then set it to **Use Outlook Security Group Policy**, as is shown in the following screen shot.

   :::image type="content" source="media/programmatic-security-settings-for-simple-mapi-cannot-be-set/outlook-security-mode-window.png" alt-text="Screenshot for setting Use Outlook Security Group Policy." border="false":::
   
   > [!NOTE]
   > The **Outlook Security Mode** Group Policy setting creates the **AdminSecurityMode** value and set it to **3**. This indicates that Outlook will use Group Policy for managing programmatic security.

7. The Simple MAPI options are located in the navigation pane (the left pane) under **Security Forms Settings**, in the **Programmatic Security** node, as shown in the following screenshot. To configure the Simple MAPI options, double-click any policy setting in the details pane. For example, double-click **Configure Simple MAPI sending prompt** to configure what happens when a program tries to send mail programmatically by using SimpleMAPI.

   :::image type="content" source="media/programmatic-security-settings-for-simple-mapi-cannot-be-set/programmatic-security-node.png" alt-text="Screenshot for Programmatic Security node settings." border="false":::

8. In the dialog box for the policy setting, select **Enabled** to enable the policy, and then set the desired behavior in the **Guard Behavior** drop-down.

    For example, the following screenshot shows the **Guard Behavior** options for the Configure Simple MAPI sending prompt setting.

    :::image type="content" source="media/programmatic-security-settings-for-simple-mapi-cannot-be-set/configure-simple-mapi-sending-prompt.png" alt-text="Screenshot for Guard Behavior options.":::

9. After you finish configuring your Simple MAPI policies, and they are propagated to your Outlook clients, you can verify that the policies are available to Outlook by examining the following registry subkey:

   `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\14.0\Outlook\Security`

   The following screenshot shows the registry of an Outlook client on which all three Simple MAPI policies are configured.

   :::image type="content" source="media/programmatic-security-settings-for-simple-mapi-cannot-be-set/registry-settings-for-simple-mapi-policies.png" alt-text="Screenshot for all three Simple MAPI policies are configured." border="false":::

   > [!NOTE]
   > Setting the following registry values to **2** may be used to allow Microsoft Word to send emails through Outlook when using the mail merge feature.
   > - PromptSimpleMAPISend
   > - PromptSimpleMAPINameResolve
   > - PromptSimpleMAPIOpenMessage
  
