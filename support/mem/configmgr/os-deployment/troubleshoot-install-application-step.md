---
title: Troubleshoot the Install Application task sequence step
description: Describes the Install Application task sequence step and how to troubleshoot common problems.
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# Troubleshoot the Install Application task sequence step in Configuration Manager

This guide helps you understand the **Install Application** task sequence step and troubleshoot common problems that may occur. This guide assumes that the Configuration Manager environment has already been installed and configured.

_Original product version:_ &nbsp; Configuration Manager current branch, Microsoft System Center 2012 Configuration Manager, Microsoft System Center 2012 R2 Configuration Manager  
_Original KB number:_ &nbsp; 18408

The [Install Application](/mem/configmgr/osd/understand/task-sequence-steps#BKMK_InstallApplication) task sequence step installs applications as part of the overall task sequence. This step can install a set of specified applications, or a set of applications that are specified by a dynamic list of task sequence variables. When this step is run, the application installation begins immediately without waiting for a policy polling interval.

## Overview

The **Install Application** step described in this article covers a single application install task. It can also be used to troubleshoot the installation of multiple applications based on a list.

When the **Install Application** step runs, the application checks the applicability of the requirement rules and detection method on the deployment types of the application. Based on the results of this check, the application installs the applicable deployment type. If a deployment type contains dependencies, the dependent deployment type is evaluated and installed as part of the **Install Application** step.

> [!NOTE]  
> Application dependencies aren't supported for stand-alone media.

## Step 1: Task Sequence Manager parses the task sequence XML and begins the Install Application task

Application installations in a task sequence have a lot in common with application installations outside of a task sequence. They both use Configuration Manager [compliance settings](/previous-versions/system-center/system-center-2012-R2/gg681958(v=technet.10)). But they don't function exactly the same. There are more components involved due to the nature of running a task sequence.

As the task sequence progresses, it maintains the status of tasks and the associated execution status using [task sequence environment variables](/previous-versions/system-center/system-center-2012-R2/hh273375(v=technet.10)). These built-in variables provide information about the environment where the task sequence is running. The values for these variables are available throughout the whole task sequence. These built-in variables are initialized before the **Install Application** step runs in the task sequence.

1. Task Sequence Manager sets the following global environment variables for the next instruction:

   - `_SMSTSCurrentActionName` to **Install Application**
   - `_SMSTSNexInstructionPointer` to the Instruction Pointer assigned to this task

   The following entries are logged in SMSTS.log:

   > 01-13-2016 17:56:35.510   TSManager    2176 (0x880)    Start executing an instruction. Instructionname: Install Application. Instruction pointer: 32  
   > 01-13-2016 17:56:35.510   TSManager    2176 (0x880)    Set a global environment variable _SMSTSCurrentActionName=Install Application  
   > 01-13-2016 17:56:35.510   TSManager    2176 (0x880)    Set a global environment variable _SMSTSNextInstructionPointer=32
2. Task Sequence Manager then saves the execution state of the task sequence and the environment (TSEnv.dat) to the local hard disk, as seen in SMSTS.log:

   > 01-13-2016 17:56:35.510    TSManager    2176 (0x880)    Successfully save execution state and environment to local hard disk
3. Task Sequence Manager starts the execution of the next instruction in the sequence, based on the execution history of the previous instruction and the next instruction pointer:

   > 01-13-2016 17:56:35.510   TSManager    2176 (0x880)    Start executing an instruction. Instructionname: Install Application. Instruction pointer: 32
4. Task Sequence Manager then sets local default variables for applications:

   > 01-13-201617:56:35.510    TSManager    2176 (0x880)    Set a local default variable OSDApp0Description  
   > 01-13-201617:56:35.510    TSManager    2176 (0x880)    Set a local default variable OSDApp0DisplayName  
   > 01-13-201617:56:35.510    TSManager    2176 (0x880)    Set a local default variable OSDApp0Name  
   > 01-13-201617:56:35.510    TSManager    2176 (0x880)    Set a local default variable OSDAppCount  
   > 01-13-201617:56:35.525    TSManager    2176 (0x880)    Set a global environment variable _SMSTSLogPath=C:\WINDOWS\CCM\Logs\SMSTSLog
5. Task Sequence Manager sets the command line for the application install (smsappinstall.exe) based on the task sequence XML policy that it has parsed, and begins executing it by calling smsappinstall.exe. The following entry is logged in SMSTS.log:

   > 01-13-2016 17:56:35.525   TSManager    2176 (0x880)    Executing command line: smsappinstall.exe/app:ScopeId_GUID/Application_GUID/basevar: /continueOnError:False

At this point the **Install Application** task (smsappinstall.exe) begins to install the application, although the command line to run the installation won't happen for some time yet. All the necessary information must be acquired first.

### Troubleshoot step 1

Based on the flow and execution of the task sequence, it's unlikely that a failure occurs during this step of the **Install Application** process. At this point, Task Sequence Manager has successfully parsed the task sequence XML and set an instruction pointer for the current task. Also, the policy for the task sequence is downloaded when the task sequence begins. The results are returned to the task sequence. They are stored in the task sequence environment using variables that are saved on disk as TSEnv.dat.

Here are some items to consider when investigating these issues. There may be an additional piece of information uncovered that can be used for troubleshooting the error condition.

> [!TIP]
> The policy body for the task sequence selected is downloaded from the database at the beginning of the task sequence and stored within the Task Sequence Environment using variables.

`MP_GetPolicy` will log this activity. To find this request in the `MP_GetPolicy` log, search for the **Deployment ID** or **Task Sequence ID**.

> 01-13-2016 17:32:54.579    MP_GetPolicy_ISAPI    12688 (0x3190)    MP GP: Query String Before Decode: MEH20009-MEH0000A-6F6BCC28.15_00  
> 01-13-2016 17:32:54.579    MP_GetPolicy_ISAPI    12688 (0x3190)    MP GP: ID : MEH20009-MEH0000A-6F6BCC28  
> 01-13-2016 17:32:54.579    MP_GetPolicy_ISAPI    12688 (0x3190)    MP GP: Initializing request from client GUID:ClientGUID.

The following stored procedure is executed to retrieve the policy body:

`exec MP_GetPolicyBodyAfterAuthorization`

The results of the policy body request are returned to the machine and saved in the task sequence environment (TSEnv.dat). The policy body for the task sequence and all its dependent policies are stored using variables. Task Sequence Manager will log a large portion of what it's reading from the environment.

## Step 2: The Install Application component evaluates the task sequence policy and stores it in WMI

During this step, the **Install Application** component evaluates the task sequence policy and stores it in WMI. The application checks the applicability of the requirement rules and detection method on the deployment types of the application. `CIStore` and `CIStateStore` are used to evaluate the applicability and state of the **Configuration Items** (CIs) and the **Configuration Data Content** associated with the application and deployment type. The result is that the CIs will be marked for download.

1. **Install Application** parses the command line and identifies the application name. The following entries are logged in SMSTS.log:

   > 01-13-2016 17:56:35.572    InstallApplication    1608 (0x648)    Application Names:  
   > 01-13-2016 17:56:35.572    InstallApplication    1608 (0x648)    'ScopeId_GUID/Application_GUID'
2. **Install Application** sets variables for the application. The following entries are logged in SMSTS.log:

   > 01-13-2016 17:56:35.666    InstallApplication    1608 (0x648)    Setting TSEnv variable 'SMSTSAppPolicyEvaluationJobID__ScopeId_GUID/Application_GUID'=''  
   > 01-13-2016 17:56:35.666    InstallApplication    1608 (0x648)    Setting TSEnv variable 'SMSTSInstallApplicationJobID__ScopeId_GUID/Application_GUID'=''
3. It then looks for policy scope ID. The following entry is logged in SMSTS.log:

   > 01-13-2016 17:56:35.666    InstallApplication    1608 (0x648)    Retrieving value from TSEnv for '_SMSTSPolicy_ScopeId_GUID/Application_GUID
4. Now it looks for and retrieves the value of the application policy from the task sequence environment (TSEnv.dat). The following entry is logged in SMSTS.log:

   > 01-13-2016 17:56:35.666    InstallApplication    1608 (0x648)    Found App policy modelname:ScopeId_GUID/RequiredApplication_GUID and CIversion:10
5. **Install Application** then decompresses the policy. The following entries are logged in SMSTS.log:

   > 01-13-2016 17:56:35.666    InstallApplication    1608 (0x648)    Found App policy modelname:ScopeId_GUID/RequiredApplication_GUID and CIversion:10  
   > 01-13-2016 17:56:35.682    InstallApplication    1608 (0x648)    ::DecompressBuffer(65536)  
   > 01-13-2016 17:56:35.682    InstallApplication    1608 (0x648)    Decompression (zlib) succeeded: original size 145382, uncompressed size 1238794.
6. The policies are stored in WMI by the **Install Application** component in the `root\ccm\policy\actualconfig` namespace. The following entries are logged in SMSTS.log:

   > 01-13-2016 17:56:36.119    InstallApplication    1608 (0x648)    Locked ActualConfig successfully  
   > 01-13-2016 17:56:36.150    InstallApplication    1608 (0x648)    New/Changed ActualConfig policy instance(s) : 6  
   > 01-13-2016 17:56:36.150    InstallApplication    1608 (0x648)    [1] Added/updated setting 'ccm_applicationciassignment:assignmentid=dep-meh20009-scopeid_GUID/application_GUID'.  
   > 01-13-2016 17:56:36.150    InstallApplication    1608 (0x648)    [2] Added/updated setting 'ccm_civersioninfo:modelname=scopeid_GUID/application_GUID:version=10'.  
   > 01-13-2016 17:56:36.150    InstallApplication    1608 (0x648)    [3] Added/updated setting 'ccm_civersioninfo:modelname=scopeid_GUID/deploymenttype_GUID:version=6'.  
   > 01-13-2016 17:56:36.150    InstallApplication    1608 (0x648)    [4] Added/updated setting 'ccm_civersioninfo:modelname=scopeid_GUID/requiredapplication_GUID:version=10'.  
   > 01-13-2016 17:56:36.150    InstallApplication    1608 (0x648)    [5] Added/updated setting 'ccm_civersioninfo:modelname=windows/all_windows_client_server:version=1'.  
   > 01-13-2016 17:56:36.150    InstallApplication    1608 (0x648)    [6] Added/updated setting 'ccm_scheduler_scheduledmessage:scheduledmessageid=dep-meh20009-scopeid_GUID/application_GUID'.  
   > 01-13-2016 17:56:36.150    InstallApplication    1608 (0x648)    Unlocked ActualConfig successfully  
   > 01-13-2016 17:56:36.150    InstallApplication    1608 (0x648)    Raising event:  
instance of CCM_PolicyAgent_SettingsEvaluationComplete  
{  
ClientID = "GUID:ClientGUID";  
DateTime = "20160113225636.150000+000";  
PolicyNamespace = "`\\\\.\\root\\ccm\\policy\\machine\\actualconfig`";  
ProcessID = 1392; ThreadID = 1608;  
};
7. Policy Agent Provider then processes the change in the `actualconfig` policy namespace. The following entries are logged in PolicyAgentProvider.log:

   > 01-13-2016 17:56:36.150    PolicyAgentProvider    2424 (0x978)    [000000B205C423A8] 1 settings change(s) detected.  
   > 01-13-2016 17:56:36.182    PolicyAgentProvider    2424 (0x978)    [000000B205C423A8] Queued worker to process these 1 settings change(s)  
   > 01-13-2016 17:56:36.182    PolicyAgentProvider    2420 (0x974)    --- Processing 1 settings change(s).  
   > 01-13-2016 17:56:36.182    PolicyAgentProvider    2420 (0x974)    --- [1] __InstanceCreationEvent settings change on object CCM_ApplicationCIAssignment.AssignmentID="DEP-MEH20009-ScopeId_GUID/Application_GUID".  
   > 01-13-2016 17:56:36.182    PolicyAgentProvider    2420 (0x974)    --- Begin Indicating 1 settings change(s).  
   > 01-13-2016 17:56:36.182    PolicyAgentProvider    2420 (0x974)    --- Completed Indicating 1 settings change(s).
8. DCMAgent processes the change and begins to evaluate the CIs for the application install. The following entry is logged in DCMAgent.log:

   > 01-13-2016 17:56:36.197   DCMAgent    2608 (0xa30)    DCMAgent::ProcessAssignmentChange.
9. Policy Agent then updates the Configuration Item info in the CI Store. The following entries are logged in CIStore.log:

   > 01-13-2016 17:56:36.260   CIStore    2608 (0xa30)   CCIStore::ProcessCITargetEvent - CIScopeId_GUID/Application_GUID:10 will be targeted for SYSTEM  
   > 01-13-2016 17:56:36.275   CIStore    2608 (0xa30)   CCIStore::ProcessCITargetEvent - CI ScopeId_GUID/DeploymentType_GUID:6 will be targeted for SYSTEM
10. The state of the application CI is added for the download, then the states of any associated application deployment type CIs are checked by the `CIStateStore`. Any CIs marked as **not found** are added for download.

    In CIStore.log:

    > 01-13-2016 17:56:36.275    CIStore    2608 (0xa30)    CCIStoreTargetedCIDownloader::AddCI - CI Modelname:ScopeId_GUID/Application_GUID Version:10 has been added for download

    In CIStateStore.log:

    > 01-13-2016 17:56:36.322    CIStateStore    2608 (0xa30)    CCIStateTransition::ExtractStateDetails - CI ModelName ScopeId_GUID/DeploymentType_GUID, version 6 not found in store.

    In CIStore.log:

    > 01-13-2016 17:56:36.369    CIStore    2608 (0xa30)    CCIStoreTargetedCIDownloader::AddCI - CI Modelname:ScopeId_GUID/DeploymentType_GUID Version:6 has been added for download

Now the DCM agent will start its job to evaluate the application policies and begin acquiring the necessary information from the database.

### Troubleshoot step 2

This step is often where the error surfaces, but rarely where the error occurs. The **Install Application** component is the top-level process for installing the application. Any error from the list of components it invokes would roll back up to it. The actual cause of the failure is most likely in a subsequent step. The failure is reported back to the **Install Application** task, which then returns a failure with a generic error code. Usually it's the reason that most **Install Application** tasks return the following error:

> InstallApplication    296 (0x128)    App install failed.  
> InstallApplication    296 (0x128)    Install application action failed: 'APP NAME HERE'. Error Code 0x80004005

Here's a list of the most common errors that are returned to the **Install Application** task:

|Failure Type|What to Check|
|---|---|
|SMSTS.log shows one of the following errors: <ul><li>InstallApplication 2740 (0xab4) Policy Evaluation failed, hr=0x87d00269</li><li>Required management point not found (Error: 87D00269)</li></ul>|The error indicates that the machine can't communicate with the management point (MP). Confirm whether you're using a custom website for the MP. If so, review  [How to Create the Custom Website in Internet Information Services (IIS)](/previous-versions/system-center/system-center-2012-R2/gg712282(v=technet.10)#BKMK_PlanCustomWebsite). Ensure that a copy of the default document (default.htm) has been placed in the root folder that hosts the website. Also ensure that HTTP redirection isn't enabled on the default website.|
|SMSTS.log shows the following error: <br/>InstallApplication 3248 (0xcb0) Policy Evaluation failed, hr=0x80004005|Ensure that you have the latest updates for Configuration Manager installed.|
|SMSTS.log shows the following error:<br/>Install Static Applications failed, hr=0x87d00267|Ensure that you've installed the latest version of ConfigMgr 2012 R2 SP1.|
|SMSTS.log shows the following error:<br/>Execution status received: 24 (Application download failed)|Review [KB3007095](https://support.microsoft.com/help/3007095) and ensure that you're up to date. Ensure that you have the latest updates for Configuration Manager installed.|
|SMSTS.log shows the following error:<br/>Install application action failed: 'APP NAME HERE'. Error Code 0x80004005'|Review CCMExec.log to confirm that SMS Agent Host is started without error.|

## Step 3: DCM Agent manages acquisition of the Configuration Items from the site database

In the previous step, the CIs were marked for download. The DCM agent uses CI Agent to begin acquiring the Configuration Items and Configuration Data Content (SDM package) from the database. The following information is included:

- Application Properties
- Application Manifest
- Deployment Type Properties
- Deployment Type Manifest
- Application Intent Policies for Compliance

The acquisition of this information doesn't happen all at once. The DCM agent uses the following client-side components at different times to do this work:

- CI Agent
- CI Downloader
- CIStore
- Data Transfer Service
- Content Transfer Manager

All of this information is requested from the database through the management point. The requests and responses can be monitored by using the MP_GetSDMPackage.log file.

Full order of `MP_GetSDMDocument` execution and Data Transfer Service download for each App Install task:

1. App PROPERTIES: Results have basic App CI info. Name only.
2. App MANIFEST: Links Policy Platform CI Documents with the Application CI.
3. App Intent Policy: Desired State of the Application, required.
4. App MANIFEST again. Note the different HASH. This time the results have extended information, such as WMI namespaces for the CI Manifests, App DT CI References.
5. App PROPERTIES again. Note the different HASH. This time the results include extended and custom properties, Publisher, release date, icons, and so on.
6. App DT PROPERTIES. Results include description, estimated install time, post install behavior, and so on.
7. App DT MANIFEST. Results include extended information, WMI namespaces for the CI Manifests.
8. App policy. Results include Policy Platform MOF to be compiled client side with Desired State, App Properties, and App DT Properties.
9. App DT Policy is compressed. Unable to decompress.

> [!TIP]
> Each component involved in the process will create a job, with a Job ID that can be used to track the progress. DCM Agent is always the first in the process. When you troubleshoot, note the Job ID for each component as you review the logs. Then follow the Job ID.

Below is an example of the request and download of only the Application PROPERTIES and MANIFEST (steps 1 and 2 from above).

1. DCM Agent job ID. In DCMAgent.log:

   > 01-13-201617:56:36.979    DCMAgent    1568(0x620)    CDCMAgentJobMgr::StartJob - Starting DCM Agent job{ID}
1. DCM Agent creates a job for CI Agent. In DCMAgent.log:

   > 01-13-2016 17:56:37.088    DCMAgent    2768 (0xad0)    DCMAgentJob({ID}): CDCMAgent::InitiateCIAgentJob - Starting CI Agent Job {ID} for target: machine. Refer to this CI agent job ID in ciagent.log for more details
1. `CIDownloader` creates a job. In CIDownloader.log:

   > 01-13-2016 17:56:37.166    CIDownloader    2728 (0xaa8)    CIDownloaderJob({ID}): SetFailureCondition - Job will fail immediately on error
1. DCM Agent is tracking the progress via its own job. In DCMAgent.log:

   > 01-13-2016 17:56:37.182    DCMAgent    2768 (0xad0)    DCMAgentJob({ID}): CDCMAgentJob::HandleEvent(Event=NotifyProgress, CurrentState=Evaluating)
1. `CIDownloader` calculates the scope of the CI, which starts a check of the CI Store. In CIDownloader.log:

   > 01-13-2016 17:56:37.182    CIDownloader    2728 (0xaa8)    [Calculate Scope] - Adding CI Modelname:ScopeId_GUID/RequiredApplication_GUID Version:10 to Scoped CIs List of root Modelname:ScopeId_GUID/RequiredApplication_GUID Version:10

   In CIStore.log:

   > 01-13-201617:56:37.182    CIStore    2728(0xaa8)    CCIStore::GetTargetedCIReference invoked for CIScopeId_GUID/RequiredApplication_GUID:10targeted to SYSTEM
1. The CI is queried in CI State Store and not found. In CIStateStore.log:

   > 01-13-201617:56:37.197    CIStateStore    2728(0xaa8)    CCIStateTransition::ExtractStateDetails - CIModelNameScopeId_GUID/RequiredApplication_GUID,version 10 not found in store.
1. Since the CI isn't found, it's added to the `CIDownloader` job. In CIDownloader.log:

   > 01-13-201617:56:37.213    CIDownloader    2728(0xaa8)   CIDownloaderJob({ID}): CI with ModelNameScopeId_GUID/RequiredApplication_GUID,Version 10. Model:(null) added to job.
1. CI Agent now starts the `CIDownloader` job to download the CIs.
In CIAgent.log:

   > 01-13-201617:56:37.229    CIAgent    2728(0xaa8)    CIAgentJob({ID}):Started CIDownloadJob({ID})
1. The `CIDownloader` job transitions to the *Downloading Packages* phase and adds the source files for the CIs to the request. At this point, **Packages** refers to the SDM package, not content (binaries). In CIDownloader.log:

   > 01-13-201617:56:37.229    CIDownloader    2728(0xaa8)   CIDownloaderJob({ID}): DownloadPackages  
   > 01-13-201617:56:37.229    CIDownloader    2728(0xaa8)    --Source file:.sms_dcm?Id\&amp;DocumentId=ScopeId_GUID/RequiredApplication_GUID/10/MANIFEST\&amp;Hash=HashString\&amp;Compression=zlib  
   > 01-13-201617:56:37.229    CIDownloader    2728(0xaa8)    --Source file:.sms_dcm?Id\&amp;DocumentId=ScopeId_GUID/RequiredApplication_GUID/10/PROPERTIES\&amp;Hash=HashString\&amp;Compression=zlib
1. `CIDownloader` calls into Data Transfer Service to request the manifest and properties for the application, and the Application Deployment Type. In DataTransferService.log:

   > 01-13-201617:56:37.275    DataTransferService    2728(0xaa8)    Added(source=.sms_dcm?Id&DocumentId=ScopeId_GUID/RequiredApplication_GUID/10/PROPERTIES&Hash=HashString&Compression=zlib,dest={JobID}_2.zip)pair from manifest.  
   > 01-13-201617:56:37.275    DataTransferService    2728(0xaa8)    Added(source=.sms_dcm?Id&DocumentId=ScopeId_GUID/RequiredApplication_GUID/10/MANIFEST&Hash=HashString&Compression=zlib,dest={JobID}_1.zip)pair from manifest.
1. Data Transfer Service calls into the `MP_GetSDMPacakge` ISAPI on the management point, which in turn requests the SDM package information from the database by triggering a SQL stored procedure. In SQL Server Profiler:

   > exec MP_GetSdmDocument N'ScopeId_GUID/RequiredApplication_GUID/10/PROPERTIES',N'HashString',N'1',N'1'  
   > exec MP_GetSdmDocument N'ScopeId_GUID/RequiredApplication_GUID/10/MANIFEST',N'HashString',N'1',N'1'
1. Data Transfer Service starts a Background Intelligence Service (BITS) job and adds the path to the job once the response is received. And begins downloading the data. In DataTransferService.log:

   > 01-13-201617:56:37.432    DataTransferService    2316(0x90c)    Starting BITS job'{ID}' for DTS job'{ID}' under user 'SID'.  
   > 01-13-201617:56:37.479    DataTransferService    2316(0x90c)    BITSHelper: Full source path to be transferred = `http://PS1.contoso.com:80/SMS_MP/.sms_dcm?Id&DocumentId=ScopeId_GUID/RequiredApplication_GUID/10/PROPERTIES&Hash=HashString&Compression=zlib`  
   > 01-13-201617:56:37.479    DataTransferService    2316(0x90c)    Adding to BITS job:{ID}_2.zip  
   > 01-13-201617:56:37.479    DataTransferService    2316(0x90c)    BITSHelper: Full source path to be transferred= `http://PS1.contoso.com:80/SMS_MP/.sms_dcm?Id&DocumentId=ScopeId_GUID/RequiredApplication_GUID/10/MANIFEST&Hash=HashString&Compression=zlib`  
   > 01-13-201617:56:37.479   DataTransferService    2316 (0x90c)    Adding to BITS job: {ID}_1.zip
1. Monitor DataTransferService.log for the completion of the SDM package download. Search for lines similar to below:

   Configuration Item #1

   > 01-13-2016 17:56:37.588    DataTransferService    2748 (0xabc)    Job: {ID}, Total Files: 2, Transferred Files: 2, Total Bytes: 1160, Transferred Bytes: 1160  
   > 01-13-2016 17:56:37.588    DataTransferService    2748 (0xabc)    DTSJob {ID} successfully completed download.

   Configuration Item #2

   > 01-13-2016 17:56:37.791    DataTransferService    1568 (0x620)    Job: {ID}, Total Files: 3, Transferred Files: 3, Total Bytes: 2616, Transferred Bytes: 2616  
   > 01-13-2016 17:56:37.791    DataTransferService    1568 (0x620)    DTSJob {ID} successfully completed download.

   Configuration Item #3

   > 01-13-2016 17:56:37.994    DataTransferService    2748 (0xabc)    Job: {ID}, Total Files: 3, Transferred Files: 3, Total Bytes: 3216, Transferred Bytes: 3216  
   > 01-13-2016 17:56:37.994    DataTransferService    2748 (0xabc)    DTSJob {ID} successfully completed download.

   Configuration Item #4

   > 01-13-2016 17:56:38.104    DataTransferService    1568 (0x620)    Job: {ID}, Total Files: 1, Transferred Files: 1, Total Bytes: 4172, Transferred Bytes: 4172  
   > 01-13-2016 17:56:38.104    DataTransferService    1568 (0x620)    DTSJob {ID} successfully completed download.

### Troubleshoot step 3

In step 3 to step 6, multiple components work together. Jobs are created locally to evaluate the existence of the CIs via CI Store (CCMStore.sdf). Or the CIs are marked as **not found**. Many issues can potentially arise during the next phase of this step:

DataTransferService uses BITS and HTTP communication with the MP to request the CIs and download them.

Possible causes include:

- Bad data in the database. For example, it returns corrupted CI or SDM Package Data, out-of-date versions, and so on.
- WMI issues when accessing policy namespaces locally on the machine that executes the task sequence.
- Failure when communicating with the MP or the database.
- BITS jobs failures.
- Network-related errors, downloads, and so on.
- IIS issues with SMS_MP vDir (SMS_CCM\SMS_MP folder).
- Evaluation errors after install.

Examine the following log files to identify where this process is failing:

- CIDownloader.log
- DCMAgent.log
- CIStore.log
- CIStateStore.log
- DataTransferService.log

## Step 4: CI Agent processes the CIs and saves them locally in CCMStore.sdf

After the Data Transfer Service job finishes downloading all of the CIs referenced by **Application Install**, `CIDownloader` will check the hash of the CIs, decompress them, and then persist them in CI Store. This process is done for each of the CIs associated with the application.

The following process will occur for any CI that has a relationship with the application being installed during this task. Merging the logs will help track the progress of each. Follow the Job IDs.

1. Individually, after each CI is completely downloaded, Data Transfer Service marks the job complete and `CIDownloader` confirms the hash.

   In DataTransferService.log:

   > 01-13-2016 17:56:37.588    DataTransferService    2748 (0xabc)    Job: {ID}, Total Files: 2, Transferred Files: 2, Total Bytes: 1160, Transferred Bytes: 1160  
   > 01-13-2016 17:56:37.588    DataTransferService    2748 (0xabc)    DTSJob {ID} successfully completed download.  
   > 01-13-2016 17:56:37.604    DataTransferService    2316 (0x90c)    DTSJob {ID} in state 'NotifiedComplete'.

   In CIDownloader.log:

   > 01-13-2016 17:56:37.619    CIDownloader    2768 (0xad0)    ::DecompressFile(C:\WINDOWS\CCM\CIDownloader\Staging\}_1.zip,65536,C:\WINDOWS\CCM\CIDownloader\Staging\{JobID}_1.xml)  
   > 01-13-2016 17:56:37.619    CIDownloader    2768 (0xad0)    VerifyCIDocumentHash - Preparing to verify hash for CI document ScopeId_GUID/RequiredApplication_GUID/10/MANIFEST  
   > 01-13-2016 17:56:37.619    CIDownloader    2768 (0xad0)    ::DecompressFile(C:\WINDOWS\CCM\CIDownloader\Staging\{JobID}_2.zip,65536,C:\WINDOWS\CCM\CIDownloader\Staging\{JobID}_2.xml)  
   > 01-13-2016 17:56:37.619    CIDownloader    2768 (0xad0)    VerifyCIDocumentHash - Preparing to verify hash for CI document ScopeId_GUID/RequiredApplication_GUID/10/PROPERTIES
2. After `CIDownloader` acquires all the CIs from the management point, it will call back into CI Agent and begin persisting the CIs. In CIAgent.log:

   > 01-13-2016 17:56:38.119    CIAgent    2768 (0xad0)    CIAgentJob({ID}): CAgentJob::NotifyComplete - CIDownloader callback  
   > 01-13-2016 17:56:38.119    CIAgent    2728 (0xaa8)    CIAgentJob({ID}): CAgentJob::HandleEvent(Event=Transition, CurrentState=PersistingCIModels)  
   01-13-2016 17:56:38.119    CIAgent    2728 (0xaa8)    CIAgentJob({ID}): PersistCIModels
3. `CIDownloader` will persist the CIs into the CI Digest Store. In CIDownloader.log:

   > 01-13-2016 17:56:38.119    CIDownloader    2728 (0xaa8)    CCIDigestStore::PersistIntegratedCIDefinitions  
   > 01-13-2016 17:56:38.182    CIDownloader    2728 (0xaa8)    DCM::LanternUtils::StoreModelDocument  
   > 01-13-2016 17:56:38.385    CIDownloader    2728 (0xaa8)    DCM::LanternUtils::StoreModelDocument succeeded  
   > 01-13-2016 17:56:38.385    CIDownloader    2728 (0xaa8)    CCIDigestStore::PersistIntegratedCIDefinitions - Lantern model document compiled to WMI.  
   > 01-13-2016 17:56:38.463    CIDownloader    2728 (0xaa8)    CCIDigestStore::PersistIntegratedCIDefinitions - Creating file C:\WINDOWS\CCM\CIDownloader\DigestStore\321EC9594015C9F9E6780EB4FEC210A78BEC119CB44ADE46A94C5F5B26F47948.xml  
   > 01-13-2016 17:56:38.463    CIDownloader    2728 (0xaa8)    CCIDigestStore::PersistIntegratedCIDefinitions - Creating file C:\WINDOWS\CCM\CIDownloader\DigestStore\B7BE90F13A8B7B3BD870B8DC5D0DF3E8378137B385988C2037A5C94EF21E4BCB.xml  
   > 01-13-2016 17:56:38.463    CIDownloader    2728 (0xaa8)    CCIDigestStore::PersistIntegratedCIDefinitions - Dcm Digest persisted to CIDigestStore.
4. `CIDownloader` completes persisting of the CIs and marks its job complete. In CIDownloader.log:

   > 01-13-2016 17:56:38.463    CIDownloader    2728 (0xaa8)    CCIDigestStore::PersistIntegratedCIDefinitions - Dcm Digest persisted to CIDigestStore.  
   > 01-13-2016 17:56:38.463    CIDownloader    2728 (0xaa8)    CCIDownloader::CompleteJob for job {ID}.
5. CI Agent checks the CI Store for the CIs needed by the Application Install process. CI Store returns the appropriate values. In CIAgent.log:

   > 01-13-2016 17:56:38.479    CIAgent    2728 (0xaa8)    CCIInfo::AddDepedentCI for ModelName: ScopeId_GUID/Application_GUID Version: 10  
   > 01-13-2016 17:56:38.479    CIStore    2728 (0xaa8)    CCIStore::GetCIEx - Requested CI ModelName ScopeId_GUID/Application_GUID, Version 10 returned from [Store]  
   > 01-13-2016 17:56:38.479    CIStore    2728 (0xaa8)    Found property (DisplayName) value but only with fallback to US English: ConfigMgr 2012 Toolkit R2  
   > 01-13-2016 17:56:38.510    CIAgent    2728 (0xaa8)    CCIInfo::AddDepedentCI for ModelName: ScopeId_GUID/DeploymentType_GUID Version: 6  
   > 01-13-2016 17:56:38.510    CIStore    2728 (0xaa8)    CCIStore::GetCIEx - Requested CI ModelName ScopeId_GUID/DeploymentType_GUID, Version 6 returned from [Store]  
   > 01-13-2016 17:56:38.510    CIStore    2728 (0xaa8)    Found property (DisplayName) value but only with fallback to default: ConfigMgr 2012 Toolkit R2 - Windows Installer (*.msi file)

Next, CI Agent will perform further processing by invoking the SDM model. SDM packages link together CIs and provide further information about the configuration that will be implemented. Part of this process also binds the CIs to policies using the Microsoft Policy Platform.

### Troubleshoot step 4

To troubleshoot issues during this step, see [Troubleshoot step 3](#troubleshoot-step-3).

## Step 5: CI Agent performs further processing of CIs using the SDM model

At this point, the necessary CIs have been acquired, and SDM package data has been downloaded. CI Agent will perform the following processes:

- invoke `SDMMethod` to bind the CIs to their *Policy Platform*/*Lantern Policies* stored in WMI, located at `root\Microsoft\PolicyPlatform\Documents\Local`.
- evaluate their applicability
- ultimately mark them as **Available for Enforcement** before cleaning up its jobs

In CIAgent.log:

> 01-13-2016 17:56:38.510    CIAgent    2728 (0xaa8)    CIAgentJob({ID}): TransitionState(From=PersistingCIModels, To=InvokingSdmMethod) for Event=Transition

1. CI Agent begins enactment and evaluation for the application CIs. In CIAgent.log:

   > 01-13-2016 17:56:38.541    CIAgent    2316 (0x90c)    CIAgentJob({ID}): StartEnactment - CI - ScopeId_GUID/RequiredApplication_GUID  
   > 01-13-2016 17:56:38.541    CIAgent    2316 (0x90c)    CIAgentJob({ID}): Evaluation for CI 'ScopeId_GUID/RequiredApplication_GUID.10'is required.
2. CI Agent invokes the **Policy Platform Client** and binds the policies by invoking the Microsoft Policy Platform. In CIAgent.log:

   > 01-13-2016 17:56:38.541    CIAgent    2316 (0x90c)    CIAgentJob({ID}): Evaluation for CI 'ScopeId_GUID/RequiredApplication_GUID.10'is required.  
   > 01-13-2016 17:56:38.541    CIAgent    2316 (0x90c)    CIAgentJob({ID}): StartEnactment - Attempting to invoke Policy Platform Client  
   > 01-13-2016 17:56:38.885    CIAgent    2316 (0x90c)    DCM::LanternUtils::ScopeAndBindPolicies - [ScopedPolicies] ScopeId_GUID_Application_GUID_Platform_PolicyDocument  
   > 01-13-2016 17:56:38.885    CIAgent    2316 (0x90c)    DCM::LanternUtils::ScopeAndBindPolicies - [ScopedPolicies] ScopeId_GUID_Application_GUID_Configuration_PolicyDocument
3. CI Agent completes the enactment. In CIAgent.log:

   > 01-13-2016 17:56:38.885    CIAgent    2316 (0x90c)    DCM::LanternUtils::ScopeAndBindPolicies - [ScopedPolicies] ScopeId_GUID_DeploymentType_GUID_Discovery_PolicyDocument  
   > 01-13-2016 17:56:39.619    CIAgent    2768 (0xad0)    CIAgentJob({ID}): Invocation succeeded for policy platform job ID  
   > 01-13-2016 17:56:39.619    CIAgent    2316 (0x90c)    Lantern job:ID succeeded.  
   > 01-13-2016 17:56:39.619    CIAgent    2768 (0xad0)    CIAgentJob({ID}): ReportMethodInvocation :: Enactment succeeded
4. CI Agent now transitions its job to downloading CIs, and then immediately transitions its state again, this time to enforcing CIs. In CIAgent.log:

   > 01-13-2016 17:56:39.963    CIAgent    2768 (0xad0)    CIAgentJob({ID}): TransitionState(From=StateDownloadingContents, To=StateEnforcingCIs) for Event=Transition  
   > 01-13-2016 17:56:39.963    CIAgent    2768 (0xad0)    CIAgentJob({ID}): CAgentJob::HandleEvent(Event=CITaskComplete, CurrentState=StateEnforcingCIs)
5. CI Agent will check one more time to ensure that the application isn't already installed. DCM Agent marks the CI as **Available for Enforcement**, and then reports that state.

   In CIAgent.log:

   > 01-13-2016 17:56:39.963    CIAgent    2728 (0xaa8)    CIAgentJob({ID}): CAgentJob::HandleEvent(Event=Transition, CurrentState=StateEnforcingCIs)

   In DCMAgent.log:

   > 01-13-2016 17:56:39.979    DCMAgent    1844 (0x734)    CAppMgmtSDK::GetEvaluationState ScopeId_GUID/RequiredApplication_GUID.10 = AvailableForEnforcement

   In CIAgent.log:

   > 01-13-2016 17:56:40.057    CIAgent    2728 (0xaa8)    CIAgentJob({ID}): CAgentJob::HandleEvent(Event=Transition, CurrentState=StateEnforcementReporting)
6. The CIs have been evaluated, downloaded, decompressed, persisted and then evaluated again. CI Agent and DCM Agent clean up the jobs they created to do all that work.

   In CIAgent.log:

   > 01-13-2016 17:56:40.072    CIAgent    2356 (0x934)    Internal Request to delete CIAgent job {ID}

   In DCMAgent.log:

   > 01-13-2016 17:56:40.088    DCMAgent    2728 (0xaa8)    DCMAgentJob({ID}): CDCMAgentJob::HandleEvent(Event=Transition, CurrentState=Success)

   In CIAgent.log:

   > 01-13-2016 17:56:40.104    CIAgent    2356 (0x934)    CIAgentJob({ID}): Job complete. Exiting event pump.

   In DCMAgent.log:

   > 01-13-2016 17:56:40.104    DCMAgent    2728 (0xaa8)    CDCMAgentJobMgr::DeleteJob - Request to delete DCM Agent job {ID}  
   > 01-13-2016 17:56:40.135    DCMAgent    2728 (0xaa8)    DCMAgentJob({ID}): QueueDebug - Executing Event.  
   > 01-13-2016 17:56:40.104    DCMAgent    2728 (0xaa8)    Job complete. Exiting event pump.

### Troubleshoot step 5

To troubleshoot issues during this step, see [Troubleshoot step 3](#troubleshoot-step-3).

## Step 6: DCM Agent confirms that all CIs are present and flags content for download

**Install Application** will now call back into the SDK to install the application. It creates a new job for DCM Agent, which in turn creates a job for CI Agent and all components it uses. The same process will occur, where CI Agent uses the components to ensure that all the CIs have been downloaded, evaluated, and persisted. The result of this step is that the content (binaries) for the **Application Install** process will be marked for download.

1. **Install Application** invokes the App Management SDK (DCM Agent) to install the application. In InstallApplication.log:

   > 01-13-2016 17:56:40.119    InstallApplication    1608 (0x648)    Invoking App Management SDK to install application  
   > 01-13-2016 17:56:40.135    InstallApplication    1608 (0x648)    Installing application 'ScopeId_GUID/RequiredApplication_GUID' has started. Please refer to DCMAgent.log for the details on this job. JobID='{ID}'
2. DCM Agent creates a new job for CI Agent.

   In DCMAgent.log:

   > 01-13-2016 17:56:40.135    DCMAgent    2356 (0x934)    DCMAgentJob({ID}): CDCMAgent::InitiateCIAgentJob - Starting CI Agent Job {ID} for target: machine. Refer to this CI agent job ID in ciagent.log for more details

    In CIAgent.log:

    > 01-13-2016 17:56:40.135    CIAgent    2356 (0x934)    CIAgentJob({ID}): [LeakTest] AgentJob created
3. This new CI Agent job goes into the **Waiting for Assigned CIs** state right away. Then it immediately transitions to downloading CIs.

    In CIAgent.log:

    > 01-13-2016 17:56:40.135    CIAgent    2768 (0xad0)    CIAgentJob({ID}): CAgentJob::HandleEvent(Event=Transition, CurrentState=WaitingForAssignedCI)  
    > 01-13-2016 17:56:40.135    CIAgent    2728 (0xaa8)    CIAgentJob({ID}): CAgentJob::HandleEvent(Event=DownloadCIs, CurrentState=WaitingForAssignedCI)  
    > 01-13-2016 17:56:40.135    CIAgent    2768 (0xad0)    CIAgentJob({ID}): CAgentJob::HandleEvent(Event=Transition, CurrentState=DownloadingCIs)
4. `CIDownloader` creates a job to handle the download and checks if the CIs are present. In CIDownloader.log:

   > 01-13-2016 17:56:40.135    CIDownloader    2768 (0xad0)    CIDownloaderJob({ID}): SetFailureCondition - Job will fail immediately on error
5. `CIDownloader` reports to CI Agent that all the CIs for the application are present in the store. In CIDownloader.log:

   > 01-13-2016 17:56:40.166    CIDownloader    2768 (0xad0)    CDownloadPayloadInfo::AddCI - CI with ModelName ScopeId_GUID/Application_GUID, Version 10 is already available.
6. The CI for the application, application DT, and requirements have already been downloaded. CI Agent logs that nothing is to be downloaded. Then it moves on to persisting the CI models.

   In CIAgent.log:

   > 01-13-2016 17:56:40.182    CIAgent    2768 (0xad0)    CIAgentJob({ID}): Nothing to be downloaded.  
   > 01-13-2016 17:56:40.182    CIAgent    2316 (0x90c)    CIAgentJob({ID}): CAgentJob::HandleEvent(Event=Transition, CurrentState=PersistingCIModels)
7. CI Agent invokes the SDM method again. Only this time it will flag that the binaries (install.msi) haven't been downloaded. In CIAgent.log:

   > 01-13-2016 17:56:40.213    CIAgent    2316 (0x90c)    CIAgentJob({ID}):  CI ScopeId_GUID/DeploymentType_GUID:6 (ConfigMgr 2012 Toolkit R2 - Windows Installer (*.msi file)) targeted to  (Dependant of policy CI ScopeId_GUID/RequiredApplication_GUID:10) is in scope for evaluation.  
   > 01-13-2016 17:56:40.213    CIAgent    2728 (0xaa8)    CIAgentJob({ID}): CAgentJob::HandleEvent(Event=Transition, CurrentState=InvokingSdmMethod)
8. CI Agent starts enactment again, calls into Microsoft Policy Platform, and confirms that the CIs are bound to policies.

   In CIAgent.log:

   > 01-13-2016 17:56:40.244    CIAgent    2728 (0xaa8)    CIAgentJob({ID}): StartEnactment - CI - ScopeId_GUID/RequiredApplication_GUID  
   > 01-13-2016 17:56:40.244    CIAgent    2728 (0xaa8)    CIAgentJob({ID}): StartEnactment - Attempting to invoke Policy Platform Client  
   > 01-13-2016 17:56:40.322    CIAgent    2768 (0xad0)    CIAgentJob({ID}): ReportMethodInvocation :: Enactment succeeded  
   > 01-13-2016 17:56:40.322    CIAgent    2768 (0xad0)    CIAgentJob({ID}): ReportMethodInvocation :: Obtained lantern reports
9. At this point, CI Agent marks both the application and application DT as **Available** and **Applicable**, as well as that they will be installed.

   In CIAgent.log:

   > 01-13-2016 17:56:40.369    CIAgent    2768 (0xad0)    CIAgentJob({ID}):State - Reporting (scan):: AppModel - ScopeId_GUID/Application_GUID:10 - State = NotInstalled ResolvedState = Available Applicability = Applicable ConfigureState= NotNeeded  
   > 01-13-2016 17:56:40.385    CIAgent    2768 (0xad0)    CIAgentJob({ID}):State - Reporting (scan):: Deployment Type - ScopeId_GUID/DeploymentType_GUID:6 - State = NotInstalled ResolvedState = Available Applicability = Applicable ConfigureState= NotNeeded  
   > 01-13-2016 17:56:40.463    CIAgent    2728 (0xaa8)    Job({ID}): CI ModelName ScopeId_GUID/Application_GUID version 10 will be INSTALLED. : Task(ScopeId_GUID/RequiredApplication_GUID.10.ContentDownload)  
   > 01-13-2016 17:56:40.463    CIAgent    2728 (0xaa8)    Job({ID}): CI ModelName ScopeId_GUID/DeploymentType_GUID version 6 will be INSTALLED. : Task(ScopeId_GUID/Application_GUID.10.ContentDownload)
10. Now CI Agent will begin downloading the binaries for the application Install. In CIAgent.log:

    > 01-13-2016 17:56:40.417    CIAgent    2728 (0xaa8)    CIAgentJob({ID}): CAgentJob::HandleEvent(Event=Transition, CurrentState=StateDownloadingContents)  
    > 01-13-2016 17:56:40.417    CIAgent    2728 (0xaa8)    CIAgentJob({ID}): DownloadBinaryContents  
    > 01-13-2016 17:56:40.417    CIAgent    2728 (0xaa8)    {ID} - Initiating ContentDownload tasks.  
    > 01-13-2016 17:56:40.463    CIAgent    2728 (0xaa8)    Job({ID}) : Successfully initialized : Task(ScopeId_GUID/DeploymentType_GUID.6.ContentDownload)  
    > 01-13-2016 17:56:40.463    CIAgent    2728 (0xaa8)    Job({ID}) : Successfully initialized : Task(ScopeId_GUID/Application_GUID.10.ContentDownload)

The complicated part is now over. Now we move on to download the binaries.

### Troubleshoot step 6

To troubleshoot issues during this step, see [Troubleshoot step 3](#troubleshoot-step-3).

## Step 7: Content for the Application Install task is downloaded using the standard content request/response process

To download the content for the installation, standard content request processes are used. The components involved on the client side are:

- Location Services
- Content Access (CAS)
- Content Transfer Manager
- Data Transfer Manager

On the server side, the components involved include:

- MP_Location
- MP_GetDPInfoContent
- IIS on the distribution point (DP) where the content will be accessed from.

1. Content Access (CAS) will access the information about the content request from WMI. In CAS.log:

   > 01-13-2016 17:56:40.572    ContentAccess    2728 (0xaa8)    CContentAccessService::Initialize  
   > 01-13-2016 17:56:40.572    ContentAccess    2728 (0xaa8)    CDownloadManager::InitializeFromWmi  
   > 01-13-2016 17:56:40.572    ContentAccess    2728 (0xaa8)    ===== CacheManager: Initializing cache state from Wmi. =====  
   > 01-13-2016 17:56:40.588    ContentAccess    2728 (0xaa8)    Loading cache configuration from Wmi.  
   > 01-13-2016 17:56:42.166    ContentAccess    2728 (0xaa8)    CacheManager: Getting cached content information for Content_GUID.1.
2. Content Transfer Manager creates and sends the Content Location Request. In ContentTransferManager.log:

   > 01-13-2016 17:56:42.432    ContentTransferManager    2768 (0xad0)    Attempting to create Location Request for PackageID='PackageID' and Version='1'  
   > 01-13-2016 17:56:42.448    ContentTransferManager    2768 (0xad0)    Attempting to send Location Request for PackageID='Content_GUID'  
   > 01-13-2016 17:56:42.448    ContentTransferManager    2728 (0xaa8)    Created CTM job {ID} for user SID  
   > 01-13-2016 17:56:42.448    ContentTransferManager    2768 (0xad0)    ContentLocationRequest : \<ContentLocationRequest SchemaVersion="1.00" ExcludeFileList="">\<Package ID="UID:Content_GUID" Version="1"/>\<AssignedSite SiteCode="MEH"/>\<ClientLocationInfo LocationType="SMSUpdate" DistributeOnDemand="0" UseAzure="0" AllowWUMU="0" UseProtected="0" AllowCaching="0" BranchDPFlags="0" UseInternetDP="0" AllowHTTP="1" AllowSMB="0" AllowMulticast="0">\<ADSite Name="Default-First-Site-Name"/>\<Forest Name="contoso.com"/>\<Domain Name="contoso.com"/>\<IPAddresses>\<IPAddress SubnetAddress="10.10.25.128" Address="10.10.25.130"/>\<IPAddress SubnetAddress="10.10.25.128" Address="10.10.25.166"/>\</IPAddresses>\</ClientLocationInfo>\</ContentLocationRequest>  
   > 01-13-2016 17:56:42.463    ContentTransferManager    2768 (0xad0)    Created and Sent Location Request '{ID}' for package Content_GUID  
   > 01-13-2016 17:56:42.463    ContentTransferManager    2768 (0xad0)    CTM job {ID} entered phase CCM_DOWNLOADSTATUS_DOWNLOADING_DATA
3. MP_Location receives the request and processes it by executing a stored procedure in the database. Either `MP_GetDPInfoProtected` or `MP_GetDPInfoUnprotected`.

   > [!TIP]
   > `MP_GetContentDPInfoProtected` is called when the client falls within a boundary group that has a protected DP. Protected DPs are the ones that don't allow fallback. `MP_GetContentDPInfoUnprotected` is called when the client doesn't fall within a boundary group that has a protected DP.

   In MP_Location.log:

   > 01-13-2016 17:56:42.516    MP_LocationManager    4044 (0xfcc)    MP_GetContentDPInfoProtected (UID:Content_GUID,1,MEH,\<ServerNameList>\<ServerName>PS1DP.CONTOSO.COM\</ServerName>\</ServerNameList>,SMSUpdate,00000000,contoso.com,contoso.com,\<ClientLocationInfo LocationType="SMSUpdate" DistributeOnDemand="0" UseAzure="0" AllowWUMU="0" UseProtected="0" AllowCaching="0" BranchDPFlags="0" UseInternetDP="0" AllowHTTP="1" AllowSMB="0" AllowMulticast="0">\<ADSite Name="DEFAULT-FIRST-SITE-NAME"/>\<Forest Name="contoso.com"/>\<Domain Name="contoso.com"/>\<IPAddresses>\<IPAddress SubnetAddress="10.10.25.128" Address="10.10.25.130"/>\<IPAddress SubnetAddress="10.10.25.128" Address="10.10.25.166"/>\</IPAddresses>\</ClientLocationInfo>)
4. MP_Location sends the response that includes the list of available distribution points where the binaries can be downloaded. In MP_Location.log:

   > 01-13-2016 17:56:42.523    MP_LocationManager    4044 (0xfcc)    MP LM: Reply message body: \<ContentLocationReply SchemaVersion="1.00" ContentFlags="200960" HashAlgorithm="32780" AlgorithmPreference="4" Hash="HashString" ExcludeFileListHash="" RelatedContentID="">\<ContentInfo PackageFlags="32">\<ContentHashValues>\<Hash Algorithm="32780" HashString="HashString" HashPreference="4"/>\</ContentHashValues>\</ContentInfo>\<Sites>\<Site>\<MPSite SiteCode="MEH" MasterSiteCode="MEH" SiteLocality="LOCAL" IISPreferedPort="80" IISSSLPreferedPort="443"/>\<LocationRecords>\<LocationRecord>\<URL Name="`http://PS1DP.contoso.com/SMS_DP_SMSPKG$/Content_GUID.1`" Signature="`http://PS1DP.contoso.com/SMS_DP_SMSSIG$/Content_63fbf078-1815-4e37-9614-b60ce7947805.1.tar`"/>\<ADSite Name="Default-First-Site-Name"/>\<IPSubnets>\<IPSubnet Address="10.10.25.128"/>\<IPSubnet Address=""/>\</IPSubnets>\<Metric Value=""/>\<Version>8239\</Version>\<Capabilities SchemaVersion="1.0">\<Property Name="SSLState" Value="0"/>\</Capabilities>\<ServerRemoteName>PS1DP.contoso.com\</ServerRemoteName>\<DPType>SERVER\</DPType>\<Windows Trust="1"/>\<Locality>LOCAL\</Locality>\</LocationRecord>\</LocationRecords>\</Site>\<Site>\<MPSite SiteCode="MEH" MasterSiteCode="MEH" SiteLocality="LOCAL"/>\<LocationRecords/>\</Site>\</Sites>\<RelatedContentIDs/>\</ContentLocationReply>
5. The response is received by Location Services on the client. In LocationServices.log:

   > 01-13-2016 17:56:42.510    LocationServices    2752 (0xac0)    ContentLocationReply : \<ContentLocationReply SchemaVersion="1.00" ContentFlags="200960" HashAlgorithm="32780" AlgorithmPreference="4" Hash="6FB054E0532351D888291FF52F74E0085940AEA90EC85A5B999B6CFBE94663FC" ExcludeFileListHash="" RelatedContentID="">\<ContentInfo PackageFlags="32">\<ContentHashValues>\<Hash Algorithm="32780" HashString="6FB054E0532351D888291FF52F74E0085940AEA90EC85A5B999B6CFBE94663FC" HashPreference="4"/>\</ContentHashValues>\</ContentInfo>\<Sites>\<Site>\<MPSite SiteCode="MEH" MasterSiteCode="MEH" SiteLocality="LOCAL" IISPreferedPort="80" IISSSLPreferedPort="443"/>\<LocationRecords>\<LocationRecord>\<URL Name="`http://PS1DP.contoso.com/SMS_DP_SMSPKG$/Content_63fbf078-1815-4e37-9614-b60ce7947805.1`" Signature="`http://PS1DP.contoso.com/SMS_DP_SMSSIG$/Content_63fbf078-1815-4e37-9614-b60ce7947805.1.tar`"/>\<ADSite Name="Default-First-Site-Name"/>\<IPSubnets>\<IPSubnet Address="10.10.25.128"/>\<IPSubnet Address=""/>\</IPSubnets>\<Metric Value=""/>\<Version>8239\</Version>\<Capabilities SchemaVersion="1.0">\<Property Name="SSLState" Value="0"/>\</Capabilities>\<ServerRemoteName>PS1DP.contoso.com\</ServerRemoteName>\<DPType>SERVER\</DPType>\<Windows Trust="1"/>\<Locality>LOCAL\</Locality>\</LocationRecord>\</LocationRecords>\</Site>\<Site>\<MPSite SiteCode="MEH" MasterSiteCode="MEH" SiteLocality="LOCAL"/>\<LocationRecords/>\</Site>\</Sites>\<RelatedContentIDs/>\</ContentLocationReply>
6. Location Services parses the reply to get the distribution point list that it sends to Content Transfer Manager. In LocationServices.log:

   > 01-13-2016 17:56:42.526    LocationServices    2752 (0xac0)    Distribution Point='`http://PS1DP.contoso.com/SMS_DP_SMSPKG$/Content_GUID.1`', Locality='LOCAL', DPType='SERVER', Version='8239', Capabilities='\<Capabilities SchemaVersion="1.0">\<Property Name="SSLState" Value="0"/>\</Capabilities>', Signature='`http://PS1DP.contoso.com/SMS_DP_SMSSIG$/Content_GUID.1.tar`', ForestTrust='TRUE',
7. Content Transfer Manager persists the location for the job it has created for downloading the binaries. In ContentTransferManager.log:

   > 01-13-2016 17:56:42.526    ContentTransferManager    2752 (0xac0)    Persisted locations for CTM job {ID}: (LOCAL) `http://PS1DP.contoso.com/SMS_DP_SMSPKG$/Content_GUID.1`
8. Content Transfer Manager then creates a job for Data Transfer Service to download the binaries. In ContentTransferManager.log:

   > 01-13-2016 17:56:42.541    ContentTransferManager    2752 (0xac0)    CTM job {ID} (corresponding DTS job {ID}) started download from '`http://PS1DP.contoso.com/SMS_DP_SMSPKG$/Content_GUID.1`' for full content download.
9. Data Transfer Service builds the job with the URL and starts a BITS job to do the download. In DataTransferService.log:

   > 01-13-2016 17:56:42.541    DataTransferService    2752 (0xac0)    Sending PROPFIND request using URL `http://PS1DP.contoso.com:80/SMS_DP_SMSPKG$/Content_GUID.1`  
   > 01-13-2016 17:56:42.557    DataTransferService    2752 (0xac0)    UpdateURLWithTransportSettings(): NEW URL - `http://ps1dp.contoso.com:80/SMS_DP_SMSPKG$/Content_GUID.1/sccm?/ConfigMgrTools.msi`  
   > 01-13-2016 17:56:42.573    DataTransferService    2752 (0xac0)    Starting BITS download for DTS job '{ID}'.  
   > 01-13-2016 17:56:42.573    DataTransferService    2752 (0xac0)    BITSHelper: Full source path to be transferred = `http://PS1DP.contoso.com:80/SMS_DP_SMSPKG$/Content_GUID.1/sccm?/ConfigMgrTools.msi`
10. Data Transfer Service completes the download and marks the job successful. In DataTransferService.log:

    > 01-13-2016 17:56:42.666    DataTransferService    2748 (0xabc)    Job: {ID}, Total Files: 1, Transferred Files: 0, Total Bytes: 5664768, Transferred Bytes: 262144  
    > 01-13-2016 17:56:42.869    DataTransferService    1568 (0x620)    Job: {ID}, Total Files: 1, Transferred Files: 1, Total Bytes: 5664768, Transferred Bytes: 5664768  
    > 01-13-2016 17:56:42.885    DataTransferService    2752 (0xac0)    DTSJob {ID} in state 'NotifiedComplete'.  
    > 01-13-2016 17:56:42.885    DataTransferService    2752 (0xac0)    DTS job {ID} has completed: 
Status : SUCCESS,
11. Content Transfer Manager then cleans up the DTS job, and CAS begins verifying the hash of the downloaded binaries.

    In ContentTransferManager.log:

    > 01-13-2016 17:56:42.901    ContentTransferManager    2728 (0xaa8)    CCTMJob::_Cleanup(JobID={ID}) - Cancelling DTS job  with provider \<default>  
    > 01-13-2016 17:56:42.901    ContentAccess    2348 (0x92c)    Using hash from LS Content Information: HashString

    In CAS.log:

    > 01-13-2016 17:56:42.948    ContentAccess    2348 (0x92c)    Computed hash: HashString  
    > 01-13-2016 17:56:42.948    ContentAccess    2348 (0x92c)    Success hash verification with hash algorithm = 32780, preference : 4
12. Content Access then maps the content to the CCM cache where the downloaded binaries are now stored. In CAS.log:

    > 01-13-2016 17:56:42.948    ContentAccess    2348 (0x92c)    Saved Content ID Mapping Content_GUID.1, C:\WINDOWS\ccmcache\1  
    > 01-13-2016 17:56:42.948    ContentAccess    2348 (0x92c)    CacheManager: ADD new cache entry for id:Content_GUID Version : 1 Size : 5532K RefCount:1 LastRef Minutes : 0 State : ACTIVE PinDuration : 0 Location : C:\WINDOWS\ccmcache\1  
    > 01-13-2016 17:56:42.948    ContentAccess    2348 (0x92c)    Created a New Cache Item at location C:\WINDOWS\ccmcache\1 for 1.Content_GUID Size 5532 KB bytes  
    > 01-13-2016 17:56:42.948    ContentAccess    2348 (0x92c)    Download succeeded for download request {GUID}
13. CI State Store updates `CIEnforcementState` of the CIs to **Download Content Success**. CI Agent then picks back up and begins enforcing the CIs. In CIAgent.log:

    > 01-13-2016 17:56:43.041    CIAgent    2316 (0x90c)    CIAgentJob({ID}): TransitionState(From=StateDownloadingContents, To=StateEnforcingCIs) for Event=Transition  
    > 01-13-2016 17:56:43.041    CIAgent    2728 (0xaa8)    CIAgentJob({ID}): EnforceCIs  
    > 01-13-2016 17:56:43.041    CIAgent    2728 (0xaa8)    {ID} - Initiating Enforce tasks.  
    > 01-13-2016 17:56:43.073    CIAgent    2728 (0xaa8)    Job({ID}) : Performing : Task(ScopeId_GUID/RequiredApplication_GUID.10.Enforce)  
    > 01-13-2016 17:56:43.073    CIAgent    2728 (0xaa8)    Job({ID}) : Performing : Task(ScopeId_GUID/Application_GUID.10.Enforce)  
    > 01-13-2016 17:56:43.073    CIAgent    2728 (0xaa8)    Job({ID}) : Performing : Task(ScopeId_GUID/DeploymentType_GUID.6.Enforce)

### Troubleshoot step 7

At this point in the task sequence, we have requested and downloaded content several times. It was accomplished using the standard content request/response procedures. These procedures are used in standard software/application installs outside of a task sequence. Because the task sequence has already used these procedures successfully, there's a low probability of them failing during this task. However, if problems arise with content location requests or access, examine the following log files to gain clues as to where the process is failing:

- CIAgent.log
- CAS.log
- ContentTransferManager.log
- DataTransferService.log
- LocationServices.log
- MP_Location.log

## Step 8: Application Deployment Type is enforced by executing the command line

Now comes the work of enforcing the installation of the application. It will use the standard **Application Install** components and flow: 

- `AppDiscovery`
- `AppEnforce`

1. `AppDiscovery` discovers the application and its properties. In AppDiscovery.log:

   > ActionType - Install,Max execute time = 120 minutes for AppDT "ConfigMgr 2012 Toolkit R2 - Windows Installer (*.msi file)" [ScopeId_GUID/DeploymentType_GUID], Revision - 6
2. `AppEnforce` begins the install enforcement by performing detection of the Application Deployment Type. For an MSI, it uses the product code to check whether it's already installed. Assuming that the detection state is **Not Discovered**, the installation will proceed. In AppEnforce.log:

   > 01-13-2016 17:56:43.104    AppEnforce    2216 (0x8a8)    +++ Starting Install enforcement for App DT "ConfigMgr 2012 Toolkit R2 - Windows Installer (*.msi file)" ApplicationDeliveryType - ScopeId_GUID/DeploymentType_GUID, Revision - 6, ContentPath - C:\WINDOWS\ccmcache\1, Execution Context - Any  
   > 01-13-2016 17:56:44.666    AppEnforce    2216 (0x8a8)    +++ Application not discovered. [AppDT Id: ScopeId_GUID/DeploymentType_GUID, Revision: 6]
3. Now AppEnforce will prepare the enforcement environment by parsing the command line and other install parameters, then prepares the working directory and executes the command line.

   In AppEnforce.log:

   > 01-13-2016 17:56:44.682    AppEnforce    2216 (0x8a8)    App enforcement environment:  
   > Context: Machine  
   > Command line: `msiexec /i "ConfigMgrTools.msi" /q /L*V "C:\Windows\CCM\Logs\MSI_install.log"`  
   > Allow user interaction: No  
   > UI mode: 0  
   > User token: null  
   > Session Id: 4294967295  
   > Content path: C:\WINDOWS\ccmcache\1  
   > Working directory:  
   > 01-13-2016 17:56:44.682    AppEnforce    2216 (0x8a8)    Prepared working directory: C:\WINDOWS\ccmcache\1  
   > 01-13-2016 17:56:44.713    AppEnforce    2216 (0x8a8)    Parsed CmdLine: `msiexec /i "ConfigMgrTools.msi" /q /L*V "C:\Windows\CCM\Logs\MSI_install.log"`  
   > 01-13-2016 17:56:44.713    AppEnforce    2216 (0x8a8)    Found executable file msiexec with complete path C:\WINDOWS\system32\msiexec.exe  
   > 01-13-2016 17:56:45.666    AppEnforce    2216 (0x8a8)    Executing Command line: `"C:\WINDOWS\system32\msiexec.exe" /i "ConfigMgrTools.msi" /q /L*V "C:\Windows\CCM\Logs\MSI_install.log" /qn` with system context  
   > 01-13-2016 17:56:44.729    AppEnforce    2216 (0x8a8)    Parsed CmdLine: `"C:\WINDOWS\system32\msiexec.exe" /i "ConfigMgrTools.msi" /q /L*V "C:\Windows\CCM\Logs\MSI_install.log" /qn`  
   > 01-13-2016 17:56:45.666    AppEnforce    2216 (0x8a8)    Executing Command line: `"C:\WINDOWS\system32\msiexec.exe" /i "ConfigMgrTools.msi" /q /L*V "C:\Windows\CCM\Logs\MSI_install.log" /qn` with system context
4. At this point, assuming there's logging for the MSI installation, msiexec.exe takes over and does the installation. In MSI Logging.log:

   > === Verbose logging started: 1/13/2016  17:56:45  Build type: SHIP UNICODE 5.00.9600.00  Calling process: C:\WINDOWS\system32\msiexec.exe ===
5. Once the installation is complete, msiexec.exe will send the return code to **Install Application**. **Install Application** will set the necessary task sequence environment variables indicating success, then report the successful install back to `AppEnforce`.

   In AppEnforce.log:

   > MSI (c) (BC:EC) [17:56:47:604]: MainEngineThread is returning 0  
   > 01-13-2016 17:56:47.979    InstallApplication    1384 (0x568)    NotifyProgress received: 1 (Application is installed successfully)  
   > 01-13-2016 17:56:48.010    InstallApplication    1608 (0x648)    Installation job completed with exit code 0x00000000  
   > 01-13-2016 17:56:48.010    InstallApplication    1608 (0x648)    Execution status received: 1 (Application is installed successfully)  
   > 01-13-2016 17:56:48.010    InstallApplication    1608 (0x648)    Setting TSEnv variable '_TSAppInstallStatus'='Success'  
   > 01-13-2016 17:56:48.010    InstallApplication    1608 (0x648)    Setting TSEnv variable 'SMSTSInstallApplicationJobID__ScopeId_GUID/Application_GUID'=''  
   > 01-13-2016 17:56:48.010    InstallApplication    1608 (0x648)    Step 2 out of 2 complete  
   > 01-13-2016 17:56:48.010    InstallApplication    1608 (0x648)    Sending success status message
6. `AppEnforce` matches the success code to the table specified in the **Return Codes** tab in the properties of the Application Deployment Type. It then performs detection again and marks the install enforcement complete.

    In AppEnforce.log:

    > 01-13-2016 17:56:47.620    AppEnforce    2216 (0x8a8)    Looking for exit code 0 in exit codes table...  
    > 01-13-2016 17:56:47.620    AppEnforce    2216 (0x8a8)    Found a match in the success exit codes.  
    > 01-13-2016 17:56:47.620    AppEnforce    2216 (0x8a8)    Matched exit code 0 to a Success entry in exit codes table.  
    > 01-13-2016 17:56:47.620    AppEnforce    2216 (0x8a8)    Performing detection of app deployment type ConfigMgr 2012 Toolkit R2 - Windows Installer (*.msi file)(ScopeId_GUID/DeploymentType_GUID, revision 6) for system.  
    > 01-13-2016 17:56:47.635    AppEnforce    2216 (0x8a8)    +++ Discovered application [AppDT Id: ScopeId_GUID/DeploymentType_GUID, Revision: 6]  
    > 01-13-2016 17:56:47.635    AppEnforce    2216 (0x8a8)    ++++++ App enforcement completed (4 seconds) for App DT "ConfigMgr 2012 Toolkit R2 - Windows Installer (*.msi file)" [ScopeId_GUID/DeploymentType_GUID], Revision: 6, User SID: ] ++++++

### Troubleshoot step 8

The applications that are installed must meet the following criteria:

- The application must be a deployment type of Windows Installer or Script installer. Windows app package (`.appx` file) deployment types aren't supported.
- It must run under the local system account and not the user account.
- It mustn't interact with the desktop. The program must run silently or in an unattended mode.
- It mustn't initiate a restart on its own. The application must request a restart by using the standard restart code (a 3010 exit code). It ensures that the task sequence step will handle the restart correctly. If the application returns a 3010 exit code, the underlying task sequence engine performs the restart. After the restart, the task sequence automatically continues.

To gather more information about the source of the failure, examine the MSI log. The following article provides more information about MSI log troubleshooting:  

[Read a Deployment Tool MSI Log](/previous-versions/tn-archive/cc535232(v=technet.10))

The following article includes product-specific information, and some general MSI log troubleshooting tips:

[Troubleshooting Office installation failures](/office/troubleshoot/installation/troubleshooting-office-installation-failures)

For more information about common MSI installer errors, see [MsiExec.exe and InstMsi.exe Error Messages](/windows/win32/msi/error-codes).

## Step 9: The application is detected as installed and Enforcement State is reported back to Task Sequence Manager

At this time, CI Agent has been checking with CI State Store for the Enforcement State of the CIs. DCM Agent has been doing the same as well, monitoring the progress and logging it to DCMAgent.log.

1. The installation is complete, and detection has marked it as installed. CI State Store will detect that the state of an existing CI has changed from **Enforcing** to **EnforcementSuccess**.

   In CIStateStore.log:

   > 01-13-2016 17:56:47.667    CIStateStore    2728 (0xaa8)    An existing CI state is changed  
   > 01-13-2016 17:56:47.667    CIStateStore    2728 (0xaa8)    [ScopeId_GUID/DeploymentType_GUID:6] CIEnforceState changed: Enforcing --> EnforcementSuccess  
   > 01-13-2016 17:56:47.729    CIStateStore    2348 (0x92c)    An existing CI state is changed  
   > 01-13-2016 17:56:47.776    CIStateStore    2728 (0xaa8)    [ScopeId_GUID/RequiredApplication_GUID:10] CIEnforceState changed: Enforcing --> EnforcementSuccess
2. Once it receives this new enforcement state from CI State Store, CI Agent will mark its jobs complete and transition to reporting the enforcement state. In CIAgent.log:

   > 01-13-2016 17:56:47.823    CIAgent    2348 (0x92c)    JobTaskHelper - Initiating next task if needed  
   > 01-13-2016 17:56:47.823    CIAgent    2348 (0x92c)    Job({ID}): Already Completed : Task(ScopeId_GUID/DeploymentType_GUID.6.Enforce)  
   > 01-13-2016 17:56:47.823    CIAgent    2348 (0x92c)    Job({ID}): Already Completed : Task(ScopeId_GUID/Application_GUID.10.Enforce)  
   > 01-13-2016 17:56:47.823    CIAgent    2348 (0x92c)    Job({ID}): Already Completed : Task(ScopeId_GUID/RequiredApplication_GUID.10.Enforce)  
   > 01-13-2016 17:56:47.838    CIAgent    2316 (0x90c)    CIAgentJob({ID}): CAgentJob::HandleEvent(Event=Transition, CurrentState=StateEnforcementReporting)
3. Enforcement reporting involves checking CI State Store for the compliance state of the application CI. Once it's set to compliant, CI Agent will transition to **Completed** and clean up its job.

   In CIStateStore.log:

   > 01-13-2016 17:56:47.932    CIStateStore    2316 (0x90c)    [ScopeId_GUID/RequiredApplication_GUID:10] CIState changed: NonCompliant --> Compliant

   In CIAgent.log:

   > 01-13-2016 17:56:47.963    CIAgent    2728 (0xaa8)    CIAgentJob({ID}): CAgentJob::HandleEvent(Event=Transition, CurrentState=Completed)  
   > 01-13-2016 17:56:47.963    CIAgent    2728 (0xaa8)    CIAgentJob({ID}): CAgentJob::HandleEvent(Event=Transition, CurrentState=Completed)  
   > 01-13-2016 17:56:47.963    CIAgent    2728 (0xaa8)    CIAgentJob({ID}): Deleting CIAgent Job  
   > 01-13-2016 17:56:47.963    CIAgent    2728 (0xaa8)    Deleted CIAgent job {ID}
4. DCM Agent passes the success notification back to the **Install Application** (smsappinstall.exe) process and DCM Agent cleans up its job.

    In DCMAgent.log:

    > 01-13-2016 17:56:47.979    DCMAgent    1384 (0x568)    CAppMgmtSDK::GetEvaluationState ScopeId_GUID/RequiredApplication_GUID.10 = Enforced  
    > 01-13-2016 17:56:47.979    DCMAgent    2316 (0x90c)    DCMAgentJob({ID}): CDCMAgentJob::HandleEvent(Event=NotifyProgress, CurrentState=Success)  
    > 01-13-2016 17:56:47.979    InstallApplication    1608 (0x648)    Received job completion notification from DCM Agent  
    > 01-13-2016 17:56:47.995    DCMAgent    2348 (0x92c)    CDCMAgentJobMgr::DeleteJob - Request to delete DCM Agent job {ID}
5. Lastly, the exit code is returned back to Task Sequence Manager. Task Sequence Manager updates the appropriate task sequence environment variables, and resumes the next task in the sequence. In SMSTS.log:

    > 01-13-2016 17:56:48.073    TSManager    2176 (0x880)    Process completed with exit code 0  
    > 01-13-2016 17:56:48.073    TSManager    2176 (0x880)    Successfully completed the action (Install Application) with the exit win32 code 0

## More information

For troubleshooting purposes, it's considered a best practice to create and use a duplicate copy of your production task sequence. The task sequence may need to be modified to include more data gathering tasks. And you may need to deploy the task sequence to a test machine.

Deployments that have problems will typically report errors in the **Monitoring** workspace. You can see these errors when you select **Deployments** > **Error**. For more information about how to troubleshoot these errors, see the following article:

[Tips and Tricks: How to Take Action on Assets That Report a Failed Deployment in System Center 2012 Configuration Manager](https://techcommunity.microsoft.com/t5/configuration-manager-archive/tips-and-tricks-how-to-take-action-on-assets-that-report-a/ba-p/273019)

For more information about task sequence steps, see [Task sequence steps](/mem/configmgr/osd/understand/task-sequence-steps).
