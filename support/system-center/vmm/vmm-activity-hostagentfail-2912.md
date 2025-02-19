---
title: HostAgentFail (2912) error in SCVMM activities
description: Describes a problem in which an error occurs when any System Center Virtual Machine Manager activity that involves moving data fails. Provides a resolution.
ms.date: 04/09/2024
ms.reviewer: wenca, ctimon
---
# HostAgentFail (2912) error when any SCVMM activity that involves moving data fails

This article fixes an issue in which a HostAgentFail (2912) error occurs when any System Center Virtual Machine Manager activity that involves moving data fails.

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Virtual Machine Manager, System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2928972

## Symptoms

Any Microsoft System Center Virtual Machine Manager (VMM) activity (such as a copy routine) that involves moving data that includes files such as .vhd, .vhdx, and .iso files fails as soon as the job begins to move data.

The following VMM trace example shows a Background Intelligent Transfer Service (BITS) copy job beginning. First, locate the exception (**HostAgentFail (2912); HR: 0x80041001**) at the bottom of the stack, and then start examining the events before the exception. The first line shows that BITS is starting a copy job: **at Microsoft.VirtualManager.Engine.Deployment.BitDeployer.Copy()**.

> *timedate*,0x09C4,0x0994,4,BitsDeployer.cs,506,0x00000000, Caught Exception,{00000000-0000-0000-0000-000000000000},1,  
> *timedate*,0x09C4,0x0994,4,BitsDeployer.cs,506,0x00000000,"Microsoft.Carmine.WSManWrappers.WSManProviderException: An internal error has occurred trying to contact an agent on the Server.Domain.com server.  
> 17993 Ensure the agent is installed and running. Ensure the WS-Management service is installed and running; then restart the agent.
> at Microsoft.Carmine.WSManWrappers.ErrorContextParameterHelper.ThrowTranslatedCarmineException(ErrorInfo ei; Exception ex)  
> at Microsoft.Carmine.WSManWrappers.WsmanAPIWrapper.RetrieveUnderlyingWMIErrorAndThrow(SessionCacheElement sessionElement; COMException ce)  
> at Microsoft.Carmine.WSManWrappers.WsmanAPIWrapper.Enumerate(String url; String filter; Type type)  
> at Microsoft.Carmine.WSManWrappers.WSManRequest`1.Enumerate(String url; String wqlQuery)  
> at Microsoft.VirtualManager.Engine.Deployment.NativeDeploymentUtils.IsBitsRemoteApiAvailable(WSManConnectionParameters connectionParams; BitsRemoteApi remoteApi)  
> at Microsoft.VirtualManager.Engine.Deployment.LANAcceleratorFactory.GetDeploymentClientJob(WSManConnectionParameters connParams; WSManConnectionParameters remotePeerConnParams; String sourceFileName; String targetFilename; UInt16 port; Boolean privacy; UInt32 flags; String sessionID; Boolean resetJob)  
> at Microsoft.VirtualManager.Engine.Deployment.BITSDeployer.CreateClientJob(DeploymentFile file; CLIENT_JOB_TYPE clientJobType; WSManConnectionParameters clientConnection; WSManConnectionParameters serverConnection; UInt16 serverTcpPort; Boolean clientPrivacy; Boolean startAfresh)  
> at Microsoft.VirtualManager.Engine.Deployment.BitDeployer.Copy()  
> *** Carmine error was: HostAgentFail (2912); HR: 0x80041001

## Cause

This problem occurs when BITS has a job suspended on the VMM server or the host to which data is being transferred. These jobs must be removed to enable other BITS jobs to run.

## Resolution

To resolve this problem, follow these steps on the VMM server and on any hosts to which data is being moved.

> [!NOTE]
> You can safely ignore any messages that refer to the command being deprecated.

1. Open an elevated command prompt.
2. Type the following command, and then press Enter:

   ```console
   bitsadmin /list /allusers
   ```

3. Find the number of jobs that are suspended. Each job begins with a GUID.
4. Cancel each suspended job. To do this, type the following command, and then press Enter:

   ```console
   bitsadmin /cancel {GUID}
   ```

   > [!NOTE]
   > The placeholder GUID represents the BITS job that is suspended.

5. Repeat step 4 for all BITS jobs.
6. Type the following command, and then press Enter. This action makes sure that there no more jobs are suspended.

   ```console
   bitsadmin /list /allusers
   ```

## More Information

Windows Update, Java Updates, and other applications use BITS to transfer data. Suspended BITS jobs may occur because of a previous failed VMM action or because of other applications.

[Troubleshoot VMM: BITS Troubleshooting](https://social.technet.microsoft.com/wiki/contents/articles/9058.troubleshoot-vmm-bits-troubleshooting.aspx)
