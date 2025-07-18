---
title: How to enable the Conferencing Add-in for Outlook
description: Describes how to enable the Conferencing Add-in for Outlook in Outlook 2007 and Outlook 2003.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Outlook 2007
  - Outlook 2003
ms.date: 03/31/2022
---

# How to enable the Conferencing Add-in for Outlook

## Summary

After you install the Conferencing Add-in for Outlook in Microsoft Office Outlook 2007 or Outlook 2003, the Conferencing menu and the Microsoft Office Live Meeting toolbar may not appear in Outlook. If this happens, you can manually enable the Conferencing Add-in for Outlook, and then view the registry to make sure that the Conferencing Add-in for Outlook is enabled in Outlook.

### How to enable the Conferencing Add-in for Outlook

To manually enable the Conferencing Add-in for Outlook, follow the steps for the version of Outlook that you are running.

##### Outlook 2007

1. Start Outlook 2007.   
2. On the **Tools** menu, click **Trust Center**. The screen shot for this step is listed below.

    :::image type="content" source="./media/enable-conferencing-add-in-for-outlook/trust-center.png" alt-text="Screenshot that shows the Trust Center selected in the Tools menu.":::
3. In the **Trust Center** dialog box, click the **Add-ins** tab. The screen shot for this step is listed below.
    
    :::image type="content" source="./media/enable-conferencing-add-in-for-outlook/add-ins.png" alt-text="Screenshot that shows the Add-ins setting window.":::
4. On the **Manage** menu, click **COM Add-ins**, and then click **Go**.   
5. In the **COM Add-Ins** dialog box, select the **Microsoft Conferencing Add-in for Microsoft Office Outlook** check box, and then click **OK**.   

The Conferencing menu and the Live Meeting toolbar appear.

##### Outlook 2003

1. Start Outlook 2003.   
2. On the **Help** menu, click **About Microsoft Office Outlook**.   
3. In the **About Microsoft Office Outlook** dialog box, click **Disabled Items**.   
4. In the **Disabled Items** dialog box, click **Microsoft Conferencing Add-in for Microsoft Office Outlook**, and then click **Enable**.   
5. Click **Close**.   
6. In the **About Microsoft Office Outlook** dialog box, click **OK**.   

The Conferencing menu and the Live Meeting toolbar appear.

### Examine the registry to determine whether the Conferencing Add-in for Outlook is enabled

To do this, follow these steps:

1. Click **Start**, click **Run**, type regedit, and then click **OK**.   
2. In Registry Editor, locate the following registry subkey:  
**HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\Outlook\Addins\Microsoft.LiveMeeting.Addins**
:::image type="content" source="./media/enable-conferencing-add-in-for-outlook/registry-editor.png" alt-text="Screenshot that shows the registry subkey located in the registry editor." border="false":::   
1. In the details pane, double-click LoadBehavior. If the value is 3 in the Value data box, the Conferencing Add-in for Outlook is enabled.   

### Control the loading of the Conferencing Add-in for Outlook

A COM add-in has to register itself with each Office application in which it runs. To register itself with a particular program, the add-in should create a subkey by using its ProgID as the name for the key, in the following registry locations:

- HKEY_CURRENT_USER\Software\Microsoft\Office\\\<OfficeApp>\Addins\\\<ProgID>   
- HKEY_LOCAL_MACHINE\Software\Microsoft\Office\\\<OfficeApp>\Addins\\\<ProgID>   
The add-in can provide values at these key locations for both a friendly display name and a full description. In addition, the add-in should specify its desired load behavior by using a DWORD value called LoadBehavior. This value determines how the add-in is loaded by the host program.

The Conferencing Add-in for Outlook uses the LoadBehavior values of 2 for disabledand 3 for enabled.

If the HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\Outlook\Addins\Microsoft.LiveMeeting.Addins - LoadBehavior registry entry is set to 3:

- In the COM Add-ins dialog box, the Microsoft Conferencing Add-in for Outlook entry will be selected.   

If the HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\Outlook\Addins\Microsoft.LiveMeeting.Addins - LoadBehavior registry entry is set to 2:

- In the COM Add-ins dialog box, the Microsoft Conferencing Add-in for Outlook entry will not be selected.   

The registry settings for COM Add-ins can be applied at the level of the computer or the account of the user who is signed in. Registry settings that are applied at the level of the computer will override the registry settings that are applied at the level of the signed-in user.

#### Did this fix the problem?

Check whether the problem is fixed. If the problem is fixed, you are finished with this section. If the problem is not fixed, you can [contact support](https://support.microsoft.com/contactus).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
