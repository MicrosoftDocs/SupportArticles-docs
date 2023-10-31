---
title: Directory synchronization to Microsoft Entra ID stops or you're warned that sync hasn't registered in more than a day
description: Describes a performance problem in Azure Active Directory Sync Tool. The tool either stops syncing or reports that sync hasn't run in more than 24 hours. Provides a resolution.
ms.date: 05/09/2020
ms.reviewer: willfid
ms.service: active-directory
ms.subservice: enterprise-users
---
# Directory synchronization to Microsoft Entra ID stops or you're warned that sync hasn't registered in more than a day

This article describes a performance problem in Azure Active Directory Sync Tool. The tool either stops syncing, or reports that sync hasn't run in more than 24 hours.

_Original product version:_ &nbsp; Microsoft Entra ID, Microsoft Intune, Azure Backup, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2882421

## Symptoms

You experience one of the following symptoms:

- The Microsoft Azure Active Directory Sync Tool stops syncing.
- You receive email messages that say that Microsoft Entra ID didn't register a synchronization attempt in the last 24 hours.
- In the `MIISClient.exe` tool, you receive a "Stopped-Server-Down" message or a "Stopped-Extension-DLL-Exception" message.
- You're unable to start one or more of the directory synchronization services.

> [!NOTE]
> By default, directory synchronization runs every three hours.

## Cause

This issue may occur if one or more of the following conditions are true:

- The work or school account that was used in the configuration wizard to set up directory synchronization has one of the following problems:
  - The account was deleted.
  - The account was disabled.
  - The account password expired.
- The logon account for one or more directory synchronization services has one of the following problems:
  - The account was deleted.
  - The account was disabled.
  - The account password expired.

  > [!NOTE]
  >The logon account for the directory synchronization service is automatically configured and should not be modified.

- The admin account that's used for directory synchronization was changed.
- You have network connection issues.
- Directory synchronization services are stopped.

## Resolution

### Method 1: Manually verify that the service is started and that the admin account can sign in

1. Select **Start**, select **Run**, type **Services.msc**, and then select **OK**.
2. Locate the Microsoft Entra Synchronization appliance service, and then check whether the service is started. If the service isn't started, right-click it, and then select **Start**.
   - If you're using the Azure Active Directory Sync Tool, look for **Azure Active Directory Sync Service**.
   - If you're using Microsoft Entra Connect, look for **Microsoft Azure AD Sync**.
3. Verify that the admin account that's being used for directory synchronization still exists. And verify that the account is allowed to sign in. If the account still exists, reset the password, and then verify that you can sign in. If you're prompted, change the password.

    If you don't know the global administrator account that's used to configure directory synchronization, follow these steps on the server on which you installed the directory synchronization appliance:

      1. Go to `%ProgramFiles%\Microsoft Azure AD Sync\UIShell\`, and then run Miisclient.exe.

          > [!NOTE]
          > If you're using Microsoft Entra Connect or the Azure Active Directory Sync Service, select **Start**, and then search for and open **Synchronization Service**.

      2. Select **Connectors**, and then double-click the Microsoft Entra connector.
      3. Select **Connectivity**.
      4. Make note of the **UserName** value. It's the global administrator account that's used to configure directory synchronization.
4. On the directory synchronization server, run the Microsoft Entra Synchronization appliance configuration wizard. Type the new password for the admin account that's used for directory synchronization, and then follow the remaining steps in the wizard.
5. When you're prompted, select the **Force directory synchronization** check box.

### Method 2: Resolve the problem with the logon account for the directory synchronization service

1. Select **Start**, select **Run**, type Services.msc, and then select **OK**.
2. Locate the Microsoft Entra Synchronization appliance service:
   - If you're using the Azure Active Directory Sync Tool, look for **Azure Active Directory Sync Service**.
   - If you're using Microsoft Entra Connect, look for **Microsoft Azure AD Sync**. Right-click the service, and then select **Properties**. On the **Log On** tab, note the account name that's listed.

    > [!NOTE]
    > Reconfiguring any of the directory synchronization services to log on as a local system account isn't supported and may introduce problems.

3. On a domain controller or a computer that has the Administration Tools installed, open Active Directory Users and Computers (Dsa.msc), right-click the domain name, and then select **Find**. Type the name of the account that you noted in step 2, and then select **Find now**.
   - If you find the account, go to step 4.
   - If you can't find the account, it may have been deleted. For more information about how to restore this account, see [Active Directory Recycle Bin Step-by-Step Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd392261(v=ws.10)). If you can't restore the account, you must uninstall and then reinstall the directory synchronization client.
4. Right-click the account, and then select **Properties**. On the **Account** tab, under **Account options,**  follow these steps:
    1. Make sure that the **Password never expires** check box is selected.
    2. Make sure that the **Account is disabled** check box is cleared. Then, take one of the following actions:
      - If the **Account is disabled** check box is selected, clear it to enable the account. Then, restart the Microsoft Entra Synchronization appliance service. To do so, select **Start**, select **Run**, type Services.msc, and then select **OK**. Locate the service, right-click it, and then select **Restart**.
        - If you're using the Azure Active Directory Sync Tool, look for **Azure Active Directory Sync Service**.
        - If you're using Microsoft Entra Connect, look for **Microsoft Azure AD Sync**.
      - If the **Account is disabled** check box is already cleared, go to step 5.

5. If the **Account is disabled**  check box is already cleared, it's possible that the password for the account was manually changed. To set a new password, open Active Directory Users and Computers, locate and right-click the account, and then select **Reset Password**  to reset the password. Note the password that you set because you'll have to use it in the next step.
6. Set the password on the logon account for the directory synchronization services:

    1. select **Start**, select **Run**, type Services.msc, and then select **OK**.
    2. Set the password for the following services, depending on the client that you're using. To do so, right-click the appropriate service, select **Properties**, select the **Log On** tab, and then type the password.

        |Microsoft Entra Synchronization client|Microsoft Entra Connect|
        |---|---|
        |<br/> Forefront Identity Manager Synchronization Service<br/>      SQL Server (MOSONLINE) (if present)<br/>      Azure Active Directory Sync Service|<br/>    Azure AD Sync|

    3. Start the service or services for which you set the new password.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
