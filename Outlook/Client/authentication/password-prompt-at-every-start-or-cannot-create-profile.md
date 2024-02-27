---
title: Password prompt at every start or cannot create profile
description: Describes an issue that causes you to be prompted for your password every time that Outlook 2016 or Outlook 2013 starts. Provides a resolution. Or, you are unable to create a profile.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: vivekst, tasitae
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Password prompt at every Outlook start or can't create profile

_Original KB number:_ &nbsp; 3060280

## Symptoms

When you connect to a Microsoft Exchange 2016, Exchange 2013, or Microsoft 365 mailbox in Microsoft Outlook 2019, Outlook 2016, Outlook, 2013 or Outlook for Microsoft 365, you experience one of the following symptoms:

- You are prompted for your password every time that Outlook starts, even if you enabled the **Remember my credentials** option.
- When you start Outlook, it is unable to connect, and it displays **Need Password** in the status bar. When you select **Need Password**, you receive the following message:  
  **This feature has been disabled by your administrator.**

- When you try to create a new Outlook profile, you receive one of the following error messages:  
  - **We're sorry, we couldn't set up your account automatically, to set it up yourself, click Next.**  
  - **Something went wrong**
  - **Something went wrong and Outlook couldn't set up your account. Please try again. If the problem continues, contact your email administrator.**

## Cause

This issue occurs if the **Allow Office to connect to the Internet** check box under **Trust Center Privacy Options** is not selected.

## Resolution

To resolve this issue, enable the option to allow Office to connect to online services by following these steps for your version of Outlook.

Outlook 2016, Outlook 2019, and Outlook for Microsoft 365:

1. On the **File** tab, select **Options**.
2. Select **Trust Center**, and then select **Trust Center Settings**.
3. Select **Privacy Options**, and then select the **Let Office connect to online services from Microsoft to provide functionality that's relevant to your usage and preferences** check box.
4. Select **OK** two times to close the **Outlook Options** dialog box.

   > [!NOTE]
   > If the **Let Office connect to online services from Microsoft to provide functionality that's relevant to your usage and preferences** check box is unavailable, see the More Information section below, for additional details about this setting.

Outlook 2013:

1. On the **File** tab, select **Options**.
2. Select **Trust Center**, and then select **Trust Center Settings**.
3. Select **Privacy Options**, and then select the **Allow Office to connect to the Internet** check box.
4. Select **OK** two times to close the **Outlook Options** dialog box.

    > [!NOTE]
    > If the Allow Office to connect to the Internet  check box is unavailable, see the More Information section below, for additional details about this setting.

## More information

If the **Allow Office to connect to the Internet** check box is unavailable, it is because the `UseOnlineContent` setting in the registry is set to the value **0**. The `UseOnlineContent` setting is located in one of the following registry keys:

`HKEY_CURRENT_USER\Software\Microsoft\Office\x.0\Common\Internet`

`HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\x.0\Common\Internet`

DWORD: UseOnlineContent  
Value:

0  - Do not allow user to access Office resources on the Internet (check box is cleared and unavailable).  
1  - Allows the user to opt in to access of Office resources on the Internet (check box is cleared).  
2  - (Default) Allows the user to access Office resources on the Internet (check box is selected).

> [!NOTE]
>
> - The <x.0> placeholder represents your version of Office (16.0 = Office 2016, Office 2019, or Outlook for Microsoft 365, 15.0 = Office 2013).
> - If the `UseOnlineContent` value is located under the Policies hive, that value may have been created through Group Policy. Your administrator will have to change the policy to change this setting.

The **Online Content Options** policy setting is located under the Microsoft Office 2019, Office 2016, Office 2013, or Outlook for Microsoft 365 administrative template. Find these templates under **Tools | Options | General | Service Options, Online Content**.

:::image type="content" source="media/password-prompt-at-every-start-or-cannot-create-profile/online-content-options-policy-setting.png" alt-text="Screenshot of Online Content Options policy setting." border="false":::

You can set this to **Not Configured** or **Enabled** and then select the **Allow Office to connect to the Internet** online content option.

:::image type="content" source="media/password-prompt-at-every-start-or-cannot-create-profile/onlion-content-options-setting-details.png" alt-text="Screenshot of Online Content Options policy setting details, setting to Not Configured or Enabled and selecting the Allow Office to connect to the Internet option." border="false":::

When you enable the Allow Office to connect to the Internet setting, this affects other features in Office. These include the following:

- Insertion of Online Pictures is enabled.
- Insertion of Online Video is enabled.
- Search for online templates is enabled.
- Certain document review and proofing resources may become available.
