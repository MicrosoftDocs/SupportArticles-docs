---
title: "Scenario Guide: Wallpaper GPO doesn't apply on some client computers"
description: This article introduces a troubleshooting scenario in which Wallpaper GPO doesn't apply on some client computers.
author: Deland-Han
ms.author: delhan
ms.topic: troubleshooting
ms.date: 09/20/2023
ms.prod: windows-client
ms.technology: windows-client-group-policy
ms.custom: sap:problems-applying-group-policy-objects-to-users-or-computers, csstroubleshoot
---
# Scenario Guide: Wallpaper GPO doesn't apply on some client computers

This scenario guide explains how to use TSS to collect data to troubleshoot the issue in which wallpaper Group Policy Object (GPO) does not apply on some client computers.

## How Group Policy is applied on client computers

1. Group Policy service on the client computer enumerates the distinguished name (DN) of the user account.
2. Group Policy service enumerates the **GPLINK** and **GPOptions** attributes where the user account resides, in the order of local GPO, site GPO, domain and organizational unit (OU).
3. Group Policy service makes a list of GPOs to apply or deny.

## Troubleshooting guide

Before you proceed, refer [Applying Group Policy troubleshooting guidance](../../windows-server/group-policy/applying-group-policy-troubleshooting-guidance.md).

## Environment

- Domain name: `contoso.com`
- Active Directory sites: Four sites (two domain controllers per site) (Phoenix, London, Tokyo and Mumbai)
- Number of the domain controllers: 8
- Domain controller operating system: Windows Server 2019
- Client computer operating system: Windows 11, version 22H2

:::image type="content" source="media/scenario-guide-wallpaper-gpo-does-not-apply-on-some-client-computers/diagram-of-environment-topology.png" alt-text="The diagram of the topology of the environment." border="true":::

## In this scenario

You have created a new GPO on the Phoenix site named "Wallpaper-GPO-Tokyo" and linked to an OU named "Tokyo".

The GPO applies the following settings:

- Path: User Configuration | Administrative templates | Desktop | Desktop | Desktop Wallpaper
- GPO Setting: Enabled
- Wallpaper location: \contoso.com\netlogon\home.jpg
- Wallpaper style: Fit

:::image type="content" source="media/scenario-guide-wallpaper-gpo-does-not-apply-on-some-client-computers/screenshot-of-the-gpo-settings.png" alt-text="The screenshot of the GPO settings." border="false":::

When a user signs in by using a client computer on the Tokyo site, the GPO isn't applied. However, if the same user signs in from a client computer on the Phoenix site, the GPO applies fine.

Besides, you observe the following symptoms:

1. No errors when you run `gpupdate /force` on the working or the failing client computers.
2. Old GPOs are applied and only this GPO isn't applied.

## Troubleshooting

First, we need to collect data on both a client computer in Phoenix and a client computer in Tokyo. Follow these steps on each computer:

1. Download [TSS](https://aka.ms/gettss), extract the ZIP file to a folder: C:\temp. Create the folder if it does not exist.
2. Sign-in with the user account who is experiencing the issue.
3. Open an elevated PowerShell command and run the command:

   ```powershell
   Set-ExecutionPolicy unrestricted
   ```

   :::image type="content" source="media/scenario-guide-wallpaper-gpo-does-not-apply-on-some-client-computers/screenshot-of-the-set-executionpolicy-command-result.png" alt-text="The screenshot of Set-ExecutionPolicy command result." border="false":::

4. Go to c:\temp\TSS, where you have extracted the TSS Zip file.
5. Run `.\TSS.ps1 -Start -Scenario ADS_GPOEx`. Accept the agreement and wait until the TSS starts collecting data.

   :::image type="content" source="media/scenario-guide-wallpaper-gpo-does-not-apply-on-some-client-computers/screenshot-of-the-tss-tool.png" alt-text="The screenshot of the TSS tool." border="false":::

6. Open a normal command prompt as the user and run `gpupdate /force /target:user`
7. When the processing is complete, press "Y" on the PowerShell command where you're running TSS.

   :::image type="content" source="media/scenario-guide-wallpaper-gpo-does-not-apply-on-some-client-computers/screenshot-of-the-tss-tool-result.png" alt-text="The screenshot of the TSS tool result." border="false":::

8. TSS would stop collecting data and the collected data would be located in the C:\MSDATA folder as a Zip file or folder with the name TSS_\<Machinename\>_\<Time\>_ADS_GPOEx

For more information about TSS, see [Introduction to TroubleShootingScript toolset (TSS)](../windows-troubleshooters/introduction-to-troubleshootingscript-toolset-tss.md).

### Compare GPResult

On both computers, go to c:\msdata folder where TSS has saved all the reports and extract the contents of the ZIP file. Review the file with the name \<Clientmachinename\>_\<Time\>GPResult-H_Stop.html.

Go to the section of **User details**. The GPO in question "Wallpaper-GPO-Tokyo" is in the applied list on the Working machine and not present in the broken machine.

> [!NOTE]
> There are other GPO's like "Mapped-drives" and "Phoenix-SiteGPO" on the applied machines. However, those two GPOs are site level GPOs and would apply only when the group policy client detect the client machine is in Phoenix site. Therefore, they are not relevant to our scope of troubleshooting.

:::image type="content" source="media/scenario-guide-wallpaper-gpo-does-not-apply-on-some-client-computers/screenshot-of-the-gpresult-command-results.png" alt-text="The screenshot of the gpresult command results." border="true":::

### Compare event logs

Group Policy operational logs provide more information about the processing. Open both the GPO operational logs to compare the \<Machinename\>-Microsoft-Windows-GroupPolicy-Operational.evtx file from the TSS output.

> [!TIP]
> Group Policy start event ID is 4116 and Group Policy end event is 8005.

Order the event logs in the chronological order. Search for the event 4116 and walk some of the important events in the upward direction. The only difference when after reviewing the working and the failing client is that the failing client machine is getting its group policy from DC6.contoso.com in the Tokyo site.

:::image type="content" source="media/scenario-guide-wallpaper-gpo-does-not-apply-on-some-client-computers/screenshot-of-the-operational-event-logs.png" alt-text="The screenshot of the operational event logs." border="true":::

The event ID 5312 indicates that the group policy service detected that it has to process 5 GPOs on the working computer and 3 GPOs on the failing computer. As we already discussed, the Phoenix-SiteGPO and Mapped-Drive GPO are Phoenix site level GPOs and the only difference is that the "Wallpaper-GPO-Tokyo" GPO isn't getting applied.

## Summary

When we compare the event ID: 5312 from working and failing computers, we observe that the Group Policy client service didn't enumerate the "Wallpaper-GPO-Tokyo" when it connected to DC6.
There could be two Primary reasons for the above scenario:

1. Verify the scope of the GPO.
2. Active Directory Replication issue.

In this scenario guide, we confirmed that the scope of the GPO was correct. Additionally, we found out an Active directory replication issue due to a bad router that blocks RPC port to the Tokyo site. See [Active Directory replication error 1722: The RPC server is unavailable](../../windows-server/identity/replication-error-1722-rpc-server-unavailable.md).
