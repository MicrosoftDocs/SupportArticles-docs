---
title: The System Administrator Has Restricted the Types of Logon
description: Helps resolve an error when connecting to a computer—The system administrator has restricted the types of logon (network or interactive).
ms.date: 06/04/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, akastha, narafa, v-lianna
ms.custom:
- sap:remote desktop services and terminal services\session connectivity
- pcy:WinComm User Experience
---
# "The system administrator has restricted the types of logon" error when connecting to a computer

This article helps resolve an error "The system administrator has restricted the types of logon (network or interactive) that you may use" when connecting to a computer.

When you use a Remote Desktop Protocol (RDP) connection to connect to a computer, you're prompted for credentials. However, the session ends immediately after authentication, and you receive the following error message:

> The system administrator has restricted the types of logon (network or interactive) that you may use.

This error indicates that an attempted RDP connection is blocked because of a restriction in the system's Local Security Policy or Group Policy settings related to the allowed logon type.

In addition, you also receive the following events or messages in Event Viewer logs:

- [Event ID 4625](/previous-versions/windows/it-pro/windows-10/security/threat-protection/auditing/event-4625) with a logon failure due to logon type restrictions.
- [Event ID 4005](/answers/questions/389027/winlogon-error-4005) with the message "The Windows logon process has unexpectedly terminated."

This error might occur for the following reasons:

|Cause  |Explanation  |
|---------|---------|
|The user lacks the **Allow log on through Remote Desktop Services** right     |The account isn't a member of a group allowed to use RDP (like **Remote Desktop Users** or **Administrators**).         |
|Group Policy restrictions on logon types     |Group Policy Object (GPO) or local security policy denies logon via RDP or network.         |
|Conflicting security settings     |One policy allows logon, but another policy overrides it and denies it.|
|RDP logon denied by "Deny" policies     |The user is explicitly denied logon rights.    |
|Network Level Authentication (NLA) incompatibility     |NLA requires credentials before establishing an RDP session. Older accounts or systems might fail.         |

## Troubleshooting steps

1. Open **lusrmgr.msc** and ensure the user is a member of **Remote Desktop Users**. If not, add the user to the **Remote Desktop Users** group by using the following cmdlet:

    ```Powershell
    Add-LocalGroupMember -Group "Remote Desktop Users" -Member "DOMAIN\Username"
    ```

2. Verify user rights and group membership.

    - On the local machine:

        In the Local Security Policy snap-in (**secpol.msc**), go to **Local Policies** > **User Rights Assignment**:

        - Ensure the user or group is included in the following policies:

            - **Access this computer from the network**
            - **Allow log on locally**
            - **Allow log on through Remote Desktop Services**

        - Ensure the user or group isn't included in the following policies:

            - **Deny access to this computer from the network**
            - **Deny log on locally**
            - **Deny log on through Remote Desktop Services**

    - On the domain controller (if the system is domain-joined):

        - Open Group Policy Management Console and edit **Default Domain Controllers Policy**.

            Go to **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Local Policies** > **User Rights Assignment**, and confirm the same settings as listed in the preceding step.

        - Open the Active Directory Users and Computers snap-in:

            - Ensure the user or group is a member of **Remote Desktop Users**.
            - Confirm group policy inheritance applies as expected.

3. Check the effective Group Policy. Run the following command to generate a report with the Resultant Set of Policy information:

    ```console
    gpresult /h report.html
    ```

    Open the report and verify the relevant logon rights under **Computer Details**.

4. Ensure the NLA compatibility:

    - Use the latest version of the Remote Desktop client.
    - Enable NLA on the remote computer.
    - Configure user accounts with valid credentials, as NLA requires authentication before the session is established.

    If necessary, temporarily disable NLA by using the following cmdlet:

    ```powershell
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "UserAuthentication" -Value 0
    ```

5. Restart the system or update Group Policy settings by using the following command:

    ```console
    gpupdate /force
    ```
