---
title: Hyperlinks are not working
description: You receive an error message when you try to set Internet Explorer as your default browser in Windows. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Outlook 2003
  - Outlook 2007
  - Outlook 2010
  - Outlook 2013
  - Outlook 2016
  - Outlook 2019
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 10/30/2023
---

# Hyperlinks are not working in Outlook

## Symptoms

> [!NOTE]
> After you install the Outlook Desktop July 11th security updates, when you open a link in an email, if the path points to a Fully Qualified Domain Name (FQDN) or IP address, you may not be able to open the link or receive the following error message:
>
> **Something unexpected went wrong with this URL**
>
> For more information about this issue, see [Outlook blocks opening FQDN and IP address hyperlinks after installing protections for Microsoft Outlook Security Feature Bypass Vulnerability released July 11, 2023](https://support.microsoft.com/office/outlook-blocks-opening-fqdn-and-ip-address-hyperlinks-after-installing-protections-for-microsoft-outlook-security-feature-bypass-vulnerability-released-july-11-2023-4a5160b4-76d0-465b-9809-60837bbd35a8).

Assume that you set Internet Explorer as your default browser in Windows. When you select a hyperlink in Microsoft Outlook, you receive one of the following error messages, depending on your Outlook version:

> This operation has been cancelled due to restrictions in effect on this computer. Please contact your system administrator.

> Your organization's policies are preventing us from completing this action for you. For more info, please contact your help desk.

## Resolution

To resolve this problem, follow these methods in order. Check whether the problem is resolved after each method.

### Method 1: Reset Internet Explorer settings

#### Internet Explorer 11 and Internet Explorer 10

> [!WARNING]
> If you are using Windows 10, Windows 8.1 or Windows 8, proceed to method 2.

1. Start Internet Explorer.
2. Select **Tools** > **Internet Options**.
3. Select **Advanced** > **Reset**.

   :::image type="content" source="media/hyperlinks-not-working-in-outlook/advanced-tab-on-internet-options.png" alt-text="Screenshot of the Advanced tab on Internet Options." border="false":::

4. In the **Reset Internet Explorer Settings** window, select **Delete personal settings** > **Reset**.

   :::image type="content" source="media/hyperlinks-not-working-in-outlook/reset-internet-explorer-settings.png" alt-text="Screenshot of the Reset Internet Explorer Settings window." border="false":::

5. Select **Close** when it is completed.

   :::image type="content" source="media/hyperlinks-not-working-in-outlook/close.png" alt-text="Screenshot of the close option on the Reset Internet Explorer Settings window." border="false":::

6. Close and restart Internet Explorer.
7. Select **Tools** > **Internet Options**.
8. Select **Programs** > **Set programs**.

   :::image type="content" source="media/hyperlinks-not-working-in-outlook/programs-tab-on-internet-options.png" alt-text="Screenshot of the Programs tab on the Internet Options." border="false":::

9. Select **Set your default programs**.

   :::image type="content" source="media/hyperlinks-not-working-in-outlook/set-your-default-programs.png" alt-text="Screenshot of the Set your default programs option on the Default Programs window." border="false":::

10. In the **Programs** list, select **Microsoft Outlook** > **Set this program as default**.

    :::image type="content" source="media/hyperlinks-not-working-in-outlook/set-this-program-as-default.png" alt-text="Screenshot of the Set Default Programs window when you select Microsoft Outlook in the programs list." border="false":::

11. Scroll back up to the top of the default programs list and highlight **Internet Explorer** and select **Set this program as default**.

    :::image type="content" source="media/hyperlinks-not-working-in-outlook/set-internet-explorer-as-default.png" alt-text="Screenshot of the Set Default Programs window when you select Internet Explorer in the programs list." border="false":::

12. Select **OK**, and close the **Default Programs** dialog box.

#### Internet Explorer 9

1. Start Internet Explorer.
2. Select **Tools** > **Internet Options**.
3. Select **Advanced** > **Reset**.

    :::image type="content" source="media/hyperlinks-not-working-in-outlook/reset-button.png" alt-text="Screenshot of the Reset button on Advanced tab of Internet Options." border="false":::

4. In the **Reset Internet Explorer Settings** window, select the **Delete personal settings** > **Reset**.

    :::image type="content" source="media/hyperlinks-not-working-in-outlook/reset-internet-explorer-settings-in-ie9.png" alt-text="Screenshot of the Delete personal option on the Reset Internet Settings window." border="false":::

5. Select **Close** when it is completed.

    :::image type="content" source="media/hyperlinks-not-working-in-outlook/close-the-reset-window.png" alt-text="Screenshot of the close option on the Reset Internet Explorer Settings window in IE9." border="false":::

6. Restart Internet Explorer.
7. Select **Tools** > **Internet Options**.
8. Select **Programs** > **Set programs**.

    :::image type="content" source="media/hyperlinks-not-working-in-outlook/set-programs.png" alt-text="Screenshot of Set Programs option in Internet Options in IE9." border="false":::

9. Select **Set your default programs**.

    :::image type="content" source="media/hyperlinks-not-working-in-outlook/set-your-default-programs-option.png" alt-text="Screenshot of the Set your default programs option." border="false":::

10. In the **Programs** list, select **Microsoft Outlook** > **Set this program as default**.
11. Select **OK**, and then close the **Default Programs** dialog box.
12. In the **Internet Options** dialog box, select the **Programs** tab, and then select **Make default** under **Default web browser**.

    :::image type="content" source="media/hyperlinks-not-working-in-outlook/make-default.png" alt-text="Screenshot of the Programs tab on Internet Options." border="false":::

13. Select **OK**.

#### Internet Explorer 8 and Internet Explorer 7

1. Start Internet Explorer.
2. On the **Tools** menu, select **Internet Options**.
3. Select **Advanced** > **Reset**.
4. Select **Programs** > **Set programs**.
5. Select **Set Default Programs**.
6. Select **Microsoft Outlook** > **Set this program as default**.
7. Select **OK**, and then close the **Default Programs** dialog box.
8. In the **Internet Options** dialog box, select the **Programs** tab, and then select **Make default** under **Default web browser**.
9. Select **OK**.

#### Internet Explorer 6

1. Start Internet Explorer.
2. On the **Tools** menu, select **Internet Options**.
3. Select **Programs** > **Reset Web Settings**.
4. Under **Internet programs**, make sure that the correct email program is selected.
5. Select the **Internet Explorer should check to see whether it is the default browser** check box.
6. Select **Apply** > **OK**.

   > [!NOTE]
   > You may receive the following message when Internet Explorer starts:  
   > Internet Explorer is not currently your default browser. Would you like to make it your default browser?
   >
   > If you receive this message, select **Yes**.

### Method 2 - Export and import the registry key from another computer

This section is intended for advanced computer users. For help with advanced troubleshooting, ask your system administrator or contact [Microsoft Support](https://support.microsoft.com/contactus/).

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

> [!NOTE]
> Use this method only if the earlier instructions for each browser do not work to resolve this problem.

#### Step 1: Export the registry key from another computer

1. On a computer that does not encounter this problem, select **Start** > **Run**.
2. In the **Open** box, *type regedit*, and then select **OK**.
3. Locate, and then select the registry subkey: `HKEY_LOCAL_MACHINE\Software\Classes\htmlfile\shell\open\command`.
4. On the **File** or **Registry** menu (depending on your operating system), select **Export**.

   :::image type="content" source="media/hyperlinks-not-working-in-outlook/export.png" alt-text="Screenshot of the File menu in Registry Editor.":::

5. Note the location where the file will be saved.
6. Type a unique file name, and then select **Save**.
7. Exit Registry Editor.

#### Step 2: Import the registry key

1. Copy the exported registry key to the desktop on the problem computer.
2. Double-click the .reg file.

    You may receive the following message:

    **Windows 10, Windows 8.1, and Windows 8**

    > Adding information can unintentionally change or delete values and cause components to stop working correctly. If you do not trust the source of this information in C:Users\<yourlogon>Desktop\regkey.reg, do not add it to the registry.

    **Windows 7**

    > Are you sure you want to add the information in drive: location file was copied to\file name.reg to the registry?

3. Select **Yes** > **OK**.

#### Step 3: Verify that the String (Default) value of the HKEY_CLASSES_ROOT \.html key is htmlfile

1. Select **Start** > **Run**.
2. In the **Open** box, *type regedit*, and then select **OK**.
3. Locate, and then select the registry subkey: **HKEY_CLASSES_ROOT \\.html**.
4. Make sure that the value of the **String (Default)**  is "htmlfile". If it's not **htmlfile**, right-click **(Default)**, select **Modify**, input *htmlfile* in the **Value data** box, and then select **OK**.

5. Exit Registry Editor.


