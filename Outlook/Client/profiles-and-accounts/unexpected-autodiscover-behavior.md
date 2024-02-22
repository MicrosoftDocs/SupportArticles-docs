---
title: Unexpected Autodiscover behavior if settings under the \Autodiscover key
description: Explains how to use policy to control the different Autodiscover lookup methods that are used by Outlook.
author: cloud-writer
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook 2010
  - Office Outlook 2007
ms.date: 10/30/2023
---

# Unexpected Autodiscover behavior when you have registry settings under the \Autodiscover key

## Symptoms

When Microsoft Outlook tries to retrieve Autodiscover information from a server that's running Microsoft Exchange Server, you may experience unexpected results if you're using one or more of the available registry values that can be used to control Autodiscover.

## Cause

When Outlook tries to contact the Autodiscover service on the Exchange server with the Client Access Server (CAS) role, it can use several different methods to reach the service, depending on the client-server topology. The currently implemented methods used by Outlook are:

- SCP lookup
- HTTPS root domain query
- HTTPS Autodiscover domain query
- Local XML file
- HTTP redirect method
- SRV record query
- Cached URL in the Outlook profile (new for Outlook 2010 version 14.0.7140.5001 and later versions)
- Direct Connect to Microsoft 365 (new for Outlook 2016 version 16.0.6741.2017 and later versions)

By default, Outlook will try one or more of these methods if it can't reach Autodiscover. For example, in a scenario with a machine not joined to a domain, Outlook will try to connect to the predefined URLs (such as `https://autodiscover.contoso.com/autodiscover/autodiscover.xml`) by using DNS. If it fails, Outlook will try the HTTP redirect method. If it fails too, Outlook will try to use the SRV record lookup method. If all lookup methods fail, Outlook can't obtain Outlook Anywhere configuration and URL settings.

For more information about the different Autodiscover connection methods used by Outlook, see the following Exchange Autodiscover Service documents:

- [Exchange 2013 Autodiscover service](/exchange/autodiscover-service-for-exchange-2013)
- [White Paper: Understanding the Exchange 2010 Autodiscover Service](/previous-versions/office/exchange-server-2010-technical-article/jj591328(v=exchg.141))
- [White Paper: Exchange 2007 Autodiscover Service](/previous-versions/office/exchange-server-2007-technical-articles/bb332063(v=exchg.80))

In some scenarios, you may want to use Autodiscover-related registry/policy values to control the method(s) used by Outlook to reach Autodiscover. However, if you configure the Autodiscover registry/policy values incorrectly, you may prevent Outlook from obtaining Autodiscover information.

## Resolution

To resolve this problem, review the Autodiscover-related registry data you may have on your Outlook client, and ensure the data is configured correctly. Also, if you are unsure if the registry data is needed, consider changing the data for any of these registry values to zero (0), and then test Outlook to see if you experience a difference in Autodiscover.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, go to the following article in the Microsoft Knowledge Base: [322756 How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756)

1. Start Registry Editor.
2. Locate and then select the following registry subkey:

   `HKEY_CURRENT_USER\Software\Microsoft\Office\x.0\Outlook\AutoDiscover`

   > [!NOTE]
   > x.0 in this registry path corresponds to the Outlook version (16.0 = Outlook 2016, 15.0 = Outlook 2013, 14.0 = Outlook 2010, 12.0 = Outlook 2007).

3. Review the following possible DWORD values that may be located under the \Autodiscover subkey.

   - PreferLocalXML
   - PreferProvidedEmailInAutoDiscoverAuthPrompts

     This value enables Exchange administrators to specify whether users will be authenticated by using the configured account email or the user principal name (UPN) during AutoDiscover scenarios. For more information, see [November 5, 2019, update for Outlook 2016 (KB4484139)](https://support.microsoft.com/topic/november-5-2019-update-for-outlook-2016-kb4484139-9f986a96-8075-7ded-ccf4-d4ba69e8efeb).
   - ExcludeHttpRedirect
   - ExcludeHttpsAutoDiscoverDomain
   - ExcludeHttpsRootDomain
   - ExcludeScpLookup
   - ExcludeSrvRecord
   - ExcludeLastKnownGoodURL (only applies to Outlook 2010 version 14.0.7140.5001 and later versions)
   - ExcludeExplicitO365Endpoint (only applies to Outlook 2016 version 16.0.6741.2017 and later versions)

   > [!NOTE]
   > Some documentation states that the ExcludeSrvLookupvalue is used by Outlook in this scenario. Unfortunately, this documentation is incorrect, the ExcludeSrvLookup value doesn't exist in Outlook code. Only the ExcludeSrvRecordregistry value is used by Outlook to control the SRV recordlookup for Autodiscover. Therefore, if you find a value called ExcludeSrvLookup under the \Autodiscover subkey, you can safely change its value to 0.

4. Repeat step 3 by using the following registry subkey:

   `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\x.0\Outlook\AutoDiscover`

   > [!NOTE]
   > x.0 in this registry path corresponds to the Outlook version (16.0 = Outlook 2016, 15.0 = Outlook 2013, 14.0 = Outlook 2010, 12.0 = Outlook 2007).

## More information

You can use the following steps in Outlook to determine the method by which Outlook is trying to retrieve Autodiscover information from Exchange:

1. Start Outlook.
2. Press the CTRL key, right-click the Outlook icon in the notification area, and then click Test E-mail AutoConfiguration.
3. Verify the e-mail address is correctly entered in the E-mail Address box.
4. Enter your password if you are not logged into a domain or if you are accessing a mailbox that is different from your mailbox.
5. Click to clear the Use Guessmart and the Secure Guessmart Authentication check boxes.
6. Click Test.
7. Review the details on the **Log** tab.

The following figure shows the **Log** tab when the ExcludeScpLookup and ExcludeHttpsAutoDiscoverDomain values have been set to 1.

:::image type="content" source="media/unexpected-autodiscover-behavior/log-tab-excludescplookup-excludehttpsautodiscoverdomain-1.png" alt-text="Screenshot shows information under the Log tab when ExcludeScpLookup and ExcludeHttpsAutoDiscoverDomain values are set to 1.":::

Compare this information when only the ExcludeScpLookup value is set to 1.

:::image type="content" source="media/unexpected-autodiscover-behavior/log-tab-excludescplookup-1.png" alt-text="Screenshot shows information under the Log tab when ExcludeScpLookup value is set to 1.":::

> [!NOTE]
> Ignore the failures in these figures because this information is intended only to show you the different lookup attempts that are made by Outlook.

Also, if you enable logging in Outlook (2007 or 2010), the different Autodiscover lookup attempts can be found in the *%temp%\Olkdisc.log* file. This log file also includes any registry settings you have configured to exclude any of the Autodiscover lookup methods. In the following figure, you can clearly see that the ExcludeScpLookup and ExcludeHttpsAutoDiscoverDomain values are both set to 1.

:::image type="content" source="media/unexpected-autodiscover-behavior/log-file.png" alt-text="Screenshot shows the log file in which ExcludeScpLookup and ExcludeHttpsAutoDiscoverDomain are both on.":::

For more information about the client-side management and administration of Autodiscover, go to the following Knowledge Base article:

[2612922 How to control Outlook AutoDiscover by using Group Policy](https://support.microsoft.com/help/2612922)
