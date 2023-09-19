---
title: "Scenario Guide: GPO to map network drive doesn't apply as expected"
description: This article introduces a troubleshooting scenario in which network drive can't be mapped by using GPO.
author: Deland-Han
ms.author: delhan
ms.topic: troubleshooting
ms.date: 09/20/2023
ms.prod: windows-client
ms.technology: windows-client-troubleshooter
ms.custom: sap:windows-troubleshooters, csstroubleshoot
---
# Scenario Guide: GPO to map network drive doesn't apply as expected

This scenario guide explains how to use TSS to collect data to troubleshoot the issue in which GPO to map network drive doesn't apply as expected.

## Troubleshooting guide

Before you proceed, refer [Applying Group Policy troubleshooting guidance](../../windows-server/group-policy/applying-group-policy-troubleshooting-guidance.md).

## Environment

- Domain name: `contoso.com`
- Active Directory sites: four Sites (two domain controllers per site) (Phoenix, London, Tokyo and Mumbai)
- Number of the domain controllers: eight
- Domain controller operating system: Windows Server 2019
- Client machine operating system: Windows 11, version 22H2

:::image type="content" source="media/scenario-guide-gpo-to-map-network-drive-doesn-t-apply-as-expected/diagram-of-environment-topology.png" alt-text="The diagram of the topology of the environment." border="true":::

## In this scenario

You deploy a GPO named "Mapped drives" by using Group policy preferences mapped drives extension. The GPO is used to map drive Z on client computers. See the following screenshot:

:::image type="content" source="media/scenario-guide-gpo-to-map-network-drive-doesn-t-apply-as-expected/screenshot-of-the-group-policy-result.png" alt-text="The screenshot of the group policy result." border="true":::

The GPO has worked before. Since several days ago, drive Z is no longer mapped.
Besides, you observe the following symptoms:

- You can manually map the drive by using the net use command.
- When you run GPRESULT /h, the output indicates that the GPO "Mapped drives" is in the applied list.
  
  :::image type="content" source="media/scenario-guide-gpo-to-map-network-drive-doesn-t-apply-as-expected/screenshot-of-the-applied-gpos.png" alt-text="The screenshot of the applied GPOs." border="true":::
  
  :::image type="content" source="media/scenario-guide-gpo-to-map-network-drive-doesn-t-apply-as-expected/screenshot-shows-gpo-is-applied-successfully.png" alt-text="The screenshot that shows the GPO is applied successfully." border="true":::

- The GPO is set up with default settings and there are no changes made to the GPO from the perspective of Security filtering, WMI filter or set up any **Deny** permissions.

## Troubleshooting

First, collect the following data for troubleshooting. Because we need to trace the login/sign-in, we need to perform the following tasks as a local administrator or any other user account with local administrator credentials.

1. Download [TSS](https://aka.ms/gettss), extract the ZIP file to a folder: C:\temp.
2. Open an elevated PowerShell command and run the command:

   ```powershell
   Set-ExecutionPolicy unrestricted
   ```

   :::image type="content" source="media/scenario-guide-gpo-to-map-network-drive-doesn-t-apply-as-expected/screenshot-of-set-executionpolicy-command-result.png" alt-text="The screenshot of Set-ExecutionPolicy command result." border="true":::

3. Go to c:\temp\TSS, where you have extracted the TSS Zip file.
4. Run `.\TSS.ps1 -Start -Scenario ADS_GPOEx -Procmon`, Accept the agreement and wait until the TSS starts collecting data.

   :::image type="content" source="media/scenario-guide-gpo-to-map-network-drive-doesn-t-apply-as-expected/screenshot-of-the-tss-tool.png" alt-text="The screenshot of the TSS tool." border="true":::

5. Switch user, and then sign in with the user account who doesn't see the drive Z getting mapped.
6. Once the sign-in is successful, open a command prompt and run `gpresult /h appliedgpo.htm`. Confirm that the GPO "Mapped drives" is in the applied list.
7. Switch user again, and then sign in with the user account who has started the TSS Logging. Press Y.
8. TSS will stop collecting data and the collected data will be located in the C:\MSDATA folder as a Zip file or folder with the name TSS_\<Machinename\>_\<Time\>_ADS_GPOEx.

For more information about TSS, see [Introduction to TroubleShootingScript toolset (TSS)](introduction-to-troubleshootingscript-toolset-tss.md).

## Data Analysis

Go to the *c:\msdata* folder where TSS has saved all the reports and extract the contents of the ZIP file. Review the file with the name <Client_machinename>-<Time>_Microsoft-Windows-GroupPolicy-Operational.evtx.

### Starting event: 4001

:::image type="content" source="media/scenario-guide-gpo-to-map-network-drive-doesn-t-apply-as-expected/screenshot-of-the-event-id-4001.png" alt-text="The screenshot of the event ID 4001." border="true":::

### Event: 5017 showing us the Users OU

The GPO "Mapped drives" is linked to the User OU

:::image type="content" source="media/scenario-guide-gpo-to-map-network-drive-doesn-t-apply-as-expected/screenshot-of-the-event-id-5017.png" alt-text="The screenshot of the event ID 5017." border="true":::

### Event: 5312 showing the list of applicable Group Policy objects

We do see that the GPO "Mapped drive" is in the applicable list.

:::image type="content" source="media/scenario-guide-gpo-to-map-network-drive-doesn-t-apply-as-expected/screenshot-of-the-event-id-5312.png" alt-text="The screenshot of the event ID 5312." border="true":::

### Event: 4016 showing that the Group policy drive maps extension processed and successful

:::image type="content" source="media/scenario-guide-gpo-to-map-network-drive-doesn-t-apply-as-expected/screenshot-of-the-event-id-4016.png" alt-text="The screenshot of the event ID 4016." border="true":::

### Group Policy preferences tracing

From the Group policy operational logs, we observe that the group policy was processed and the group policy preferences were applied successfully. In addition to the above we could also review the group policy preferences logging/tracing collected by the TSS tool.

Group policy preferences tracing is an extra logging that we can enable for any group policy preferences client-side extension. The TSS GPOEx tracing is enabled by default.

> [!NOTE]
> If you wish to manually enable then follow the article [Enabling Group Policy Preferences Debug Logging using the RSAT](https://techcommunity.microsoft.com/t5/ask-the-directory-services-team/enabling-group-policy-preferences-debug-logging-using-the-rsat/ba-p/395555).

In \<Clientmachinename\>_\<Date_Time\>_GPPREF_User.txt, we observe that the GPP Mapped drives extension is starting the processing:

> [!NOTE]
> The analysis only contains snippets of troubleshooting data and not the full analysis.

```log
yyyy-mm-dd hh:mm::ss:sss [pid=0x3134,tid=0x4fc] Entering ProcessGroupPolicyExDrives()
yyyy-mm-dd hh:mm::ss:sss [pid=0x3134,tid=0x4fc] SOFTWARE\Policies\Microsoft\Windows\Group Policy\{5794DAFD-BE60-433f-88A2-1A31939AC01F}
```

Group policy mapped drives extension identified a GPO that is configured with this extension and the name is "Mapped-drive":

```log
yyyy-mm-dd hh:mm::ss:sss [pid=0x3134,tid=0x4fc] GPC : LDAP://CN=User,cn={6D6CECFD-C75A-43FA-8C32-0B5963E42C5B},cn=policies,cn=system,DC=contoso,DC=com
yyyy-mm-dd hh:mm::ss:sss [pid=0x3134,tid=0x4fc] GPT : \\contoso.com\SysVol\contoso.com\Policies\{6D6CECFD-C75A-43FA-8C32-0B5963E42C5B}\User
yyyy-mm-dd hh:mm::ss:sss [pid=0x3134,tid=0x4fc] GPO Display Name : Mapped-Drive
yyyy-mm-dd hh:mm::ss:sss [pid=0x3134,tid=0x4fc] GPO Name : {6D6CECFD-C75A-43FA-8C32-0B5963E42C5B}
```

We observe that the drive Z is successfully mapped:

```log
yyyy-mm-dd hh:mm::ss:sss [pid=0x3134,tid=0x4fc] Starting class <Drive> - Z:.
yyyy-mm-dd hh:mm::ss:sss [pid=0x3134,tid=0x4fc] Policy is not flagged for removal.
yyyy-mm-dd hh:mm::ss:sss [pid=0x3134,tid=0x4fc] Completed class <Drive> - Z:.
yyyy-mm-dd hh:mm::ss:sss [pid=0x3134,tid=0x4fc] Completed class <Drives>.
yyyy-mm-dd hh:mm::ss:sss [pid=0x3134,tid=0x4fc] EVENT : The user 'Z:' preference item in the 'Mapped-Drive {6D6CECFD-C75A-43FA-8C32-0B5963E42C5B}' Group Policy Object applied successfully.
yyyy-mm-dd hh:mm::ss:sss [pid=0x3134,tid=0x4fc] Completed class <Drive> - Z:.
yyyy-mm-dd hh:mm::ss:sss [pid=0x3134,tid=0x4fc] Completed class <Drives>
```

## Use procmon to find the process removing drive Z

At this moment, we know that the group policy preferences are applied but drive Z isn't visible. We can manually map the drive, but the drive is deleted during sign-in or logon. Therefore, there are some other settings that delete the drive Z on the computer during logon.

Next we need analyze the procmon trace to observe what is deleting the Mapped drive. The TSS tool also collects the procmon trace with the `-Procmon` switch that we used to collect the data. Open the file: \<Clientmachinename\>_\<date_time\>_Procmon_0.pml.

The procmon trace can be overwhelming. Follow these steps to set up a filter to view the data. The filter can be used to troubleshoot any mapped drives related issues.

1. Open the file Procmon_0.pml.
2. Select on **Filter** - **Filter**
3. Add the filter: **Detail** - Contains - *Z:*.

   :::image type="content" source="media/scenario-guide-gpo-to-map-network-drive-doesn-t-apply-as-expected/screenshot-of-the-process-monitor-filter.png" alt-text="The screenshot of the process monitor filter." border="true":::

4. The output of the filter shows two process: **cmd.exe** and **net.exe**.

   :::image type="content" source="media/scenario-guide-gpo-to-map-network-drive-doesn-t-apply-as-expected/screenshot-of-the-filter-result-that-show-cmd-exe-and-net-exe.png" alt-text="The screenshot of the filter result that shows cmd.exe and net.exe." border="true":::

5. Double-click the net.exe and go to the **Process** tab that includes the following parameters:

   - Command line: The deletion operation of the mapped drive.
   - Parent PID: Parent process of net.exe is 13436.
   - User: The name of the User in who's context this process was run and in our example it's the user account itself.

   :::image type="content" source="media/scenario-guide-gpo-to-map-network-drive-doesn-t-apply-as-expected/screenshot-of-the-process-tab-of-the-event-properties-in-procmon.png" alt-text="The screenshot of the Process tab of the event properties in Procmon." border="true":::

Then, set up another filter to identify who spawned net.exe using the Parent process filter.

1. Go to **Filter** - **Filter** and select **RESET**.
2. Now apply the filter below using the PID of the parent.

   :::image type="content" source="media/scenario-guide-gpo-to-map-network-drive-doesn-t-apply-as-expected/filter-the-trace-by-using-the-pid-is-13436-condition.png" alt-text="Filter the trace by using the PID is 13436 condition." border="true":::

We observe that the PID is cmd.exe and it appears its processing a GPO with below parameters:

- Command line: `C:\Windows\system32\cmd.exe /c "\contoso.com\SysVol\contoso.com\Policies{E347CA05-D21D-433D-9BCA-2FE555336749}\User\Scripts\Logon\deletedrives.bat"`
- Parent PID: Parent process of cmd.exe is 14900
- User: The name of the User in who's context this process was run and in our example, it’s the User itself.

:::image type="content" source="media/scenario-guide-gpo-to-map-network-drive-doesn-t-apply-as-expected/screenshot-of-the-process-tab-of-the-process-13436.png" alt-text="The screenshot of the Process tab of the process 13436." border="true":::

Now, use the same mechanism and use the PID Filter again by going to **Filter** - **Filter** and then select on **RESET** and apply the below filter:

:::image type="content" source="media/scenario-guide-gpo-to-map-network-drive-doesn-t-apply-as-expected/screenshot-of-the-process-tab-of-the-process-14900.png" alt-text="The screenshot of the Process tab of the process 14900." border="true":::

We observe that GPScrpit.exe is the parent process of the cmd.exe process. Using this hint, we observe that there's a Group Policy script that is deleting the mapped drive.

:::image type="content" source="media/scenario-guide-gpo-to-map-network-drive-doesn-t-apply-as-expected/screenshot-of-the-process-14900-the-group-policy-script-application-process.png" alt-text="The screenshot of the process 14900, which is the Group Policy Script Application process." border="true":::

## Summary

1. Net.exe is deleting the mapped drive and its parent process is cmd.exe. The following command is executed:

   ```console
   net use z: /delete
   ```

2. CMD.exe is processing a .bat file deletedrives.bat and its parent process is Gpscript.exe.

   ```console
   C:\Windows\system32\cmd.exe /c "\contoso.com\SysVol\contoso.com\Policies{E347CA05-D21D-433D-9BCA-2FE555336749}\User\Scripts\Logon\deletedrives.bat"
   ```

3. GPScript.exe is the process that runs during logon to process any logon scripts.

We need to identify the GPO that contains this Logon script. Here are two methods.

### Method 1: Gpresult /h output collected during log collection

:::image type="content" source="media/scenario-guide-gpo-to-map-network-drive-doesn-t-apply-as-expected/screenshot-of-the-gpresult-h-output.png" alt-text="The screenshot of the Gpresult /h output." border="true":::

### Method 2: Using group policy management snap-in (GPMC.msc)

1. Open *GPMC.msc* on a Domain controller or a machine where you have the snap-in installed.
2. Right click the domain and select **Search**.
3. In the search items, select GUID, and then enter the GPO GUID that we found in the command of cmd.exe.

:::image type="content" source="media/scenario-guide-gpo-to-map-network-drive-doesn-t-apply-as-expected/search-gpo-by-guid.png" alt-text="Search GPO by GUID." border="true":::

We identified that the **DomainWideSettings** GPO has the logon script.

:::image type="content" source="media/scenario-guide-gpo-to-map-network-drive-doesn-t-apply-as-expected/find-the-gpo-that-caused-the-issue.png" alt-text="Find the GPO that caused the issue." border="true":::

If you don't want the **DomainWideSettings** GPO to delete the mapped drive, use one of these methods:

1. Remove the Logon Scripts from the GPO DomainWideSettings as this GPO used to configure other Domain wide settings.
2. Unlink the GPO DomainWideSettings completely.
3. Set a "Block Policy Inheritance" on the Users OU where the User object located.
4. Set a Deny "Apply GPO" for the Users group on the GPO DomainWideSettings.
