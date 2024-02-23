---
title: Troubleshoot View In File Explorer issues in SharePoint Online
description: Discusses how to troubleshoot issues that you may experience when you use the View In File Explorer command.
author: helenclu
manager: dcscontentpm
ms.date: 12/17/2023
localization_priority: High
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - SharePoint Online
ms.custom: 
  - CI 113862
  - CSSTroubleshoot
---

# Troubleshoot "View in File Explorer" issues in SharePoint Online

## Introduction

This article discusses how to troubleshoot issues that you may experience when you use the "View in File Explorer" command in SharePoint Online.

> [!NOTE]
> The View in File Explorer command doesn't work in Google Chrome, Mozilla Firefox, or on the Mac platform.

> [!IMPORTANT]
> The View in File Explorer option is coming to Microsoft Edge. For more information, see [View SharePoint files with File Explorer in Microsoft Edge](/sharepoint/sharepoint-view-in-edge).

The Open with Explorer command is slower and less reliable than [syncing SharePoint files with the new OneDrive sync client](https://support.office.com/article/6de9ede8-5b6e-4503-80b2-6190f3354a88). The OneDrive sync client provides [Files On-Demand](https://support.office.com/article/0e6860d3-d9f3-4971-b321-7092438fb38e), which allows you to access all your files in OneDrive without using local storage space.

For more information about how to copy or move library files by using "Open with Explorer," go to [Copy or move library files by using Open with Explorer](https://support.office.com/article/copy-or-move-library-files-by-using-open-with-explorer-aaee7bfb-e2a1-42ee-8fc0-bcc0754f04d2?ocmsassetID=HA101811182&CorrelationId=93c20e9a-ab98-496b-8c8a-32ed16406dec).

## Symptoms

When you browse to a SharePoint Online document library, you may receive intermittent connectivity issues, and you may receive one of the following error messages:

- > Your client does not support opening this list with Windows Explorer.

- > We're having a problem opening this location in File Explorer. Add this web site to your Trusted Sites list and try again.

- > We're having a problem opening this location in File Explorer. To open with File Explorer, you'll need to add this site to your Trusted Sites list and select the "Keep me signed in" check box when you sign in to the SharePoint Online site. For more information, see [https://support.microsoft.com/kb/2629108]().

- > We're having trouble opening this library in File Explorer. Syncing this library will give you a better experience.

   :::image type="content" source="media/troubleshoot-issues-using-open-with-explorer/error-have-trouble-open-library.png" alt-text="Screenshot of the error dialog, showing We're having trouble opening this library in File Explorer." border="false":::

## Resolution

Use the following troubleshooting procedures to resolve common issues that occur when you use the "Open with Explorer" command.

### Authenticate to Microsoft 365

Make sure that you're authenticated to Microsoft 365. To do this, use one of the following methods.

##### Method 1: Use "Keep me signed in"

Sign in to the SharePoint Online site by using your Microsoft 365 work or school account credentials. When you do this, make sure that you select the **Keep me signed in** check box.

   > [!NOTE]
   > If you didn't previously select this setting, you might find that you're already signed in when you browse to a SharePoint Online site or the Microsoft 365 portal. In this case, you must first sign out and then sign in again by having the **Keep me signed in* check box selected. To do this, follow these steps:
   > 1. On the Microsoft 365 ribbon, select the arrow next to your user name.
   > 1. Select **Sign out**.
   > 1. Close all browser windows.
   > 1. Browse to the Microsoft 365 portal.
   > 1. Select the **Keep me signed in** check box, enter your Microsoft 365 work or school account credentials, and then select **Sign in** (if it is necessary).
   > 1. Open a document library in Explorer view.

##### Method 2: Use a persistent cookie

You can use the **UsePersistentCookiesForExplorerView** parameter for the **Set-SPOTenant** cmdlet that's used in the SharePoint Online Management Shell. This lets SharePoint issue a special cookie that will allow the Authenticate to Microsoft 365 feature to work even if **Keep Me Signed In** isn't selected.

After this parameter is enabled, you are prompted by a dialog box when you select **Open with Explorer** in SharePoint Online, as shown in the following screenshot. After you select **This is a private computer**, the persistent cookie is stored. Therefore, you no longer have to select **Keep me signed in**.

> [!IMPORTANT]
> This method should be used only on a private computer.

> [!NOTE]
> If you receive an Internet Explorer Security message that says, "A website wants to open web content using this program on your computer," it's likely that SharePoint Online isn't added to the trusted sites zone in Internet Explorer. See the "Add your SharePoint Online sites to trusted sites" section of this article for more information about how to add SharePoint Online to your trusted sites.

For more information about the  **UsePersistentCookiesForExplorerView** parameter and the persistent cookie, go to [Set-SPOTenant](/powershell/module/sharepoint-online/Set-SPOTenant?preserve-view=true&view=sharepoint-ps).

For more information about the SharePoint Online Management Shell, go to [What is the SharePoint Online Management Shell?](/powershell/sharepoint/sharepoint-online/introduction-sharepoint-online-management-shell?preserve-view=true&view=sharepoint-ps)

### Add your SharePoint Online sites or Open with Explorer URL to trusted sites

Make sure that the SharePoint Online or Open with Explorer URL is added to your trusted sites zone in Internet Explorer. To do this, follow these steps:

1. Start Internet Explorer.
1. Depending on your version of Internet Explorer, do one of the following:

   - Select the **Tools** menu, and then select **Internet options**.
   - Select the gear icon, and then select **Internet options**.

    :::image type="content" source="media/troubleshoot-issues-using-open-with-explorer/internet-options.png" alt-text="Screenshot of Tools menu. Internet options is selected.":::  

1. Select the **Security** tab, select **Trusted sites**, and then select **Sites**.

    :::image type="content" source="media/troubleshoot-issues-using-open-with-explorer/trusted-sites.png" alt-text="Screenshot of Internet Options window. Under Security tab, showing Trusted sites.":::  

1. In the **Add this website to the zone** box, enter the URL for the website that you want to add to the **Trusted sites** zone, and then select **Add**. The URL will be for one of the following websites:

   - SharePoint Online
   - OneDrive for Business
   - Open with Explorer (uses a -files or -myfiles format)  

   For example, enter https://<*contoso*>.sharepoint.com and https://<*contoso*>-files.sharepoint.com for a site. Or, enter https://<*contoso*>-myfiles.sharepoint.com and https://<*contoso*>-my.sharepoint.com for a OneDrive for Business library.

   > [!NOTE]
   > In this example, *contoso* represents the domain that you use for your organization.

   Repeat this step for any additional sites that you want to add to this zone.

   To make sure that "Open with Explorer" works correctly, you must include the SharePoint site URL or the OneDrive for Business URL in addition to the "-files" (for a site) URL or the "-myfiles" (for a OneDrive for Business library) URL.

    :::image type="content" source="media/troubleshoot-issues-using-open-with-explorer/adding-site.png" alt-text="Screenshot of Trusted sites window. You can add and remove websites from this zone.":::
  
1. After you add each site to the **Websites** list, select **Close**, and then select **OK**.

### Check the status of the WebClient service

Make sure that the latest Windows updates are applied. If all the latest updates are applied but the issue persists, make sure that the WebClient service is running. To do this, follow these steps:

1. Follow the appropriate steps for your operating system:

   - For Windows XP, Windows Vista, or Windows 7, click **Start**, click **Run**, enter **services.msc**, and then press Enter.
   - For Windows 8, select **Start**, enter **services.msc**, and then press Enter.
   - For Windows Server 2008 or Windows Server 2012, select Start, enter services.msc, and then press Enter. If the WebClient service isn't present, you must first install the Desktop Experience. For more information about how to install the Desktop Experience, go to [Install Desktop Experience](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754314(v=ws.11)).

1. In the list of services, locate the **WebClient** service, and then make sure that its status in the **Status** column is set to **Started**. If the status isn't set to **Started**, double-click the WebClient service to open the **WebClientProperties** dialog box, select **Start**, and then select **OK**.

   > [!NOTE]
   > If the **Startup Type** for the **WebClient** service is set to **Disabled**, the **Open with Explorer** button doesn't function correctly, and you cannot start the service. To enable the service, go to the **WebClient Properties** dialog box, select the list option for the **Startup type** setting, and then select either **Manual** or **Automatic**. Next, select **Apply**, select **Start** to start the service, and then select **OK**.

### Apply hotfix for Internet Explorer 10 on Windows 8 or Windows 7

If you're running Internet Explorer 10 on Windows 8 or Windows 7, a hotfix has been released to resolve this issue. For more information, go to [Error when you open a SharePoint Document Library in Windows Explorer or map a network drive to the library after you install Internet Explorer 10](https://support.microsoft.com/help/2846960).

## More information

For more information about how to work with site library files in File Explorer, see [Ways to work with site library files in File Explorer](https://support.office.com/article/ways-to-work-with-site-library-files-in-file-explorer-751148de-f579-42f9-bc8c-fcd80ccf0f53).

For more information about how to work with the WebClient service, see the following Knowledge Base articles:

- [2548470 A WebClient service crashes on a computer that is running Windows 7 or Windows Server 2008 R2 when you connect a WebDav resource](https://support.microsoft.com/help/2548470)
- [943280 Prompt for Credentials When Accessing FQDN Sites From a Windows Vista or Windows 7 Computer](https://support.microsoft.com/help/943280)
- [View SharePoint files with File Explorer in Microsoft Edge](/sharepoint/sharepoint-view-in-edge)

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
