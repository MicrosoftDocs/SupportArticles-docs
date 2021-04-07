---
title: Dynamics CRM for Outlook isn't enabled
description: Provides a solution to an issue where CRM isn't enabled in Outlook after installing Microsoft Dynamics CRM for Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Microsoft Dynamics CRM for Outlook isn't enabled in Outlook

This article provides a solution to an issue where CRM isn't enabled in Outlook after installing Microsoft Dynamics CRM for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2015, Microsoft Dynamics CRM 2016  
_Original KB number:_ &nbsp; 3164046

## Symptoms

After installing Microsoft Dynamics CRM for Outlook, CRM isn't enabled in Outlook. It may also occur after creating a new Outlook profile.

## Cause

Configuration of CRM for Outlook is a two-step process. After CRM for Outlook is installed, you need to run the Microsoft Dynamics CRM Configuration Wizard to connect to your CRM organization.

CRM for Outlook will bind to your default Outlook profile. If you created a new Outlook profile after configuring CRM for Outlook, you need to run the Microsoft Dynamics Configuration Wizard to use CRM for Outlook with your new profile.

## Resolution

Run the Microsoft Dynamics CRM Configuration Wizard:

1. Close Outlook.

2. Do one of the following steps:

    - In Windows 8 or Windows 10, choose **Start**, search for **Configuration Wizard**, and then press **Enter**.
    - In earlier versions of Windows, choose **Start**, point to **All Programs**, choose Microsoft Dynamics CRM 2015 or Microsoft Dynamics CRM 2016 Configuration Wizard.

3. In the **Microsoft Dynamics CRM for Outlook Configuration Wizard** dialog box, select the **Add** button.

    You'll see the following (or similar) dialog box:

    :::image type="content" source="media/dynamics-crm-outlook-is-not-enabled/add-dynamics-crm-organization.png" alt-text="Microsoft Dynamics CRM Configuration Wizard.":::

4. Do one of the following steps:

    - If you're using CRM Online, select **CRM Online** from the list.
    - If you're using CRM on-premises or later version, open a browser, sign in to your CRM organization's website, copy the URL address (copy the whole address) from the address bar, and then paste it in the **Add a Microsoft Dynamics CRM Organization** dialog box.

5. Select **Connect**.

6. If prompted, enter your credentials.

7. Select **OK**.

If you're unable to successfully connect to your CRM Online organization, use [Microsoft Support and Recovery Assistant](/outlook/troubleshoot/performance/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant).
