---
title: Troubleshoot password resets blocked by on-premises policy
description: Troubleshoot scenarios in which a user or administrator can't reset or change a password because of the on-premises Active Directory password policy.
ms.date: 02/11/2022
ms.reviewer: jarrettr, nualex, v-leedennis
ms.service: active-directory
ms.subservice: enterprise-users
keywords:
#Customer intent: As a Microsoft Entra administrator, I want to provide temporary passwords that meet the local Active Directory password policy so that users can successfully reset or change their password.
---
# Troubleshoot password resets that are blocked by on-premises policy

This article helps you troubleshoot a scenario in which a user or administrator can't reset or change a password because the on-premises Active Directory password policy disallows it.

## Symptoms

In the [Azure portal](https://portal.azure.com), you take the following steps:

1. Select **Microsoft Entra ID** > **Users**.
1. Choose a user from the list.
1. Select the **Reset password** link.
1. Enter a temporary password for the user to use.
1. Select the **Reset password** button.

In this scenario, you receive the following error message:

> Unfortunately, you cannot reset this user's password because your on-premises policy does not allow it. Please review your on-premises policy to ensure that it is setup correctly.

## Cause

The error message is sent by an on-premises domain controller. To obtain more information about the problem, follow these steps.

> [!NOTE]
> This procedure requires that you enable your domain controller's audit policy for **Account Management - Failure** events. For more information, see [Audit account management](/windows/security/threat-protection/auditing/basic-audit-account-management).

1. Go to an on-premises domain controller.

1. Open the Event Viewer snap-in. To do this, select **Start**, enter *eventvwr.msc*, and then press Enter.

1. Under the **Event Viewer (Local)** node in the sidebar, expand **Windows Logs**, and then select **Security**.

1. Look for audit events that contain **Event ID 4724**, **Audit Failure** (in the **Keywords** column) and **User Account Management** (in the **Task Category** column). These events should resemble the following example:

   ```output
   Log Name:      Security
   Source:        Microsoft-Windows-Security-Auditing
   Date:          11/5/2020 2:44:01 AM
   Event ID:      4724
   Task Category: User Account Management
   Level:         Information
   Keywords:      Audit Failure
   User:          N/A
   Computer:      ADDS01.Contoso.net
   Description:
   An attempt was made to reset an account's password.

   Subject:
       Security ID:        Contoso\MSOL_73c8a9aa6173
       Account Name:       MSOL_73c8a9aa6173
       Account Domain:     Contoso
       Logon ID:           0xF91C5C
 
   Target Account:
      Security ID:        Contoso\User01
      Account Name:       User01
      Account Domain:     Contoso

   Event Xml:
   <Event xmlns="http://schemas.microsoft.com/win/2004/08/events/event">
     <System>
       ...
     </System>
   </Event>
   ```

This example confirms that password writeback is working as expected. However, the password that's entered doesn't meet the local Active Directory password policy. The policy might be violated because of password length, complexity, age, or other requirements.

## Solution

Provide a password that meets the local Active Directory password policy.

First, verify the current settings for the password policy to be able to determine any violations. Then, go to the domain controller, and use one or more of the following methods:

- From an on-premises domain controller, open an administrative Command Prompt window, and run the [net accounts](../../windows-server/networking/net-commands-on-operating-systems.md) command:

  ```output
  C:\>net accounts
  
  Force user logoff how long after time expires?:       Never
  Minimum password age (days):                          0
  Maximum password age (days):                          42
  Minimum password length:                              7
  Length of password history maintained:                24
  Lockout threshold:                                    Never
  Lockout duration (minutes):                           30
  Lockout observation window (minutes):                 30
  Computer role:                                        PRIMARY
  The command completed successfully.
  ```

- Alternatively, open an administrative PowerShell window, and then run the [Get-ADDefaultDomainPasswordPolicy](/powershell/module/activedirectory/get-addefaultdomainpasswordpolicy) cmdlet:

  ```output
  PS C:\WINDOWS\system32> Get-ADDefaultDomainPasswordPolicy
  
  ComplexityEnabled           : True
  DistinguishedName           : DC=contoso,DC=net
  LockoutDuration             : 00:30:00
  LockoutObservationWindow    : 00:30:00
  LockoutThreshold            : 0
  MaxPasswordAge              : 42:00:00
  MinPasswordAge              : 00:00:00
  MinPasswordLength           : 7
  objectClass                 : {domainDNS}
  objectGuid                  : 01234567-89ab-cdef-0123-456789abcdef
  PasswordHistoryCount        : 24
  ReversibleEncryptionEnabled : False
  ```

- In an administrative Command Prompt window, [export a Group Policy report](/windows-server/administration/windows-commands/gpresult) in HTML format by running `gpresult /h GPreport.htm`. Open the exported report (*GPreport.htm*) in a browser window, and then view the policy settings under **Account Policies/Password Policy**.

  :::image type="content" source="media/password-writeback-not-compliant-on-premises-ad-pwd-policy/group-policy-report-browser-window.png" alt-text="Screenshot of a Group Policy H T M L report. Refer to settings in Settings, Policies, Windows Settings, Security Settings, Account Policies/Password Policy.":::

Was the local Active Directory password policy configured by using [fine-grained password policies](/windows-server/identity/ad-ds/get-started/adac/introduction-to-active-directory-administrative-center-enhancements--level-100-#fine_grained_pswd_policy_mgmt)? If so, check the resultant password policy for the target user by running the [net user](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc771865(v=ws.11)) command (`net user <username> /domain`):

```output
C:\>net user User01 /domain

User name                    User01
Full Name                    User01
Comment
User's comment
Country/region code          000 (System Default)
Account active               Yes
Account expires              Never

Password last set            11/5/2020 1:57:43 PM
Password expires             12/17/2020 1:57:43 PM
Password changeable          11/5/2020 1:57:43 PM
Password required            Yes
User may change password     Yes

Workstations allowed         All
Logon script
User profile
Home directory
Last logon                   Never

Logon hours allowed          All

Local Group Memberships
Global Group memberships     *Domain Users
The command completed successfully.
```

Is the entered password compliant with the local Active Directory password policy, but the issue persists? If so, check whether you're using [Microsoft Entra Password Protection](/azure/active-directory/authentication/concept-password-ban-bad-on-premises) in your on-premises AD DS environment, or if you have any third-party password filter software installed on your domain controllers.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
