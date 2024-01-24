---
title: Can't access Web sites when security event log is full
description: This article provides resolutions for the problems that a user may experience when the user tries to access a Web site. IIS may return HTTP 500 errors or user logon failures when CrashOnAuditFail is enabled and the security event log is full.
ms.date: 12/11/2020
ms.reviewer: LPrete
ms.subservice: general
---
# Users cannot access Web sites when the security event log is full

This article helps you resolve the problem where user can't access Web sites when the security event log is full.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 832981

## Summary

The **CrashOnAuditFail** feature is a registry key that can be set to make sure that all auditable events are recorded in the security event log. If an auditable event cannot be logged in the security event log, a stop error (STOP 0xC0000244) occurs. The stop error typically occurs because the security event log is full. After the stop error occurs, non-administrator accounts cannot access the Web sites, and Microsoft Internet Information Services (IIS) returns HTTP 500 error messages until the **CrashOnAuditFail** key is reset and the security event log is cleared.

## Symptoms

When you access a Web site on the server, you receive one of the following error messages.

- Error message 1
    > HTTP 500 - Internal Server Error

- Error message 2
    > HTTP Error 401.1 - Unauthorized: Access is denied due to invalid credentials.

- Error message 3
    >The Local security authority cannot be contacted.

- When friendly error messages are turned off in the browser, you may also receive the following error message:
    > Logon failure: user not allowed to log on to this computer.

## Cause

This problem occurs if the security event log has reached the maximum log size and the **Event Log Wrapping** setting is set to **Overwrite Events Older thanXDays** or **Do Not Overwrite Events**. Because the security event log is full, and the **CrashOnAuditFail** registry key is set, Microsoft Windows does not permit accounts that are not administrator accounts to log on. When anonymous access is configured, requests to the Web site try to authenticate by using the IUSR_**computername** and IWAM_**computername** accounts. These accounts are not administrator accounts.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To resolve this issue, follow these steps:

1. Save and clear the security event log.
2. Start Registry Editor.
3. Locate the following key, and then set the value of this key to *1*:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\CrashOnAuditFail`

4. Restart the server. The registry changes do not take effect until you restart the server.

## More information

The **CrashOnAuditFail** registry key provides an optional security feature that system administrators can use to review all security events. The valid values for the **CrashOnAuditFail** key are 0, 1, and 2. The data options are:

- 0 - Anyone may log on. This is the default value.

- 1 - Anyone may log on if the system can audit the events and write the events to the security event log. If the security event log is full, the value for the **CrashOnAuditFail** key is changed to 2, and the server crashes.

- 2 - Only administrators may log on.

When the security event log becomes full, the server locks itself down so that no auditable events are missed. You can prevent the server lockdown by using one of the following methods. Note, however, that preventing the server lockdown defeats the purpose of the **CrashOnAuditFail** key.

> [!NOTE]
> None of the following methods alone resolves the issue. You must follow the steps in the [Resolution](#resolution) section before you use one of these methods.

- Set the **Event Log Wrapping** setting to **Overwrite events as needed**.
- Limit the number or types of events that are audited, or disable auditing completely.
- Set the value for the following registry key to *0*:

     `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\CrashOnAuditFail`
