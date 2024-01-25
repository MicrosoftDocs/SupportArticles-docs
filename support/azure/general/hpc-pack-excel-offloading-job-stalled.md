---
title: HPC Pack Excel offloading job is stalled
description: HPC Pack Excel offloading job is stalled when you run the ConvertiblePricing_Complete.xlsb sample job.
ms.date: 10/18/2022
editor: v-jsitser
ms.reviewer: cargonz, dandchen, v-leedennis
ms.service: hpcpack
#Customer intent: As a Microsoft HPC Pack user, I want to resolve a stalled Excel offloading job so that I can successfully use an Excel workbook to run a job in an Azure cluster.
---
# HPC Pack Excel offloading job is stalled

This article discusses how to resolve a [Microsoft HPC Pack Excel offloading][offload-to-cluster] job that's stalled so that you can successfully use an Excel binary workbook (.xlsb) to run a job in an Azure high-performance computing (HPC) cluster.

## Symptoms

A sample HPC Pack Excel offloading job gets stuck while it's running, and Excel reports session-related errors. The report resembles the following error text:

> System.IO.IOException: Found unreadable content in workbook. Verify that \<filename>.xlsb can be opened manually. -->
>
> System.Runtime.InteropServices.COMException: Exception from HRESULT: 0x800A03EC
>
> at Microsoft.Office.Interop.Excel.Workbooks.Open(String Filename, Object UpdateLinks, Object ReadOnly, Object Format, Object Password, Object WriteResPassword, Object IgnoreReadOnlyRecommended, Object Origin, Object Delimiter, Object Editable, Object Notify, Object Converter, Object AddToMru, Object Local, Object CorruptLoad)
>
> at Microsoft.Hpc.Excel.ExcelDriver.OpenWorkbookInternal(String filePath, Boolean updateLinks, Boolean enableMacros, String password, String writeResPassword, Nullable`1 lastSaveDate)
>
> at Microsoft.Hpc.Excel.ExcelDriver.OpenWorkbook(String filePath, Boolean updateLinks, String password, String writeResPassword, Nullable`1 lastSaveDate)
>
> --- End of inner exception stack trace ---

## Cause

You aren't running an Excel workbook in a user interactive session on compute nodes.

## Solution

Set the correct job environment property in an Excel service registration file. Use the HPC_ATTACHTOSESSION or HPC_CREATECONSOLE environment variable. This lets the service hosts run in a user interactive session or console. On the head node, the Excel service registration file is in the *%CCP_HOME%ServiceRegistration* folder in a file that's named *Microsoft.Hpc.Excel.ExcelService_\<version>.config*.

To use HPC_ATTACHTOSESSION, create a Remote Desktop Protocol (RDP) session for the same RunAs user on the compute nodes. To use HPC_CREATECONSOLE, configure the compute nodes by using registry keys, and restart the nodes before you run the job.

We recommend that you use the console running mode in most scenarios. This is especially true if no interactive actions are necessary while the job is running. Console running mode also saves you the manual effort to set up RDP after a node restart. For more information about detailed node configurations, see [Run commands on compute nodes to enable the create console functionality][enable-create-console].

### Background

Typically, there are two modes that you can use to run an Excel offloading job. These modes let you choose to run your job either in a console or in a remote desktop session.

- HPC_CREATECONSOLE: Specifying this variable causes a console session to be created automatically when the job is started. You can set this variable to one of the following values.

  | Value | Effect |
  | - | - |
  | `True` | The HPC Node Manager service tries to create a console session by using the credentials of the job owner. Only one user per node can have a console session. If the job is successful, it runs in the console session. If the console session can't be created, the job fails. The Node Manager closes the console session at the end of the job. |
  | `Keep` | A new sign-in console session is created if none exists. Otherwise, the HPC Node Manager service attaches the job to the existing console session, and that console session isn't closed after the job finishes on the compute nodes. |

- HPC_ATTACHTOSESSION: Specifying this variable starts a job in an existing remote desktop session. This scenario is helpful if both of the following conditions are true:

  - You have an interactive program that you want to connect to the session.
  - You want to remotely view the program while it's running.

  You can set this variable to one of the following values.

  | Value | Effect |
  | - | - |
  | `True` | The HPC Job Scheduler service tries to start the job in a remote desktop session. If there's a remote desktop connection that's owned by the user who submitted the job, the job starts. If the job owner doesn't own a remote desktop session, the job fails. You can run the [qwinsta](/windows-server/administration/windows-commands/qwinsta) command at a command prompt to see a list of sessions that are currently active on your server. |
  | `Try` | The job tries to attach the session and runs even if it can't attach to the session. |

Job environment variables aren't set automatically. Therefore, you have to set them in the Excel service registration file. For more information about offload running modes, see [Job or task environment variables for console or remote desktop sessions][env-var-for-local-remote-console].

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

[offload-to-cluster]: /powershell/high-performance-computing/excel-offloading-to-azure-cluster
[env-var-for-local-remote-console]: /previous-versions/windows/it-pro/windows-hpc-server-2008R2/gg286970(v=ws.10)#job-or-task-environment-variables-for-console-or-remote-desktop-sessions
[enable-create-console]: /previous-versions/windows/it-pro/windows-hpc-server-2008R2/gg247477(v=ws.10)#run-commands-on-compute-nodes-to-enable-the-create-console-functionality
