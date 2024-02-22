---
title: How to control AutoDiscover via Group Policy
description: The Group Policy .adm templates for Outlook 2007 and Outlook 2010 do not include a setting to disable the Outlook AutoDiscover feature or its discovery methods. Article details how to configure the AutoDiscover feature by using custom Group Policy template files.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook 2010
  - Outlook 2007
search.appverid: MET150
ms.date: 10/30/2023
---
# How to control Outlook AutoDiscover by using Group Policy

_Original KB number:_ &nbsp; 2612922

## Summary

When you view the Outlook policy settings in the Group Policy Object Editor, you only see the following policy setting that's related to AutoDiscover:

Automatically configure profile based on Active Directory Primary SMTP address

However, this policy setting only controls whether the startup wizard dialog box appears when Microsoft Exchange mailbox information is available to your domain-joined workstation.

In some scenarios, you may want to control the methods that are used by Outlook to find the AutoDiscover service. This depends on the client/server topology, but these are the methods that are used by Outlook:

SCP lookup  
HTTPS root domain query  
HTTPS AutoDiscover domain query  
HTTP redirect method  
SRV record query

By default, Outlook uses one or more of these methods to reach the AutoDiscover service. For example, for a computer that isn't joined to a domain, Outlook tries to connect to the predefined URLs (for example, `https://autodiscover.contoso.com/autodiscover/autodiscover.xml`) by using DNS. If that fails, Outlook tries the HTTP redirect method. If that does not work, Outlook tries to use the SRV record lookup method. If all lookup methods fail, Outlook cannot obtain "Outlook Anywhere" configuration and URL settings.

This article discusses how you can enable or disable the AutoDiscover feature and how you can specify which methods for Outlook to use to try to reach the AutoDiscover service.

## More information

To deploy the custom Group Policy template to control the behavior of the Outlook AutoDiscover feature, follow these steps:

1. Download and extract the custom Group Policy template for your version of Outlook from the Microsoft Download Center:

   - Outlook 2016, Outlook 2019, and Outlook for Microsoft 365: [https://www.microsoft.com/download/details.aspx?id=49030](https://www.microsoft.com/download/details.aspx?id=49030)
   - Outlook 2013: [https://www.microsoft.com/download/details.aspx?id=35554](https://www.microsoft.com/download/details.aspx?id=35554)
   - Outlook 2010: [https://download.microsoft.com/download/C/5/2/C5252326-202E-4674-A5A2-BC9F5C8F53BE/outlk14-autodiscover.adm](https://download.microsoft.com/download/c/5/2/c5252326-202e-4674-a5a2-bc9f5c8f53be/outlk14-autodiscover.adm)
   - Outlook 2007: [https://download.microsoft.com/download/C/5/2/C5252326-202E-4674-A5A2-BC9F5C8F53BE/outlk12-autodiscover.adm](https://download.microsoft.com/download/c/5/2/c5252326-202e-4674-a5a2-bc9f5c8f53be/outlk12-autodiscover.adm)
2. Copy the .adm or .admx file that you downloaded in step 1 to your domain controller:

    > [!NOTE]
    > The steps to add the .adm or .admx file to a domain controller vary, depending on the version of Windows that you're running. Also, because you may be applying the policy to an organizational unit (OU) and not to the whole domain, the steps may vary in this aspect of applying a policy. Therefore, check your Windows documentation for more information.
3. Under **User Configuration**, expand Classic Administrative Templates (ADM) or XML‑based administrative template (ADMX) to locate the policy node for your template.
4. To configure the AutoDiscover feature, find the **Exchange** node. In the Exchange node, select the **AutoDiscover** node. Double-click the **AutoDiscover** policy setting in the details pane.
5. In the dialog box for the policy setting, select **Enabled** to enable the policy.

    > [!NOTE]
    > When you enable the policy setting, the five **Exclude** check boxes under this item are selected. To disable the AutoDiscover feature, make sure that all the check boxes are selected. Or, you can use the five check boxes to specify which discovery methods Outlook AutoDiscover uses to try to reach the AutoDiscover service.

6. After you finish configuring the AutoDiscover policy and the information has propagated to your Outlook clients, you can verify that the policies are available to Outlook by examining the following subkey in the registry:

    `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\<x.0>\Outlook\AutoDiscover`

    > [!NOTE]
    > The \<x.0> placeholder represents your version of Outlook (12.0 = Outlook 2007, 14.0 = Outlook 2010, 15.0 = Outlook 2013, and 16.0 = Outlook 2016, Outlook 2019 and Outlook for Microsoft 365).

## Methods used to try to reach the AutoDiscover service

### SCP object lookup

Outlook performs an Active Directory query for Service Connection Point (SCP) objects.

### Root domain query based on your primary SMTP address  

Outlook uses the root domain of your primary SMTP address to try to locate the AutoDiscover service. Outlook tries to connect to the following URL based on your SMTP address:

`https://<smtp-address-domain>/autodiscover/autodiscover.xml`

### Query for the AutoDiscover domain  

Outlook uses the AutoDiscover domain to try to locate the AutoDiscover service. Outlook tries to connect to the following URL based on your SMTP address:

`https://autodiscover.<smtp-address-domain>/autodiscover/autodiscover.xml`

### HTTP redirect  

Outlook uses HTTP redirection if Outlook cannot reach the AutoDiscover service through either of the secure HTTPS URLS:

`https://<smtp-address-domain>/autodiscover/autodiscover.xml`

`https://autodiscover.<smtp-address-domain>/autodiscover/autodiscover.xml`

### SRV record query in DNS  

Outlook uses an SRV record lookup in DNS to try to locate the AutoDiscover service.
