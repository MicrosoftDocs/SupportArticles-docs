---
title: The APM feature causes a crash for the IIS application pool
description: Fixes an issue in which the Application Performance Monitoring feature in System Center 2016 Operations Manager agent causes a crash for the IIS application pool running under .NET Framework 2.0 runtime.
ms.date: 04/15/2024
---
# APM feature causes a crash for the IIS application pool running under .NET Framework 2.0 runtime

This article fixes an issue in which the Application Performance Monitoring (APM) feature in System Center 2016 Operations Manager agent causes a crash for the IIS application pool running under .NET Framework 2.0 runtime.

_Original product version:_ &nbsp; System Center 2016 Operations Manager  
_Original KB number:_ &nbsp; 4464228

## Symptom

The APM feature in System Center 2016 Operations Manager agent may cause a crash for the Internet Information Services (IIS) application pool running under .NET Framework 2.0 runtime.

## Cause

Several callbacks within APM code of System Center 2016 Operations Manager agent utilize memory allocation that's incompatible with .NET Framework 2.0 runtime and may cause an issue if this memory is later accessed in a certain way. Those particular modifications were added in System Center 2016 Operations Manager agent and are not present in System Center 2012 R2 Operations Manager agent.

## Workarounds

There are several workarounds for this issue:

- Application pool can be migrated to .NET Framework 4.0 runtime.
- System Center 2016 Operations Manager agent can be replaced with System Center 2012 R2 Operations Manager agent. It's forward-compatible with System Center 2016 Operations Manager server and APM feature will continue to work with the older bits.
- System Center 2016 Operations Manager agent can be reinstalled with the `NOAPM=1` switch in msiexec.exe setup command line, APM feature will be excluded from setup. For more information, see [To deploy the Operations Manager agent from the command line](/system-center/scom/manage-deploy-windows-agent-manually#to-deploy-the-operations-manager-agent-from-the-command-line).

## More information

For the latest information on this issue, see [Update on APM fix for agent crashing issue shipped in UR3](https://techcommunity.microsoft.com/t5/system-center-blog/update-on-apm-fix-for-agent-crashing-issue-shipped-in-ur3/ba-p/351820).
