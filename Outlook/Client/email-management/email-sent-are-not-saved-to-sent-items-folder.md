---
title: Emails are not saved to Sent Items
description: This article provides a resolution for the issue that email messages that are sent by using Microsoft Outlook 2007 or later versions are not saved to the Sent Items folder.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: TasitaE, aruiz
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Email sent using Outlook are not saved to the Sent Items folder

_Original KB number:_ &nbsp; 2958272

## Symptoms

After you send an email using Microsoft Outlook 2007 or later versions, a copy of the email message is not saved to the Sent Items folder.

## Cause

The **Save copies of messages in the Sent Items folder** option in Outlook is disabled.

## Resolution

Enable the **Save copies of messages in the Sent Items folder** option by following the steps below for your version of Outlook.

In Outlook 2010 or later versions:

1. Select **File**, and then **Options**.
2. In the **Outlook Options** dialog, select **Mail**.
3. Under the **Save messages** section, enable the **Save copies of messages in the Sent Items folder** option.

   :::image type="content" source="media/email-sent-are-not-saved-to-sent-items-folder/save-messages-option.png" alt-text="Screenshot shows steps to enable the Save copies of messages in the Sent Items folder option in Outlook 2010 or later versions.":::

4. Select **OK**.

In Outlook 2007:

1. Select **Tools** > **Options**.
2. Under the **Preferences** tab, select **E-mail Options...**
3. Enable the **Save copies of messages in Sent Items folder** option.

   :::image type="content" source="media/email-sent-are-not-saved-to-sent-items-folder/save-message-email-option.png" alt-text="Screenshot shows steps to enable the Save copies of messages in the Sent Items folder option in Outlook 2007." border="false":::

4. Select **OK**.

## More information

The **Save copies of messages in Sent Items folder** option can be controlled using the Outlook Group Policy setting. You can find the policy setting below, depending on your version of Outlook.

- Outlook 2007:

  Policy Path: User Configuration/Administrative Templates/Classic Administrative Templates (ADM)/Microsoft Office Outlook 2007/Tools | Options.../Preferences/E-mail Options

  :::image type="content" source="media/email-sent-are-not-saved-to-sent-items-folder/outlook-2007-policy-option.png" alt-text="Screenshot of policy option for Outlook 2007.":::

- Outlook 2010:

  Policy Path: User Configuration/Administrative Templates/Classic Administrative Templates (ADM)/Microsoft Outlook 2010/Outlook Options/Preferences/E-mail Options

  :::image type="content" source="media/email-sent-are-not-saved-to-sent-items-folder/outlook-2010-policy-option.png" alt-text="Screenshot of policy option for Outlook 2010.":::

- Outlook 2013:

  Policy Path: User Configuration/Administrative Templates/Microsoft Outlook 2013/Outlook Options/Preferences/E-mail Options

  :::image type="content" source="media/email-sent-are-not-saved-to-sent-items-folder/outlook-2013-policy-option.png" alt-text="Screenshot of policy option for Outlook 2013.":::

- Outlook 2016:

  Policy Path: User Configuration/Administrative Templates/Microsoft Outlook 2016/Outlook Options/Preferences/E-mail Options

  In the dialog box for the policy setting, select **Enabled** to enable the policy and select the **Save copies of messages in Save Items folder** option (The screenshot for this step is listed below).

  :::image type="content" source="media/email-sent-are-not-saved-to-sent-items-folder/message-handling.png" alt-text="Screenshot shows steps in the policy setting dialog box." border="false":::

  The Registry keys associated with the **Save copies of messages in Sent Items folder** option are as follows:

  `HKEY_CURRENT_USER\Software\Microsoft\Office\<x.0>\Outlook\Preferences`  
  `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\<x.0>\Outlook\Preferences`

  Where <x.0> is your version of Outlook:

  Outlook 2016, Outlook for Microsoft 365 and Outlook 2019 = 16.0  
  Outlook 2013 = 15.0  
  Outlook 2010 = 14.0  
  Outlook 2007 = 12.0

  DWORD Value Name: SaveSent  
  Value Data:

  0 = Disabled; Sent emails will not be saved in the Sent Items folder.  
  1 = Enabled; Sent emails will be saved in the Sent Items folder.
