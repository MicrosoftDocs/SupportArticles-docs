---
title: Adding a highly available cluster error 444
description: Fixes an issue in which you can't add a System Center 2012 Virtual Machine Manager highly available cluster and receive error 444.
ms.date: 04/09/2024
ms.reviewer: wenca, jeffpatt, alvinm
---
# Error 444 when adding a System Center 2012 Virtual Machine Manager highly available cluster

This article fixes an issue in which you you can't add a System Center 2012 Virtual Machine Manager highly available cluster and receive error 444.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2679658

## Symptoms

When you attempt to add a cluster in which System Center 2012 Virtual Machine Manager (VMM) is hosted as a highly available resource, the job fails and returns the following error:

> Error (444)  
> %ComputerName% is a VMM management server. A VMM management server cannot be associated with another VMM management server.  
>
> Recommended Action  
> Uninstall the VMM management server from %ComputerName% using Add or Remove Programs on %ComputerName% and try the operation again.

An ETL trace (carmine trace) will show an error similar to the following:

> [7068] 1B9C.16A8::08/30-03:28:22.863#19:Task.cs(248): Task failed error AMCannotAssociateVMMServer (444) with exception Microsoft.VirtualManager.Utils.CarmineException: server.contoso.com is a Virtual Machine Manager server. A Virtual Machine Manager server cannot be associated with another Virtual Machine Manager server.  
> [7068] Uninstall the Virtual Machine Manager server from server.contoso.com using Add or Remove Programs on server.contoso.com and try the operation again.  
> [7068]    at Microsoft.VirtualManager.Engine.Adhc.BaseAgentAccessor.Associate(Boolean takeOwnership, SecureCredential savedCredential, String& certificate) in d:\bt\52\private\product\engine\ADHC\Operations\Agent\AgentAccessorBase.cs:line 136  
> [7068]    at Microsoft.VirtualManager.Engine.Adhc.BaseAgentAccessor.Associate(Boolean takeOwnership, String& certificate) in d:\bt\52\private\product\engine\ADHC\Operations\Agent\AgentAccessorBase.cs:line 70  
> [7068]    at Microsoft.VirtualManager.Engine.Adhc.AddAgentTask.InstallAgentIfNeeded() in d:\bt\52\private\product\engine\ADHC\Operations\Agent\AgentTaskCommon.cs:line 335  
> [7068]    at Microsoft.VirtualManager.Engine.Adhc.AddHostAgentSubtask.SubtaskThreadFunction() in d:\bt\52\private\product\engine\ADHC\Operations\Agent\AddHostAgentSubtask.cs:line 71  
> [7068]    at Microsoft.VirtualManager.Engine.Adhc.AddAgentTask.InstallAgent() in d:\bt\52\private\product\engine\ADHC\Operations\Agent\AgentTaskCommon.cs:line 173  
> [7068]    at Microsoft.VirtualManager.Engine.Adhc.AddAgentTask.RunSubtask() in d:\bt\52\private\product\engine\ADHC\Operations\Agent\AgentTaskCommon.cs:line 135  
> [7068]    at Microsoft.VirtualManager.Engine.TaskRepository.SubtaskBase.Run() in d:\bt\52\private\product\engine\TaskRepository\SubtaskBase.cs:line 491  
> [7068]    at Microsoft.VirtualManager.Engine.Adhc.AddHostSubtask.InstallAgent(Host lockedDbHost) in d:\bt\52\private\product\engine\ADHC\Operations\AddHostSubtask.cs:line 384  
> [7068]    at Microsoft.VirtualManager.Engine.Adhc.AddHyperVHostSubtask.RunDeploymentSubtasks(Host lockedDbHost) in d:\bt\52\private\product\engine\ADHC\Operations\AddHyperVHostSubtask.cs:line 180  
> [7068]    at Microsoft.VirtualManager.Engine.Adhc.AddHostSubtask.RunSubtask() in d:\bt\52\private\product\engine\ADHC\Operations\AddHostSubtask.cs:line 371  
> [7068]    at Microsoft.VirtualManager.Engine.TaskRepository.SubtaskBase.Run() in d:\bt\52\private\product\engine\TaskRepository\SubtaskBase.cs:line 491  
> [7068]    at Microsoft.VirtualManager.Engine.TaskRepository.Task\`1.SubtaskRun(Object state) in d:\bt\52\private\product\engine\TaskRepository\Task.cs:line 238  
> [7068] *** Carmine error was: AMCannotAssociateVMMServer (444)  
> [7068] *** server.contoso.com ** |TaskID=ACEEAB52-CC21-449D-B1A8-730777AB5511  
> [7068] 1B9C.16A8::08/30-03:28:22.863#04:CarmineObjectLock.cs(372): Releasing all locks for task aceeab52-cc21-449d-b1a8-730777ab5511|TaskID=ACEEAB52-CC21-449D-B1A8-730777AB5511  
> [7068] 1B9C.10EC::08/30-03:28:22.863#21:EventClientConnection.cs(242): Server session uuid:bdde32f8-5d7a-4b99-bc4f-242dd5526760;id=4 - Sending 6 events  
> [7068] 1B9C.1140::08/30-03:28:22.879#19:Task.cs(248): Task failed error AMCannotAssociateVMMServer (444) with exception Microsoft.VirtualManager.Utils.CarmineException: server.contoso.com is a Virtual Machine Manager server. A Virtual Machine Manager server cannot be associated with another Virtual Machine Manager server.  
> [7068] Uninstall the Virtual Machine Manager server from server.contoso.com using Add or Remove Programs on server.contoso.com and try the operation again.  
> [7068]    at Microsoft.VirtualManager.Engine.Adhc.BaseAgentAccessor.Associate(Boolean takeOwnership, SecureCredential savedCredential, String& certificate) in d:\bt\52\private\product\engine\ADHC\Operations\Agent\AgentAccessorBase.cs:line 136  
> [7068]    at Microsoft.VirtualManager.Engine.Adhc.BaseAgentAccessor.Associate(Boolean takeOwnership, String& certificate) in d:\bt\52\private\product\engine\ADHC\Operations\Agent\AgentAccessorBase.cs:line 70  
> [7068]    at Microsoft.VirtualManager.Engine.Adhc.AddAgentTask.InstallAgentIfNeeded() in d:\bt\52\private\product\engine\ADHC\Operations\Agent\AgentTaskCommon.cs:line 335  
> [7068]    at Microsoft.VirtualManager.Engine.Adhc.AddHostAgentSubtask.SubtaskThreadFunction() in d:\bt\52\private\product\engine\ADHC\Operations\Agent\AddHostAgentSubtask.cs:line 71  
> [7068]    at Microsoft.VirtualManager.Engine.Adhc.AddAgentTask.InstallAgent() in d:\bt\52\private\product\engine\ADHC\Operations\Agent\AgentTaskCommon.cs:line 173  
> [7068]    at Microsoft.VirtualManager.Engine.Adhc.AddAgentTask.RunSubtask() in d:\bt\52\private\product\engine\ADHC\Operations\Agent\AgentTaskCommon.cs:line 135  
> [7068]    at Microsoft.VirtualManager.Engine.TaskRepository.SubtaskBase.Run() in d:\bt\52\private\product\engine\TaskRepository\SubtaskBase.cs:line 491  
> [7068]    at Microsoft.VirtualManager.Engine.Adhc.AddHostSubtask.InstallAgent(Host lockedDbHost) in d:\bt\52\private\product\engine\ADHC\Operations\AddHostSubtask.cs:line 384  
> [7068]    at Microsoft.VirtualManager.Engine.Adhc.AddHyperVHostSubtask.RunDeploymentSubtasks(Host lockedDbHost) in d:\bt\52\private\product\engine\ADHC\Operations\AddHyperVHostSubtask.cs:line 180  
> [7068]    at Microsoft.VirtualManager.Engine.Adhc.AddHostSubtask.RunSubtask() in d:\bt\52\private\product\engine\ADHC\Operations\AddHostSubtask.cs:line 371  
> [7068]    at Microsoft.VirtualManager.Engine.TaskRepository.SubtaskBase.Run() in d:\bt\52\private\product\engine\TaskRepository\SubtaskBase.cs:line 491  
> [7068]    at Microsoft.VirtualManager.Engine.TaskRepository.Task\`1.SubtaskRun(Object state) in d:\bt\52\private\product\engine\TaskRepository\Task.cs:line 238  
> [7068] *** Carmine error was: AMCannotAssociateVMMServer (444)  
> [7068] *** server.contoso.com ** |TaskID=185DA4F0-E07E-4712-8599-FF9A91AD5EF4  
> [7068] 1B9C.0B30::08/30-03:28:22.879#19:Task.cs(248): Task failed error AMCannotAssociateVMMServer (444) with exception Microsoft.VirtualManager.Utils.CarmineException: server.contoso.com is a Virtual Machine Manager server. A Virtual Machine Manager server cannot be associated with another Virtual Machine Manager server.  
> [7068] Uninstall the Virtual Machine Manager server from server.contoso.com using Add or Remove Programs on server.contoso.com and try the operation again.  
> [7068]    at Microsoft.VirtualManager.Engine.Adhc.BaseAgentAccessor.Associate(Boolean takeOwnership, SecureCredential savedCredential, String& certificate) in d:\bt\52\private\product\engine\ADHC\Operations\Agent\AgentAccessorBase.cs:line 136  
> [7068]    at Microsoft.VirtualManager.Engine.Adhc.BaseAgentAccessor.Associate(Boolean takeOwnership, String& certificate) in d:\bt\52\private\product\engine\ADHC\Operations\Agent\AgentAccessorBase.cs:line 70  
> [7068]    at Microsoft.VirtualManager.Engine.Adhc.AddAgentTask.InstallAgentIfNeeded() in d:\bt\52\private\product\engine\ADHC\Operations\Agent\AgentTaskCommon.cs:line 335  
> [7068]    at Microsoft.VirtualManager.Engine.Adhc.AddHostAgentSubtask.SubtaskThreadFunction() in d:\bt\52\private\product\engine\ADHC\Operations\Agent\AddHostAgentSubtask.cs:line 71  
> [7068]    at Microsoft.VirtualManager.Engine.Adhc.AddAgentTask.InstallAgent() in d:\bt\52\private\product\engine\ADHC\Operations\Agent\AgentTaskCommon.cs:line 173  
> [7068]    at Microsoft.VirtualManager.Engine.Adhc.AddAgentTask.RunSubtask() in d:\bt\52\private\product\engine\ADHC\Operations\Agent\AgentTaskCommon.cs:line 135  
> [7068]    at Microsoft.VirtualManager.Engine.TaskRepository.SubtaskBase.Run() in d:\bt\52\private\product\engine\TaskRepository\SubtaskBase.cs:line 491  
> [7068]    at Microsoft.VirtualManager.Engine.Adhc.AddHostSubtask.InstallAgent(Host lockedDbHost) in d:\bt\52\private\product\engine\ADHC\Operations\AddHostSubtask.cs:line 384  
> [7068]    at Microsoft.VirtualManager.Engine.Adhc.AddHyperVHostSubtask.RunDeploymentSubtasks(Host lockedDbHost) in d:\bt\52\private\product\engine\ADHC\Operations\AddHyperVHostSubtask.cs:line 180  
> [7068]    at Microsoft.VirtualManager.Engine.Adhc.AddHostSubtask.RunSubtask() in d:\bt\52\private\product\engine\ADHC\Operations\AddHostSubtask.cs:line 371  
> [7068]    at Microsoft.VirtualManager.Engine.TaskRepository.SubtaskBase.Run() in d:\bt\52\private\product\engine\TaskRepository\SubtaskBase.cs:line 491  
> [7068]    at Microsoft.VirtualManager.Engine.TaskRepository.Task\`1.SubtaskRun(Object state) in d:\bt\52\private\product\engine\TaskRepository\Task.cs:line 238  
> [7068] *** Carmine error was: AMCannotAssociateVMMServer (444)  
> [7068] *** server.contoso.com ** |TaskID=F8F74A44-9FD5-4643-ABA9-9CAA60F4C9BE

## Cause

This is by design. System Center 2012 Virtual Machine Manager was never intended to manage itself in highly available mode as a cluster host.

## Resolution

To work around this situation, create a cluster using virtual machines within a Hyper-V cluster and install highly available Virtual Machine Manager (HAVMM) in them. Once this is done, add the Hyper-V cluster in which these virtual machines are running into the HAVMM.
