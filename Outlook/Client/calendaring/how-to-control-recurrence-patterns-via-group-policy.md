---
title: Control recurrence patterns via Group Policy
description: Describes how to control Microsoft Outlook recurrence patterns by using Group Policy.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tmoore, tasitae
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Microsoft Office Outlook 2003
search.appverid: MET150
ms.date: 01/30/2024
---
# How to control Outlook recurrence patterns using Group Policy

_Original KB number:_ &nbsp; 2548319

## Summary

By default, recurring appointments, meetings, and tasks created by Microsoft Outlook have the **No end date** option enabled and have the default number of occurrences to end after set to **10**. An example of these settings in a new meeting is shown in the following figure.

:::image type="content" source="media/how-to-control-recurrence-patterns-via-group-policy/recurring-appointment-settings.png" alt-text="Screenshot of Appointments Recurrence settings window.":::

This article describes how to use Group Policy templates for Outlook 2003 and later versions so that you can make the following changes to recurring items:

- Disable the **No end date** option for appointments, meetings, and tasks.
- Configure the default number of days for the recurrence period of appointments and meetings.

## More information

To configure recurrence settings in Outlook by using custom Group Policy templates, follow these steps:

1. Download and extract the custom Group Policy template for your version of Outlook from the Microsoft Download Center:

    > [!IMPORTANT]
    > This step is not required for Outlook 2013 and later versions, as the recurrence administration settings are included in the main template.

    - [Outlook 2010 custom recurrence administration template](https://download.microsoft.com/download/a/b/f/abf1d876-985b-4e0d-89c8-241fd5d12934/olk14-recurrenceadministration.adm)
    - [Outlook 2007 custom recurrence administration template](https://download.microsoft.com/download/a/b/f/abf1d876-985b-4e0d-89c8-241fd5d12934/olk12-recurrenceadministration.adm)
    - [Outlook 2003 custom recurrence administration template](https://download.microsoft.com/download/a/b/f/abf1d876-985b-4e0d-89c8-241fd5d12934/olk11-recurrenceadministration.adm)

2. If you do not already have the main Group Policy template for your version of Outlook, download and extract the latest template from the Microsoft Download Center:

    - Office 2016: [Office 2016 Administrative Template files (ADMX/ADML) and Office Customization Tool](https://www.microsoft.com/download/details.aspx?id=49030)
    - Office 2013: [Office 2013 Administrative Template files (ADMX/ADML) and Office Customization Tool](https://www.microsoft.com/download/details.aspx?id=35554)
    - Office 2010: [Office 2010 Administrative Template files (ADM, ADMX/ADML) and Office Customization Tool download](https://www.microsoft.com/download/details.aspx?id=18968)

3. If it is necessary, add the template file that you downloaded in step 2 to your domain controller.

    Outlook 2016 and Outlook 2019 = Outlk16.admx, Outlk16.adml  
    Outlook 2013 = Outlk15.admx, Outlk15.adml  
    Outlook 2010 = Outlk14.adm  
    Outlook 2007 = Outlk12.adm  
    Outlook 2003 = Outlk11.adm

    > [!NOTE]
    > The steps to add the template file to a domain controller vary, depending on the version of Windows that you are running. Also, because you may be applying the policy to an organizational unit (OU) and not to the whole domain, the steps may vary in this aspect of applying a policy. Therefore, check your Windows documentation for more information.

4. Add the custom Group Policy template that you downloaded in step 1 to your domain controller.

    > [!IMPORTANT]
    > This step is not required for Outlook 2013 and later versions, as the recurrence administration settings are included in the main template.

    Outlook 2010 = OLK14-RecurrenceAdministration.adm  
    Outlook 2007 = OLK12-RecurrenceAdministration.adm  
    Outlook 2003 = OLK11-RecurrenceAdministration.adm

    > [!NOTE]
    > The steps to add the .adm file to a domain controller vary, depending on the version of Windows that you are running. Also, because you may be applying the policy to an organizational unit (OU) and not to the whole domain, the steps may vary in this aspect of applying a policy. Therefore, check your Windows documentation for more information.

5. Locate the policy node, depending on your Outlook version.

    For Outlook 2013 and later versions:

    Under **User Configuration**, expand **Administrative Templates**, expand your version of **Microsoft Outlook**, expand **Outlook Options**, expand **Preferences**, expand **Calendar Options**, and then select **Recurring item configuration**.

    For Outlook 2010:

    Under **User Configuration**, expand **Classic Administration Templates (ADM)**, expand **Microsoft Outlook 2010**, expand **Outlook Options**, expand **Preferences**, expand **Calendar Options**, and then select **Recurring item configuration**.

    For Outlook 2007 and earlier versions:

    Under **User Configuration**, expand **Classic Administration Templates (ADM)**, expand your version of **Microsoft Outlook**, expand **Tools | Options**, expand **Preferences**, expand **Calendar Options**, and then select **Recurring item configuration**.

6. Double-click the **Disable the "No end date" option for recurring items** policy to configure this policy.
7. In the dialog box for the policy, select **Enabled** to enable the policy.

   :::image type="content" source="media/how-to-control-recurrence-patterns-via-group-policy/enable-the-policy.png" alt-text="Screenshot of Disable the No end date option for recurring items dialog box.":::

    > [!IMPORTANT]
    > This will disable the **No end date** option for new recurring items.

8. Select **OK**.
9. Double-click the **Specify total number of days in a recurring meeting or appointment** policy to configure this policy.

   Using this policy, you can specify the default number of days after which a recurring meeting or appointment (not task) will end. When this policy is enabled, the End by setting in the recurrence pattern is used as the default configuration for a recurring meeting. Therefore, depending on your recurrence pattern (daily, weekly, monthly), the number of meetings that occur during this period can vary. For example, if you specify a value of 180 and today's date is May 5, 2011, the End by value will show Tue 11/1/2011 (180 days after today). If you select Weekly for the recurrence pattern, you will get 26 meetings during this timeframe. However, if you specify Monthly for the recurrence pattern, you will only get six meetings during this timeframe.

10. In the dialog box for the policy, select **Enabled** to enable the policy. Then, specify the number of days after which the recurrence period ends and then select **OK**.

    :::image type="content" source="media/how-to-control-recurrence-patterns-via-group-policy/specify-the-days.png" alt-text="Screenshot of the Specify total number of days in a recurring meeting or appointment dialog box.":::

The following registry data is associated with the policies discussed in this article:

- Disable the **No end date** option for recurring items

  Key: HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\x.0\Outlook\Preferences  
  DWORD: DisableRecurNoEnd  
  Value: 1 = policy enabled, 0 = policy not enabled

- Specify total number of days in a recurring meeting or appointment

  Key: HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\x.0\Outlook\Options\Calendar  
  DWORD: RecurrencesDefault  
  Value: integer value between 2 and 720

> [!NOTE]
> The *x.0* placeholder represents your version of Office.
>
> Outlook 2016 and Outlook 2019: *x.0* = 16.0  
> Outlook 2013: *x.0* = 15.0  
> Outlook 2010: *x.0* = 14.0  
> Outlook 2007: *x.0* = 12.0  
> Outlook 2003: *x.0* = 11.0  

For more information, see [You cannot disable the "No end date" option for appointments, meeting requests, tasks, or task requests in Outlook 2007](https://support.microsoft.com/help/955449/you-cannot-disable-the-no-end-date-option-for-appointments-meeting-req).
