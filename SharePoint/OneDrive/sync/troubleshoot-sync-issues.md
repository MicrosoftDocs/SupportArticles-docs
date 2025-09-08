---
title: Troubleshoot OneDrive for work or school sync issues
description: Helps you resolve issues that you can't sync OneDrive for work or school.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - OneDrive for work or school
search.appverid: MET150
ms.date: 01/03/2025
---
# Troubleshooting OneDrive for work or school sync issues

## Summary

This article is for anyone who can't sync OneDrive for work or school. You can find detailed troubleshooting steps towards resolving the sync issues. The estimated time of completion is 5-10 minutes.

> [!NOTE]
> To determine which OneDrive sync client you're using, see [Which OneDrive sync client am I using?](https://support.office.com/article/Which-OneDrive-sync-client-am-I-using-19246eae-8a51-490a-8d97-a645c151f2ba)  
> If you're using OneDrive not OneDrive for work or school, and you encountered sync issue, you can look for the solutions in [Fix OneDrive sync problems](https://support.microsoft.com/office/0899b115-05f7-45ec-95b2-e4cc8c4670b2).

## Update OneDrive for work or school to the current release

If you come from the article [Fix OneDrive sync problems](https://support.microsoft.com/office/fix-onedrive-sync-problems-0899b115-05f7-45ec-95b2-e4cc8c4670b2), see [Is the library configured to be available offline?](#is-the-library-configured-to-be-available-offline) to begin at the next step.

OnOneDrive for work or school is updated frequently. If you don't have the most current version of the groove.exe sync app, you might have problems syncing. [Follow these steps](https://support.office.microsoft.com/article/49771c73-e7ad-4d26-bff1-50bb12a83817) to make sure you have the latest version.

Before we are starting to troubleshoot OneDrive for work or school sync issue, we'd better to do some basic checking at first.

- [Restriction and limitations](#restrictions-and-limitations)
- [Is the library configured to be available offline?](#is-the-library-configured-to-be-available-offline)

### Review conflicts

Sometimes a conflict is detected between the local and server copies of files you're trying to sync.

When a conflict is detected, you may see a sync error notification briefly. After that, the OneDrive for work or school icon will display an error indicator in your system tray.

:::image type="icon" source="media/troubleshoot-sync-issues/sync-error-icon.png":::

To resolve the conflict, right-click or press and hold the OneDrive for work or school icon, and then choose **Resolve**. You can see the options available for your conflict.

If a conflict occurred with an Office file type, you should see the following options:

- **Open to Resolve** opens the file in a coauthor view. First select **Save** to refresh the open copy with the new content. That appears highlighted, so you can easily reconcile changes.
- **Save a Copy** lets you save a copy of your version outside the synced folder.
- **Discard** discards your changes and fetches the new version from the server.

In most cases, select **Open to Resolve**.

If a conflict occurred with a non-Office file type, you should see the following options:

- **Choose** displays information about both versions, and lets you choose whether to keep the server version, your version, or both. Only the server version is saved in the synced folder and library.
- **Save a Copy** lets you save a copy of your version outside the synced folder.
- **Discard** discards your changes and fetches the new version from the server.

In some cases, OneDrive for work or school may not mark conflicts in a non-Office file as an error, but instead save both versions locally. This situation results from editing conflicts. Editing conflicts with Office files are reported as sync problems and you can fix them as described above. But editing conflicts with other types of files are not reported as sync problems. Instead, OneDrive for work or school creates a new version of the file, and appends the device name to the file name. For example:

:::image type="content" source="media/troubleshoot-sync-issues/new-version-of-file.png" alt-text="Screenshot of the new version of the example file.":::

When you see this happen, it's up to you to decide how to treat these file versions. You might consider one of these actions:

- If possible, compare the file versions by opening them in an application, merge changes into one, consolidated version, and then delete the other versions.
- Rename file versions to distinguish them.
- Keep both versions of the file.

> [!NOTE]
> OneDrive for work or school creates up to 10 conflict versions for these types of files.

Did it solve your problem?

- If yes, we're glad that your issue is resolved.
- If no, see [Clear cached files](#clear-cached-files).

### Clear cached files

Sometimes, the Microsoft Office Upload Center may affect the OneDrive for work or school syncing with SharePoint library, it also may stop the SharePoint sync from progressing.

Try clearing cached files from Upload Center. To do this, follow these steps:

1. In the notification area of your task bar, find the Microsoft Office Upload Center icon :::image type="icon" source="media/troubleshoot-sync-issues/white-up-arrow-in-an-orange-circle.png":::, which is a white up-arrow in an orange circle. (If there are two of these, use the darker one.)
2. Right-click the icon, and then choose **Settings**.
3. Choose **Delete cached files**.
4. Confirm by choosing **Delete cached information**.

Did it solve your problem?

- If yes, we're glad that your issue is resolved.
- If no, see [Stop and resync your libraries](#stop-and-resync-your-libraries).

### Stop and resync your libraries

If you're seeing a large number of errors, and you'd rather not try to resolve each one individually, you might consider starting over: Stop syncing the library, and then sync it again, getting fresh data.

When you stop syncing a folder, this simply disconnects the folder from the library. All files are retained in both the previously synced folder and in the library. Before you sync the library to a new folder, you may want to rename the old one, so that the expected name is available for the new folder. Otherwise, the new folder will be named as a copy, for example, **OneDrive @ Contoso 1**. Unless you specified a different location for your folder, the folder is located at C:\Users\<username>\OneDrive @ \<organization name>.

> [!IMPORTANT]
> Do not rename the synced folder after the sync is established. That will break the sync relationship.

- To stop syncing a library, [follow these steps](https://support.microsoft.com/office/stop-syncing-a-library-with-the-onedrive-for-work-or-school-app-a7e41f1f-3a98-4ca7-9443-f10250688330).
- To start syncing a library again, [follow these steps](https://support.microsoft.com/office/sync-sharepoint-files-with-the-onedrive-sync-client-groove-exe-59b1de2b-519e-4d3a-8f45-51647cf291cd).

### Restrictions and limitations

Sometimes the content you try to sync may not be supported. There are several restrictions on the number of items, size, and file names that might cause your sync to stop.

[Read this article](https://support.microsoft.com/office/restrictions-and-limitations-when-you-sync-sharepoint-libraries-to-your-computer-through-onedrive-for-work-or-school-14fdf1b3-61e5-49cd-a9e1-a66588505b4e) to understand limits to the number of items that can be synchronized, size limits, character limits for files and folders, invalid characters and invalid file types. Make sure the files you're trying to sync do not fall into the restrictions or limitations stated in the article. The article also has an automated method for you to rename files and folders so that it will conform with the current requirements of the service.

### Is the library configured to be available offline

A SharePoint administrator may prohibit syncing for a SharePoint site or library. In this case, you will see the following symptoms:

- When you view the library in a browser, the **Sync** button is missing.
- When you try to sync the library, you receive the following error:

  > Options set for this library by your administrator prohibit users from syncing it to a local computer. For more information, see your SharePoint administrator.

If you're not a SharePoint administrator, work with your SharePoint administrator to enable syncing of the site.

If you're a site administrator, use the following steps to confirm the site is available for syncing.

1. Browse to the SharePoint site.
2. Choose the **Settings** gear, then choose **Site Settings**.
3. In the **Search** section, choose **Search and Offline Availability**.
4. In the **Offline Client Availability** section, choose **Yes**.
5. Choose **OK**.

If you're an administrator of the library, use the following steps to confirm the library is available for syncing.

1. Browse to the library.
2. Choose the **Library** tab then choose **Library Settings**.
   > [!NOTE]
   > If you don't have the Library tab, select the Gear icon for the **Settings** menu and then select **Library settings**.
3. This is a section to insert various notes.
4. In the **General Settings** section, choose **Advanced Settings**.
5. In the **Offline Client Availability** section, choose **Yes**.
6. Choose **OK**.

Did it solve your problem?

- If yes, we're glad that your issue is resolved.
- If no, see [Confirm or correct your credentials](#confirm-or-correct-your-credentials).

### Confirm or correct your credentials

If you aren't signed in to the SharePoint Online site, you should log in and select the **Keep me signed in** option to make sure the OneDrive for work or school synchronization process works well.

When you supply credentials, be sure to use the credentials associated with the library. In most cases, this will be your Microsoft 365 credentials.

Did it solve your problem?

- If yes, we're glad that your issue is resolved.
- If no, see [Review conflicts](#review-conflicts).

### Repair OneDrive for work or school or Office installation

Before you try uninstalling and reinstalling, try repairing OneDrive for work or school or Office. Repairing your Office installation can often resolve issues without the need to uninstall and reinstall. [Follow this article](https://support.microsoft.com/office/repair-an-office-application-7821d4b6-7c1d-4205-aa0e-a6b40c5bb88b) to learn how to repair Office programs.

Did it solve your problem?

- If yes, we're glad that your issue is resolved.
- If no, see [Uninstall and reinstall OneDrive for work or school](#uninstall-and-reinstall-onedrive-for-work-or-school).

### Reset Internet Explorer

If previous troubleshooting steps do not help, and other people can sync the library, you may have a custom Internet option that is interfering with the sync. You can try resetting Internet Explorer to its default state, or you can open a support case with Microsoft.

> [!NOTE]
> Resetting Internet Explorer removes all previous customizations of Internet Options. This process cannot be undone.

Did it solve your problem?

- If yes, we're glad that your issue is resolved.
- If no, see [Your issue was not resolved](#your-issue-was-not-resolved).

### Your issue was not resolved

Sorry, but we cannot resolve this issue by using this guide. Here are some other ideas that might help you resolve the problem:

- Use the self-help options on the [Microsoft 365 Community website](https://answers.microsoft.com/msoffice/forum?sort=LastReplyDate&dir=Desc&tab=All&status=all&mod=&modAge=&advFil=&postedAfter=&postedBefore=&threadType=All&isFilterExpanded=false&page=1).
- [Create a support incident](https://portal.office.com/Support/ServiceRequests.aspx) at Microsoft Online Services support. Ask your IT administrator to use the above link to create a new support incident.

### Uninstall and reinstall OneDrive for work or school

The steps to uninstall and reinstall OneDrive for work or school depend on whether you installed the application through a setup program (MSI), or through Office Click-to-run. Read this article to learn how to tell [how Office or the OneDrive for work or school sync app was installed](https://support.microsoft.com/office/update-the-onedrive-for-work-or-school-sync-app-49771c73-e7ad-4d26-bff1-50bb12a83817).

If you installed the OneDrive for work or school sync app through Office Click-to-run, use the following options:

- To uninstall Office, [follow these steps](https://support.microsoft.com/office/uninstall-office-from-a-pc-9dd49b83-264a-477a-8fcc-2fdf5dbf61d8).
- To reinstall Office, [follow these steps](https://support.microsoft.com/office/download-and-install-or-reinstall-microsoft-365-or-office-2019-on-a-pc-or-mac-4414eaaf-0478-48be-9c42-23adc4716658).

If you installed the OneDrive for work or school sync app through a setup program (MSI), use the following options:

- To uninstall the sync app from the Control Panel, [follow these steps](https://support.microsoft.com/office/f32a17ce-3336-40fe-9c38-6efb09f944b0).
- To reinstall the sync app, [download and install OneDrive](https://www.microsoft.com/microsoft-365/onedrive/download).

Did it solve your problem?

- If yes, we're glad that your issue is resolved.
- If no, see [Reset Internet Explorer](#reset-internet-explorer).
