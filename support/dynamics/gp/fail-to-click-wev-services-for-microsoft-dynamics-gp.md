---
title: Error when you click Web Services for Microsoft Dynamics GP or expand Policy in the Dynamics Security Console
description: Provides a solution to an error that occurs when you click "Web Services for Microsoft Dynamics GP" or when you try to expand Policy in the Dynamics Security Console.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Developer - Customization and Integration Tools
---
# You may receive an error message when you try to click "Web Services for Microsoft Dynamics GP" or when you try to expand Policy in the Dynamics Security Console

This article provides a solution to an error that occurs when you click "Web Services for Microsoft Dynamics GP" or when you try to expand Policy in the Dynamics Security Console.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 950697

## Symptoms

In the Dynamics Security Console in Web Services for Microsoft Dynamics GP, you try to click **Web Services for Microsoft Dynamics GP**, or you try to expand **Policy**. When you do this, you may receive one of the following error messages:

- Error message 1

    > Could not access the SecurityService. System.UnauthorizedAccess Exception

- Error message 2

    > The application encountered and unhandled system exception. Contact your system administrator for details.

- Error message 3

    > Could not access the SecurityService service. System.InvalidOperationException

## Cause

The service account that was entered during the Microsoft Dynamics GP Web Services installation may not be correct in the Active Directory Application Mode (ADAM) instance or in the Authorization Manager security store.

If you are using Web Services for Microsoft Dynamics GP 9.0 or Microsoft Dynamics GP 10.0, the DynamicsGPAdm account needs to be in the ADAM instance and in the Authorization Manager security store as well. In addition, the local DynamicsGPAdm user must be a member of the Administrators group in the Authorization Manager security store. Also, the local DynamicsGPAdm user must be a member of the Reader group for the ADAM instance.

The service account must be a member of the Reader group in the Authorization Manager security store.

## Resolution

To resolve this problem, follow these steps:

1. Use the Authorization Manager Microsoft Management Console (MMC) snap-in to connect to the ADAM instance. To do this, follow these steps:
    1. Click **Start**, click **Run**, type *azman.msc*, and then press ENTER.
    2. On the **Action** menu, click **Open Authorization Store**.
    3. Click **Active Directory**.
    4. Use the appropriate method:
        - If you use Microsoft Dynamics GP 2010, in Windows Explorer locate the following folder and open the DynamicsSecurityAdmin.config file:  
            C:\\Program Files\\Microsoft Dynamics\\GPWebServices\\ServiceConfigs
        - If you use Microsoft Dynamics GP 10.0 or Microsoft Dynamics 9.0, in Windows Explorer locate the following folder and open the Web.config file:  
            C:\\Program Files\\Microsoft Dynamics\\GPWebServices\\WebServices

    5. Copy the value for the AzManConnectionString setting. For example, it may look like this:

        msldap://server_name:389/CN=DynamicsSecurityService,CN=DynamicsSecurityServicePartition,DC=Microsoft,DC=COM

    6. In the **Open Authorization Store** window, paste this value in the **Store Name** field, change the authorization store type to the appropriate type according to the AzManConnectionString value in step f, and then click **OK**.

    7. Right-click the **DynamicsSecurityService** store, and then click **Properties**.

    8. Click the **Security** tab, add the service account user as a member of the Reader group. If you use Microsoft Dynamics GP 10.0 or Microsoft Dynamics GP 9.0, add the local DynamicsGPAdm user as a member of the Administrators group.

        > [!NOTE]
        > If these users already exist, delete and then re-add these users.

2. Use the ADAM Active Directory Service Interfaces (ADSI) tool to connect to the DynamicsSecurityServicePartition partition. To do this, follow these steps:

    1. Click **Start**, click **Programs**, and then click **ADAM ADSI Edit**.
    2. Click **Action**, click **Connect To**, and then type *CN=DynamicsSecurityServicePartition,DC=Microsoft,DC=COM* under **Distinguished name (DN) or naming context**.
    3. Follow the step for your version of the program.
        - Windows Server 2008

            In the **Select or type domain or server** box, type *domainname:389*, and then click **OK**.
          - Windows Server 2003

            Click **OK**.
    4. Expand **My Connection**, and then expand **CN=DynamicsSecurityServicePartition,DC=Microsoft,DC=COM**.
    5. Expand **CN=Roles**, right-click **CN=Readers**, and then click **Properties**.
    6. Scroll down to the member attribute, and then click **Edit**.
    7. Click **Add Windows Account**. Add the service account user. Then, if you use Microsoft Dynamics GP 10.0 or Microsoft Dynamics GP 9.0, add the local DynamicsGPAdm user.
    8. Click **OK**, and then exit the ADAM ADSI tool.

3. If you use Microsoft Dynamics GP 10.0 or Microsoft Dynamics 9.0, add the local DynamicsGPAdm user to the local IIS_WPG group.

4. If you use Microsoft Dynamics GP 10.0 or Microsoft Dynamics 9.0, grant the local DynamicsGPAdm user the Modify permission for everything in the following folder:

    C:\\Program Files\\Common Files\\Microsoft Shared\\Microsoft Dynamics\\Security Admin Service
