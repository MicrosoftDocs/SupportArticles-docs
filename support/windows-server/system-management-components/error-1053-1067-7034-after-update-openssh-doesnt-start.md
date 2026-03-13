---
title: Error 1053, Error 1067, or Event ID 7034 and OpenSSH Server Service Doesn't Start After You Install a Windows Update
description: Explains how to resolve an issue that prevents the OpenSSH Server service from starting after you install specific Windows updates.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, v-appelgatet
ms.custom:
- sap:system management components\openssh (including sftp)
- pcy:WinComm User Experience
appliesto:
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---
# "Error 1053," "Error 1067," or Event ID 7034 and OpenSSH Server service doesn't start after you install a Windows update

This article explains how to resolve an issue in which the OpenSSH Server service doesn't start after you update Windows.

## Symptoms

After you install a Windows update for OpenSSH Version 9.5.2.1, the OpenSSH Server service doesn't start. This problem typically involves updates that were released between October 8, 2024, and March 11, 2025 (inclusive). The following updates might relate to this problem:

- [October 8, 2024 - KB5044284 (OS Build 26100.2033) - Microsoft Support](https://support.microsoft.com/topic/october-8-2024-kb5044284-os-build-26100-2033-6baf4a06-9763-4d9b-ba8a-f25ba6ed477b) (Windows 11 24H2 and Windows Server 2025)

- [October 8, 2024 - KB5044285 (OS Builds 22621.4317 and 22631.4317) - Microsoft Support](https://support.microsoft.com/topic/october-8-2024-kb5044285-os-builds-22621-4317-and-22631-4317-c1aba548-fc93-420e-855f-8594157c3e9e) (Windows 11 22H2 and 23H2)

- [October 8, 2024 - KB5044280 (OS Build 22000.3260) - Microsoft Support](https://support.microsoft.com/topic/october-8-2024-kb5044280-os-build-22000-3260-241b0bf0-1fc3-4dfe-8260-03a3f62f3066) (Windows 11 21H2)

- [October 8, 2024 - KB5044288 (OS Build 25398.1189) - Microsoft Support](https://support.microsoft.com/topic/october-8-2024-kb5044288-os-build-25398-1189-07468931-d90b-4566-9865-f435fe4c3ea8) (Windows Server 23H2)

- [October 8, 2024 - KB5044281 (OS Build 20348.2762) - Microsoft Support](https://support.microsoft.com/topic/october-8-2024-kb5044281-os-build-20348-2762-e063059c-9122-4324-86e8-4f6f3383a20a) (Windows Server 2022)

- [October 8, 2024 - KB5044273 (OS Builds 19044.5011 and 19045.5011) - Microsoft Support](https://support.microsoft.com/topic/october-8-2024-kb5044273-os-builds-19044-5011-and-19045-5011-a07551f8-e20d-4fd4-87f3-01145a3cd494) (Windows 10 22H2)

- [October 8, 2024 - KB5044277 (OS Build 17763.6414) - Microsoft Support](https://support.microsoft.com/topic/october-8-2024-kb5044277-os-build-17763-6414-edccc872-2f4e-4ac6-b224-50ca8f1acd4f) (Windows Server 2019)

For a list of all operating system versions that received the updated version of OpenSSH, see the "Security Updates" section of [CVE-2024-43581](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2024-43581): Microsoft OpenSSH for Windows Remote Code Execution Vulnerability.

The exact behavior and messages vary based on your situation. The following scenarios show how the failure might occur, and the message that you see in each case:

- **Scenario 1**. The System event log records Service Control Manager Event ID 7034:

  > The openSSH SSH Server terminated unexpectedly. It has done this *X* time(s).

- **Scenario 2**. OpenSSH 9.5 doesn't start, and you receive the following error message:

  > Service 'OpenSSH SSH Server' (sshd) failed to start. Verify that you have sufficient privileges to start system services.

- **Scenario 3**. You try to manually start the OpenSSH 9.5 Server service by using the Services MMC (Microsoft Management Console) snap-in (Services.msc). The service doesn't start, and you receive the following error message:

  > Windows could not start the OpenSSH SSH Server service on Local computer. Error 1067. The process terminated unexpectedly.

- **Scenario 4**. You try to manually start the OpenSSH 9.5 Server service by running `sc query ssh-agent` at a Windows command prompt. The service doesn't start, and you receive the following error message:

  > StartService FAILED 1053: The service did not respond to the start or control request in a timely fashion.

## Cause

This issue occurs if the C:\ProgramData\ssh and C:\ProgramData\ssh\logs folders have incorrect permissions. The permissions might be too limited or too open. For example, the SYSTEM account or the Administrators group might not have write permissions. For a second example, regular users might have write or full control permissions.

You can use Windows PowerShell to review the permissions in the current access control list (ACL) configuration. Open a PowerShell Command Prompt window, and then run the following commands:

```powershell
Get-Acl C:\ProgramData | Select-Object -Property AccessToString | fl *
```

```powershell
Get-Acl C:\ProgramData\ssh | Select-Object -Property AccessToString | fl *
```

```powershell
Get-Acl C:\ProgramData\ssh\logs | Select-Object -Property AccessToString | fl *
```

```powershell
Get-Acl "C:\ProgramData\ssh\sshd_config" | Select-Object -Property AccessToString | fl *
```

## Resolution

On devices that this issue affects, start File Explorer, and then open the **Properties** dialog boxes for each of the ssh folders (C:\ProgramData\ssh and C:\ProgramData\ssh\logs). In each dialog box, select **Security**, and set the permissions that are shown in the following table.

| Allowed permissions on SYSTEM and Administrators security principals | Allowed permissions on all other security principals |
|-----|-----|
| **Group**: Administrators <br /> **Permissions**: Full control, Modify, Read & execute, List folder contents, Read, Write | **Group**: Authenticated Users <br /> **Permissions**: Read & execute, List folder contents, Read |
| :::image type="content" source="media/error-1053-1067-7034-after-update-openssh-doesnt-start/openssh-administrative-permissions.png" alt-text="Windows permissions dialog box that shows full control access for SYSTEM and Administrators accounts." lightbox="./media/error-1053-1067-7034-after-update-openssh-doesnt-start/openssh-administrative-permissions.png"::: | :::image type="content" source="media/error-1053-1067-7034-after-update-openssh-doesnt-start/openssh-nonadministrative-permissions.png" alt-text="Windows permissions dialog box that shows read and execute permissions on non-administrator accounts." lightbox="./media/error-1053-1067-7034-after-update-openssh-doesnt-start/openssh-nonadministrative-permissions.png"::: |

## Workaround

Install updates that allow the service to start if the permissions aren't correct.

Install Windows updates that allow the OpenSSH service to start even if the C:\ProgramData\ssh and C:\ProgramData\ssh\logs folders don't have correct permissions. When you use this workaround, Windows logs Event ID 4. The description of Event ID 4 resembles the following excerpt:

> For '%programdata\\ssh' folder, write access is granted to the following users: NT AUTHORITY\\Authenticated Users. Consider reviewing users to ensure that only NT AUTHORITY\\SYSTEM, and the BUILTIN\\Administrators group and its members have write access.

> [!NOTE]  
> - This message provides information only.
> - The list of users in this message might include users that belong to the local Administrators group. These users have valid reasons for having permissions on the C:\ProgramData\ssh folder.
> - The list of security principals that follows "granted to the following users:" (in the preceding example, "NT AUTHORITY\\Authenticated User) changes based on the actual folder permissions.

Updates that fix the problem as described in this method include updates that were released on and after March 11, 2025. This update list includes the following Windows versions:

- [March 11, 2025 - KB5053598 (OS Build 26100.3476) - Microsoft Support](https://support.microsoft.com/topic/march-11-2025-kb5053598-os-build-26100-3476-a248e951-daef-43ad-aa10-0b99f551cec2) (Windows 11 24H2)

- [March 11, 2025 - KB5053602 (OS Builds 22621.5039 and 22631.5039) - Microsoft Support](https://support.microsoft.com/topic/march-11-2025-kb5053602-os-builds-22621-5039-and-22631-5039-19284fef-ba57-440b-a027-2d5eeecb73fa) (Windows 11 23H2)

- [Windows 11, version 22H2 update history - Microsoft Support](https://support.microsoft.com/topic/windows-11-version-22h2-update-history-ec4229c3-9c5f-4e75-9d6d-9025ab70fcce) (Windows 11 22H2)

- [March 11, 2025 - KB5053598 (OS Build 26100.3476) - Microsoft Support](https://support.microsoft.com/topic/march-11-2025-kb5053598-os-build-26100-3476-a248e951-daef-43ad-aa10-0b99f551cec2) (Windows Server 2025)

- [March 11, 2025 - KB5053599 (OS Build 25398.1486) - Microsoft Support](https://support.microsoft.com/topic/march-11-2025-kb5053599-os-build-25398-1486-5be9fa07-cff3-4b15-95e9-a917e11ec1b0) (Windows Server 23H2)

- [March 11, 2025 - KB5053603 (OS Build 20348.3328) - Microsoft Support](https://support.microsoft.com/topic/march-11-2025-kb5053603-os-build-20348-3328-1f927b68-5c90-45d7-abd3-3c973873b8f8) (Windows Server 2022)

- [March 11, 2025 - KB5053596 (OS Build 17763.7009) - Microsoft Support](https://support.microsoft.com/topic/march-11-2025-kb5053596-os-build-17763-7009-d6bd4320-de45-4d63-ad47-b7c4789421c4) (Windows Server 2019)
