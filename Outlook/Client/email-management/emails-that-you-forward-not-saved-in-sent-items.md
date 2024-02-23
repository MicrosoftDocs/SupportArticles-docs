---
title: Forwarded emails not saved in Sent Items
description: Provides a resolution for the issue that the emails that you forward are not saved in the Sent Items folder in Microsoft Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook LTSC 2021
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 10/30/2023
---
# Emails that you forward are not saved in the Sent Items folder in Outlook

_Original KB number:_ &nbsp; 3202402

## Symptoms

In Microsoft Outlook, you forward an email message, and find that the message is not saved in your **Sent Items** folder.

## Cause

The **Save forwarded messages** option is disabled either in the Outlook options or by a Group Policy.

## Resolution

To fix this issue, enable the **Save forwarded messages** option by following these steps, depending on where the setting is configured.

### Method 1 - Enable the Save forwarded messages option in the Outlook options

1. In Outlook, select **File**, and then select **Options**.
2. Select **Mail**.
3. Under the **Save messages** section, enable the **Save forwarded messages** option.
4. Select **OK**.

> [!NOTE]
> If the **Save forwarded messages** option is not available or appears dimmed, the setting may be configured in Group Policy. Your Administrator must change the policy by using the steps in method 2.

### Method 2 - Use Group Policy to enable the Save forwarded messages option

#### Outlook 2013 or later versions

The default Group Policy template files for Outlook contain the policy setting that controls this functionality. These are Outlk16.admx and Outlk16.adml for Outlook 2016, Outlook 2019, Outlook LTSC 2021, or Outlook for Microsoft 365 and Outlk15.admx and Outlk15.adml for Outlook 2013.

To deploy this setting by using the Outlook Group Policy template, follow these steps:

1. Download the following file from the Microsoft Download Center:

    Office 2016, Office 2019, Office LTSC 2021, or Outlook for Microsoft 365: [Administrative Template files (ADMX/ADML) and Office Customization Tool for Microsoft 365 Apps for enterprise, Office 2019, and Office 2016](https://www.microsoft.com/download/details.aspx?id=49030)  
    Office 2013: [Office 2013 Administrative Template files (ADMX/ADML) and Office Customization Tool](https://www.microsoft.com/download/details.aspx?id=35554)

2. Extract the admintemplates_32bit.exe or admintemplates_64bit.exe file to a folder on your disk.

3. Copy the file appropriate to your version of Outlook to the C:\Windows\PolicyDefinitions folder. Office 2016, Office 2019, Office LTSC 2021, or Outlook for Microsoft 365: Outlk16.admx Office 2013: Outlk15.admx

4. Copy the file appropriate to your version of Outlook to the C:\Windows\PolicyDefinitions\xx-xx Office 2016, Office 2019, Office LTSC 2021, or Outlook for Microsoft 365: Outlk16.adml Office 2013: Outlk15.admlwhere xx-xx is a Language Culture Name. For example, for English (US), the Language Culture Name is en-us. For more information about Language Culture Names, see [Table of Language Culture Names, Codes, and ISO Values [C++]](/previous-versions/commerce-server/ee797784(v=cs.20)).

    > [!NOTE]
    > The .adml file must be copied from the correct language folder.

5. Start the Group Policy Management Console.

    > [!NOTE]
    > Because you may be applying the policy setting to an organizational unit and not to the whole domain, the steps may also vary in this aspect of applying a policy setting. Therefore, check your Windows documentation for more information.

6. In the Group Policy Management Console, under **User Configuration**, expand **Administrative Templates**, expand your version of **Microsoft Outlook**, expand **Outlook Options**, expand **Preferences**, expand **E-mail Options**, and then select the **Advanced E-mail Options** node.

7. Under **Advanced E-mail Options**, double-click **More save messages**.
8. Select **Enabled**, and then enable **Save forwarded messages**.

    > [!NOTE]
    > You may also set the **More save messages** setting to **Not configured** to allow for Outlook users to configure the settings that they prefer.

9. Select **OK**.

   At this point, the policy setting is applied on your Outlook client workstations when the Group Policy setting update is replicated. To test this change, at the command prompt type the following command, and then press Enter:

    ```console
    gpupdate /force
    ```

#### Outlook 2010

The default Group Policy template files for Outlook 2010 contain the policy setting that controls this functionality. To deploy this setting by using the Outlook Group Policy template, follow these steps:

1. Download the following file from the Microsoft Download Center:

    [Office 2010 Administrative Template files (ADM, ADMX/ADML) and Office Customization Tool download](https://www.microsoft.com/download/details.aspx?id=18968)

2. Add the Outlk14.adm file to the Group Policy Management Console.

    > [!NOTE]
    > The steps to add the .adm file to the Group Policy Management Console vary, depending on the version of Windows that you're running. Also, because you may be applying the policy setting to an organizational unit and not to the whole domain, the steps may also vary in this aspect of applying a policy setting. Therefore, check your Windows documentation for more information.

    Go to step 3 after you add the .adm template to the Group Policy Management Console.

3. In the Group Policy Management Console, under **User Configuration**, expand **Classic Administrative Templates (ADM)**, expand **Microsoft Outlook 2010**, expand **Outlook Options**, expand **Preferences**, expand **E-mail Options**, and then select the **Advanced E-mail Options** node.

4. Under **Advanced E-mail Options**, double-click **More save messages**.
5. Select **Enabled**, and then enabled the **Save forwarded messages** option.

    > [!NOTE]
    > You may also set the **More save messages** setting to **Not configured** to allow for Outlook users to configure the settings that they prefer.

6. Select **OK**.

    At this point, the policy setting is applied on your Outlook 2010 client workstations when the Group Policy setting update is replicated. To test this change, at the command prompt type the following command, and then press Enter:

    ```console
    gpupdate /force
    ```

## More information

The following registry data is associated with the **Save forwarded messages** option in Outlook:

`HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Office\x.0\Outlook\Preferences`

or

`HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\x.0\Outlook\Preferences`

DWORD: SaveFW

Value data:  
0 = disabled  
1 = enabled

> [!NOTE]
> The *x.0* placeholder represents your version of Office (16.0 = Office 2016, Office 2019, Office LTSC 2021, or Outlook for Microsoft 365, 15.0 = Office 2013, 14.0 = Office 2010)
