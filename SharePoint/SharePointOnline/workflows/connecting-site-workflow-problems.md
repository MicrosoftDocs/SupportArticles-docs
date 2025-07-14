---
title: Workflow problems after you connect to a SharePoint site
description: Install SharePoint Designer 2013 to fix workflow problems after you connect to a SharePoint Online or SharePoint Server 2013 site.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Workflows and Automation\Other
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
  - SharePoint Server 2013
ms.date: 12/17/2023
---

# Workflow problems after you connect to a SharePoint Online or SharePoint Server 2013 site

## Problem

Consider the following scenario.

When you use SharePoint Designer 2010, you experience one or more of the following issues:

- When you try to edit or publish a workflow, you receive one of the following error messages:

  - **SharePoint Designer cannot display the item.**
  - **The list of workflow actions on the server references an assembly that does not exist. Some actions will not be available.**

- You take steps to create a new list workflow, site workflow, or reusable workflow. However, after you have completed the steps, the item isn't present.
- When you connect to a SharePoint Online site, you receive the following error message:

  - **Microsoft SharePoint Designer cannot be used to edit web sites on servers different from SharePoint Server 2010.**

- When you connect to a SharePoint site, you receive the following error message:

  - **This web site has been configured to disallow editing with SharePoint Designer.**

When you experience one or more of these issues, the following conditions are also true:

- You're using SharePoint Online.
- You've upgraded your on-premises installation of SharePoint Server 2010 to SharePoint Server 2013.
- You've upgraded your installation of SharePoint Foundation 2010 to SharePoint Foundation 2013.

> [!NOTE]
> If you're using SharePoint Server 2010, this article doesn't apply to your scenario.

## Solution

To resolve these issues, install [SharePoint Designer 2013](https://www.microsoft.com/download/details.aspx?id=35491).

> [!NOTE]
> You can install SharePoint Designer 2013 alongside SharePoint Designer 2010. However, we recommend that you uninstall SharePoint Designer 2010 before you install SharePoint Designer 2013.

## More information

If you're experiencing the message "This web site has been configured to disallow editing with SharePoint Designer" in an on-premises installation of SharePoint Foundation 2013 or SharePoint Server 2013, be aware that a site definition configuration may be responsible for the message. For more information, go to [Project Element (Site)](/sharepoint/dev/schema/project-element-site).

If changes were made to the site by using SharePoint Designer 2010 before you installed SharePoint Designer 2013, you may continue to experience one or more of the symptoms in the "Problem" section. If you're still experiencing these issues, follow these steps:

1. Exit SharePoint Designer 2013. If you're using the Click-to-Run version of SharePoint Designer 2013, go to step 4. Otherwise, go to step 2.
1. Install the SharePoint Designer 2013 hotfix that's dated June 11, 2013. For more information, see the [Description of the SharePoint Designer 2013 hotfix package (Spd-x-none.msp): June 11, 2013](https://support.microsoft.com/help/2768343).

   > [!NOTE]
   > This step doesn't apply if you're using the Click-to-Run version of SharePoint 2013.

1. Start SharePoint Designer 2013, and then connect to your SharePoint site. If the issue persists, go to the next step.
1. On the local computer, browse to the following folder:

   **C:\Users\username\AppData\Local\Microsoft\WebsiteCache**
   
   > [!NOTE]
   > To locate some of the files and folders, you may have to configure File Explorer or Windows Explorer to show hidden files, folders, and drives. To do this, see [Show hidden files](https://support.microsoft.com/help/14201) for specific steps for your operating system.

1. Delete all the files and folders that are present.
1. On the local computer, browse to the following folder:

   **C:\Users\username\AppData\Roaming\Microsoft\SharePoint Designer\ProxyAssemblyCache**

1. Delete all the files and folders that are present.
1. On the local computer, browse to the following folder:

   **C:\Users\username\AppData\Roaming\Microsoft\Web Server Extensions\Cache**

1. Delete all the files and folders that are present.
1. Start SharePoint Designer 2013, and proceed with your original intentions.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
