---
title: Unable to connect to your Microsoft Dynamics 365 server error when using Microsoft Dynamics 365 App for Outlook
description: When you try to use Microsoft Dynamics 365 App for Outlook, you receive a We're unable to connect to your Microsoft Dynamics 365 server error. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.custom: sap:Dynamics 365 App for Outlook Add-In
---
# We're unable to connect to your Microsoft Dynamics 365 server error when using Microsoft Dynamics 365 App for Outlook

This article provides a resolution for the issue that you can't use Microsoft Dynamics 365 App for Outlook due to the **We're unable to connect to your Microsoft Dynamics 365 server** error.

_Applies to:_ &nbsp; Dynamics 365 App for Outlook  
_Original KB number:_ &nbsp; 4341413

## Symptoms

When attempting to use the Microsoft Dynamics 365 App for Outlook, you receive the following message:

> "We're unable to connect to your Microsoft Dynamics 365 server. Please try closing and reopening the app."

If you select **Show more**, you may see the following message:

> "Client loader timeout"

If you use the app in Outlook Web Access (OWA), you may see the following prompt appear at the bottom of the screen:

> "Do you want to allow `dynamics.com` to use additional storage on your computer?"

If you clear the Internet Explorer browser cache, this error may appear to be resolved but eventually returns.

## Cause

Microsoft is aware of an issue where this error can occur because Internet Explorer is configured to limit the amount of data that can be cached. If you are viewing the app using Internet Explorer, this may be the cause of the error. If you encounter this error using Outlook Desktop, Outlook is always using Internet Explorer to display the app.

## Resolution

Microsoft is working on a change to avoid this issue. In the meantime, you can use the steps below as a potential workaround:

### Option 1 - Increase database limit within Internet Explorer options

Depending on the version of your operating system, you may be able to change the limit within the settings of Internet Explorer. If you are using Windows 10, this option does not appear and you can use Option 2 instead.

1. Open Internet Explorer.
2. In the upper-right corner, select the gear icon and then select **Internet options**.
3. On the **General** tab within the **Browsing history** section, select **Settings**.
4. Select the **Caches and databases** tab.
5. If you see a **Notify me when a website cache or database exceeds** option, change the value to **200** and select **OK**. Alternatively, you can select `dynamics.com` from the list of websites and then select **Exceed limit**. If these options do not appear, continue to Option 2.
6. Clear the Internet Explorer history and cache. For detailed steps, see [View and delete your browsing history in Internet Explorer](https://support.microsoft.com/topic/view-and-delete-your-browsing-history-in-internet-explorer-098ffe52-5ac9-a449-c296-c735c32c8678).

### Option 2 - Increase the database limit within the registry

> [!IMPORTANT]
> This section contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To increase the allowed caching limit, create the following registry entry:

Subkey: `HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Internet Explorer\BrowserStorage\IndexedDBValue`  
Name: MaxTrustedDomainLimitInMB  
Type: REG_DWORD  
Data: **200**

To create this registry entry, follow these steps:

1. Select **Start**, select **Run**, type *regedit*, and then select **OK**.
2. Locate and then select the following registry subkey. If the path to this location does not exist, you may need to create the mentioned keys:

   `HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Internet Explorer\BrowserStorage\IndexedDBValue`

3. Right-click **IndexedDBValue**, point to **New**, and then select **DWORD Value**.
4. In the **New Value #1** box, type *MaxTrustedDomainLimitInMB*, and then press Enter.
5. Right-click **MaxTrustedDomainLimitInMB**, and then select **Modify**.
6. Select **Decimal**, type *200* and then select **OK**.
7. Quit Registry Editor, and then restart the computer.
8. Clear the Internet Explorer history and cache. For detailed steps, see [View and delete your browsing history in Internet Explorer](https://support.microsoft.com/topic/view-and-delete-your-browsing-history-in-internet-explorer-098ffe52-5ac9-a449-c296-c735c32c8678).

## More information

There are multiple potential causes for this error. If this does not resolve the issue, refer to the following article for additional potential solutions:

[Error "We’re unable to connect to your Microsoft Dynamics 365 server" when using Dynamics 365 App for Outlook](https://support.microsoft.com/help/3124910)
