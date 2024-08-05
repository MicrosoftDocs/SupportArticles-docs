---
title: Health Service doesn't process configuration files
description: Fixes an issue where Health Service doesn't process configuration files on a domain controller that's running the Operations Manager agent.
ms.date: 04/15/2024
---
# Operations Manager Health Service doesn't process configuration files and logs events 7022 and 1220

This article helps you fix an issue where Health Service doesn't process configuration files on a domain controller that's running the Operations Manager agent.

_Original product version:_ &nbsp; Microsoft System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 946428

## Symptoms

After you install the Microsoft System Center Operations Manager agent on a Windows domain controller, the Health Service doesn't process configuration files. Additionally, events 7022 and 1220 are logged every 30 minutes to the Application log on the domain controller.

## Cause

This problem occurs when you configure an account that doesn't have administrative rights as the default action account.

The System Center Operations Manager agent uses the Run As profile that's named Privileged Monitoring Account to process Health Service configuration. By default, the Privileged Monitoring Account profile uses the LocalSystem account.

When you configure the agent to use a domain user as the default action account on a domain controller, the Health Service Lockdown tool (HSLockdown.exe) is automatically run at installation. The Health Service Lockdown Tool denies Health Service access to the **NT AUTHORITY\SYSTEM** security principal.

In this scenario, only the **NT AUTHORITY\Authenticated Users** security principal is allowed access to the Health Service. But when the Active Directory is hardened, or the agent is misconfigured, the LocalSystem account cannot authenticate through the Authenticated Users security principal, therefore the agent cannot process Health Service configuration information.

## Resolution 1: Configure the Privileged Monitoring Account profile

Configure the Privileged Monitoring Account profile to use a domain user who has administrative rights on the affected domain controllers. To do this, follow these steps:

1. Open the Operations Manager console, and then select **Administration**.
2. Under **Security**, right-click **Run As Accounts**, and then select **Create Run As Account**. This starts the **Create Run As Account Wizard**.
3. Select **Windows** in the **Run As Account type** box. Enter a display name, and then select **Next**.
4. Enter the user name and the password for an account that is a member of the Administrators group on the domain controller, and then select **Create**.
5. After the Run As account is created, open the **Run As Profiles** view, and double-click **Privileged Monitoring Account**.
6. Select the **Run As Accounts** tab.
7. Select **New**.
8. Select the Run As account that you created in step 2 through step 4.
9. Select the domain controller in the list of computers, and then click **OK**.
10. Repeat step 7 through step 9 for each affected domain controller.
11. Click **OK** in the **Run As Profile Properties** dialog box.
12. Restart the Operations Manager Health Service on the affected domain controllers.

## Resolution 2: Run HSLockdown.exe to configure permissions

Run HSLockdown.exe on the affected domain controllers to remove **NT Authority\SYSTEM** from the denied list. To do this, follow these steps:

1. On the domain controller, open a command prompt, and then open the folder where the agent software is installed.
1. Type the following command, and then press ENTER:

   ```console
   hslockdown "Management_Group _Name" /R "NT AUTHORITY\SYSTEM"
   ```

   In this command, *Management_Group _Name* is the name of the Operations Manager management group of which the agent is a member. Use quotation marks if the name contains spaces.
1. Restart the Operations Manager Health Service.
1. Repeat step 1 through step 3 on each domain controller that's affected.

## References

For more information about HSLockdown.exe, see [How to Use the Health Service Lockdown Tool in Operations Manager 2007](/previous-versions//bb309542(v=technet.10)?redirectedfrom=MSDN).
