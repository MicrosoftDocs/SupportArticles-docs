---
title: Rename the Azure DevOps Service URL
description: This article provides the steps to rename the URL of your Azure DevOps Service.
ms.date: 10/15/2020
ms.custom: sap:Client Connectivity
ms.topic: how-to
ms.service: azure-devops
ms.subservice: ts-client-connectivity
---
# Things to do before and after you rename the URL of your Azure DevOps Service

This article provides the steps to rename the URL of your Azure DevOps Service.

_Original product version:_ &nbsp; Microsoft Azure DevOps Service  
_Original KB number:_ &nbsp; 2793597

## Introduction

On the **Settings** tab of the Team Foundation Account Administration UI, you can rename the URL of your Azure DevOps Service. Although renaming the URL is fairly simple, there are a few things you should do before and after you rename the URL to make sure that you and your team can continue to work as before.

## Things to do before you rename the URL of your Azure DevOps Service

- Save your work.
- Make sure that other members of the Azure DevOps Service are not using the service.

## Things to do after you rename the URL of your Azure DevOps Service

We will not set up a redirect from your previous Azure DevOps Service URL to the new URL. This means that the previous URL will 404, and you will have to update existing connection strings to point to the new URL. Additionally, you may have to take one or more of the following actions, depending on your specific configuration and how you use the service:

- Update existing connection strings in Visual Studio to point to the new Azure DevOps Service URL:

  1. Start Visual Studio, and then click **Connect to Team Foundation Server** in the left navigation pane of the **Start** page.
  2. Click **Servers**, and then click **Add**.
  3. In the **Name or URL of Team Foundation Server** field, type your new Azure DevOps Service URL (`https://yournewaccount.visualstudio.com/`), and then click **OK**.
  4. Log on by using your Azure DevOps Service (LiveID) if you are prompted.
  5. In the **Team Foundation Server list** dialog box, highlight the previous Team Foundation Service URL, and then click **Remove**.
  6. Click **Close**.
  7. In the **Select a Team Foundation Server** dialog box, click to select your Team Project check box, and then click **Connect**.
  8. Visual Studio warns you about projects and solutions that will be closed and asks you whether you want to continue. Click **Yes**.

- Update existing connection strings in Office documents to point to the new Azure DevOps Service URL:

  1. For Excel documents, start Excel, click **Configure** in the Team Ribbon, and then go to step 6.
  2. For Project, click **Configure Server Connection** in the Team Ribbon, and then go to step 7.
  3. For PowerPoint, click **Storyboard Links** in the Storyboarding Ribbon.
  4. PowerPoint will warn about Team Foundation services not being available from the server. Click **OK**.
  5. Click **Connect** and go to step 8.
  6. Click **Server Connection**.
  7. You will receive a warning that advises you to continue with the reconnect operation only if the host server instance was upgraded or if the team project collection was moved to another server instance. Click **OK**.
  8. Click **Servers**, and then click **Add**.
  9. In the **Name or URL of Team Foundation Server** field, type your new Azure DevOps Service URL (`https://yournewaccount.visualstudio.com/`), and then click **OK**.
  10. Log on by using your Azure DevOps Service (LiveID) if you are prompted.
  11. In the **Team Foundation Server list** dialog box, highlight the previous Team Foundation Service URL, and then click **Remove**.
  12. Click **Close**.
  13. In the **Select a Team Foundation Server** dialog box, click to select your Team Project by check box, and then click **Connect**.
  14. If you are using PowerPoint, click **Close** in the **Storyboard Links** dialog box.

- Reconfigure your version control workspaces:

  - Your local version control cache has to be updated by running the following:
  
    ```console
    tf workspaces /collection:<new collection URL>
    ```

    > [!NOTE]
    > This won't work for build servers in most cases because the build service runs as a system Azure DevOps Service (network service or local system) and because tf workspaces cannot be run as those Azure DevOps Services. Deleting the workspace on the server doesn't fix the local cache.

  - To work around this issue, you have to manually delete the version control cache for the system Azure DevOps Service that your build is running as. The version control cache will be in a path that resembles the following:
  
    `C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Team Foundation\4.0\Cache`

- Update Git remotes:
  1. In the web user interface, click the **Clone** button and copy the new Git URL.
  2. Open a command prompt window. Change the directory to the Git repository.
  3. Update the remote URL. Assuming that the remote is named _origin_, the command would be: `git remote set-url origin <url_copied_from_web>`.

  > [!NOTE]
  > If you use Visual Studio, you may need to refresh Team Explorer.

- Remove and re-configure the self-host agents that point to the previous Azure DevOps service URL.
  - [Remove and re-configure the self-host Windows agents](/azure/devops/pipelines/agents/v2-windows#remove-and-re-configure-an-agent).
  - [Remove and re-configure the self-host Linux agents](/azure/devops/pipelines/agents/v2-linux#remove-and-re-configure-an-agent).
  - [Remove and re-configure the self-host macOS agents](/azure/devops/pipelines/agents/v2-osx#remove-and-re-configure-an-agent).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
