---
title: Track the software update deployment process
description: Describes how to track the deployment of software updates in System Center 2012 Configuration Manager by using log files.
ms.date: 05/25/2020
ms.prod-support-area-path:
---
# Using log files to track the software update deployment process in Configuration Manager

This article describes how to track the deployment of software updates in Configuration Manager by using log files.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager, Microsoft System Center 2012 R2 Configuration Manager  
_Original KB number:_ &nbsp; 3090265

## Summary

When you deploy software updates in Configuration Manager, you typically add the updates to a software update group and then deploy the software update group to clients. When you create the deployment, the update policy is sent to client computers, and the update content files are downloaded from a distribution point to the local cache on the client computer. The updates are then available for installation on the client. In the following section, we examine this process in detail and show how the process can be tracked by using log files. This information may be helpful when you're trying to identify and resolve problems in the software update process.

For more information about software updates in Configuration Manager, see [Software updates introduction](software-updates-introduction.md).

## Deployment evaluation and update installation on clients

After the deployment and the deployment policy have been created on the server, clients receive the policy on the next policy evaluation cycle. Before reviewing the deployment evaluation process, it's important to find the Deployment Unique ID of the deployment by adding the **Deployment Unique ID** column in the console. For the deployment in the following example, the **Deployment Unique ID** is {B040D195-8FA8-48D3-953F-17E878DAB23D}.

1. Policy Agent receives the policy on manual policy retrieval or on schedule. When policy is received, the following are logged in PolicyAgent.log:

    > Initializing download of policy 'CCM_Policy_Policy5.PolicyID="{B040D195-8FA8-48D3-953F-17E878DAB23D}",PolicySource="SMS:PR1",PolicyVersion="1.00"' from 'http://PR1SITE.CONTOSO.COM/SMS_MP/.sms_pol?{B040D195-8FA8-48D3-953F-17E878DAB23D}.SHA256:0EE489DB3036BE80BB43676340249A254278BEBDDD80B6004C11FF10F12BC9D6' PolicyAgent_ReplyAssignments  
    > Download of policy CCM_Policy_Policy5.PolicyID="{B040D195-8FA8-48D3-953F-17E878DAB23D}",PolicySource="SMS:PR1",PolicyVersion="1.00" completed (DTS Job ID: {D53DAB18-ED97-4373-A3BE-3FBA5DB3C6C6}) PolicyAgent_PolicyDownload

    The following are logged in PolicyEvaluator.log:

    > Initializing download of policy 'CCM_Policy_Policy5.PolicyID="{B040D195-8FA8-48D3-953F-17E878DAB23D}",PolicySource="SMS:PR1",PolicyVersion="1.00"' from 'http://PR1SITE.CONTOSO.COM/SMS_MP/.sms_pol?{B040D195-8FA8-48D3-953F-17E878DAB23D}.SHA256:0EE489DB3036BE80BB43676340249A254278BEBDDD80B6004C11FF10F12BC9D6' PolicyAgent_ReplyAssignments  
    > Download of policy CCM_Policy_Policy5.PolicyID="{B040D195-8FA8-48D3-953F-17E878DAB23D}",PolicySource="SMS:PR1",PolicyVersion="1.00" completed (DTS Job ID: {D53DAB18-ED97-4373-A3BE-3FBA5DB3C6C6}) PolicyAgent_PolicyDownload

    After the policy is evaluated, the scheduler for the deadline is evaluated. This is done by the Scheduler component. In this example, deadline randomization is disabled in Computer Agent client settings. Therefore, the deployment evaluation is initiated on deadline and without randomization. This is shown in the Scheduler.log file as follows:

    > Initialized trigger ("3E692B0000080000") for schedule 'Machine/DEADLINE:{B040D195-8FA8-48D3-953F-17E878DAB23D}':  
    > Conditions=1 with deadline 4320 minutes  
    > Allow randomization override=1  
    > HasMissedOccurrence=FALSE  
    > ScheduleLoadedTime="02/09/2014 19:05:947"  
    > LastFireTime="00/00/00 00:00:00"  
    > CurrentTime="02/09/2014 19:05:947"    Scheduler  
    > Processing trigger '3E692B0000080000' for scheduler 'Machine/DEADLINE:{B040D195-8FA8-48D3-953F-17E878DAB23D}'. MaxRandomDelay = 120, MissedOccur = 0, RandomizeEvenIfMissed = 1, PreventRandomizationInducedMisses = 0   Scheduler  
    > Randomization is disabled in client settings and this schedule is set to honor client setting.   Scheduler  
    > SMSTrigger '3E692B0000080000' for scheduler 'Machine/DEADLINE:{B040D195-8FA8-48D3-953F-17E878DAB23D}' will fire at 02/09/2014 07:15:00 PM without randomization.   Scheduler

2. At the scheduled deadline, Scheduler notifies the Updates Deployment Agent to initiate the deployment evaluation process, as shown in Scheduler.log:

    > Sending message for schedule 'Machine/DEADLINE:{B040D195-8FA8-48D3-953F-17E878DAB23D}' (Target: 'direct:UpdatesDeploymentAgent', Name: '')    Scheduler  
    > SMSTrigger '3E692B0000080000' (Schedule ID: 'Machine/DEADLINE:{B040D195-8FA8-48D3-953F-17E878DAB23D}', Message Name: '', Target: 'direct:UpdatesDeploymentAgent') will never fire again.     Scheduler  

    In UpdatesDeployment.log:

    > Message received: '\<?xml version='1.0' ?>  
    > \<CIAssignmentMessage MessageType='EnforcementDeadline'>  
    > \<AssignmentID>{B040D195-8FA8-48D3-953F-17E878DAB23D}\</AssignmentID>  
    > \</CIAssignmentMessage>'    UpdatesDeploymentAgent  

    Updates Deployment Agent starts the deployment evaluation process by requesting a software update scan to make sure that the deployed updates are still applicable. In UpdatesDeployment.log:

    > Assignment {B040D195-8FA8-48D3-953F-17E878DAB23D} has total CI = 3   UpdatesDeploymentAgent  
    > Deadline received for assignment ({B040D195-8FA8-48D3-953F-17E878DAB23D})   UpdatesDeploymentAgent  
    > Detection job ({99ADA372-0738-44E4-9C4D-EBA30F23E9FD}) started for assignment ({B040D195-8FA8-48D3-953F-17E878DAB23D})   UpdatesDeploymentAgent  

    In UpdatesHandler.log:

    > Successfully initiated scan for job ({99ADA372-0738-44E4-9C4D-EBA30F23E9FD}).   UpdatesHandler  
    > Scan completion received for job ({99ADA372-0738-44E4-9C4D-EBA30F23E9FD}).   UpdatesHandler  
    > Initial scan completed for the job ({99ADA372-0738-44E4-9C4D-EBA30F23E9FD}).   UpdatesHandler  
    > Evaluating status of the updates for the job ({99ADA372-0738-44E4-9C4D-EBA30F23E9FD}).   UpdatesHandler  
    > CompleteJob - Job ({99ADA372-0738-44E4-9C4D-EBA30F23E9FD}) removed from job manager list.    UpdatesHandler  

3. At this point, the scan request is handled by Scan Agent component. Scan Agent calls WUAHandler to perform a scan and then hands the results back to Updates Handler and Updates Deployment Agent. For more information about the scan process, see (Software updates scan on clients TBD).

    After the scan is completed, Updates Deployment Agent is notified. This is noted in UpdatesDeployment.log as follows:

    > DetectJob completion received for assignment ({B040D195-8FA8-48D3-953F-17E878DAB23D}) UpdatesDeploymentAgent  
    > Making updates available for assignment ({B040D195-8FA8-48D3-953F-17E878DAB23D}) UpdatesDeploymentAgent  
    > Update (Site_D3A5F7EA-25D4-4C6B-B47C-C74997522A76/SUM_e06056e3-0199-4c68-8ac3-bdddff356a0a) Name (Security Update for Windows Server 2008 R2 x64 Edition (KB2698365)) ArticleID (2698365) added to the targeted list of deployment ({B040D195-8FA8-48D3-953F-17E878DAB23D}) UpdatesDeploymentAgent  
    > Update (Site_D3A5F7EA-25D4-4C6B-B47C-C74997522A76/SUM_ada7cf51-66b0-4a00-b37b-68d569d6ff8b) Name (Security Update for Windows Server 2008 R2 x64 Edition (KB2712808)) ArticleID (2712808) added to the targeted list of deployment ({B040D195-8FA8-48D3-953F-17E878DAB23D}) UpdatesDeploymentAgent  
    > Update (Site_D3A5F7EA-25D4-4C6B-B47C-C74997522A76/SUM_3cbcf577-5139-49b8-afe8-620af5c52f95) Name (Security Update for Windows Server 2008 R2 x64 Edition (KB2705219)) ArticleID (2705219) added to the targeted list of deployment ({B040D195-8FA8-48D3-953F-17E878DAB23D}) UpdatesDeploymentAgent  

4. Updates Deployment Agent raises state messages for the deployment to update the current **Evaluation** and **Compliance** state. This is noted in UpdatesDeployment.log as follows:

    > Raised assignment ({B040D195-8FA8-48D3-953F-17E878DAB23D}) state message successfully. TopicType = Evaluate, StateId = 2, StateName = ASSIGNMENT_EVALUATE_SUCCESS    UpdatesDeploymentAgent  
    > Raised assignment ({B040D195-8FA8-48D3-953F-17E878DAB23D}) state message successfully. TopicType = Compliance, Signature = 5e176837, IsCompliant = False    UpdatesDeploymentAgent

    Updates Deployment Agent now starts a job to download the software update files from the distribution point. This can be seen in UpdatesDeployment.log:

    > DownloadCIContents Job ({C531FD04-FADA-4F75-A399-EEA2D3EDB56C}) started for assignment ({B040D195-8FA8-48D3-953F-17E878DAB23D})   UpdatesDeploymentAgent  
    > Progress received for assignment ({B040D195-8FA8-48D3-953F-17E878DAB23D})   UpdatesDeploymentAgent  
    > Update (Site_D3A5F7EA-25D4-4C6B-B47C-C74997522A76/SUM_e06056e3-0199-4c68-8ac3-bdddff356a0a) Progress: Status = ciStateDownloading, PercentComplete = 0, Result = 0x0   UpdatesDeploymentAgent  
    > Update (Site_D3A5F7EA-25D4-4C6B-B47C-C74997522A76/SUM_ada7cf51-66b0-4a00-b37b-68d569d6ff8b) Progress: Status = ciStateDownloading, PercentComplete = 0, Result = 0x0   UpdatesDeploymentAgent  
    > Update (Site_D3A5F7EA-25D4-4C6B-B47C-C74997522A76/SUM_3cbcf577-5139-49b8-afe8-620af5c52f95) Progress: Status = ciStateDownloading, PercentComplete = 0, Result = 0x0   UpdatesDeploymentAgent

    It is also noted in UpdatesHandler.log as follows:

    > Initiating download for the job ({C531FD04-FADA-4F75-A399-EEA2D3EDB56C}). UpdatesHandler  
    > Update Id = 3cbcf577-5139-49b8-afe8-620af5c52f95, State = StateDownloading, Result = 0x0 UpdatesHandler  
    > Update Id = ada7cf51-66b0-4a00-b37b-68d569d6ff8b, State = StateDownloading, Result = 0x0 UpdatesHandler  
    > Update Id = e06056e3-0199-4c68-8ac3-bdddff356a0a, State = StateDownloading, Result = 0x0 UpdatesHandler  
    > Timeout Options: Priority = 2, DPLocality = 1048578, Location = 604800, Download = 864000, PerDPInactivity = 0, TotalInactivityTimeout = 0, bUseBranchCache = True, bPersistOnWriteFilterDevices = True, bOverrideServiceWindow = False UpdatesHandler

5. Updates Handler initiates the download request from Content Access service for the three actionable updates that are listed above. Note that the download job is started for the child update in the bundle and that the Content ID is logged.

    In UpdatesHandler.log
    > Bundle update (3cbcf577-5139-49b8-afe8-620af5c52f95) is requesting download from child updates for action (INSTALL) UpdatesHandler  
    > Content Text = \<Content ContentId="fbb5724a-aa0f-47f9-908a-47068fd8ad6f" Version="1">\<FileContent Name="windows6.1-kb2705219-v2-x64.cab" Hash="8E8E0175D46B5A8D52C4856FA3D282FAA12ACD63" HashAlgorithm="SHA1" Size="199093"/>\</Content>  
    > Bundle update (ada7cf51-66b0-4a00-b37b-68d569d6ff8b) is requesting download from child updates for action (INSTALL) UpdatesHandler  
    > Content Text = \<Content ContentId="3e9b1132-9ccd-439d-b32a-5cefd19735d1" Version="1">\<FileContent Name="windows6.1-kb2712808-x64.cab" Hash="060B60401B3DE3DCE053A68C65E9EB050874EB80" HashAlgorithm="SHA1" Size="805071"/>\</Content>  
    > Bundle update (e06056e3-0199-4c68-8ac3-bdddff356a0a) is requesting download from child updates for action (INSTALL) UpdatesHandler  
    > Content Text = \<Content ContentId="d2a9ee23-9cab-4843-b040-e2da1cc167e9" Version="1">\<FileContent Name="windows6.1-kb2698365-x64.cab" Hash="BF20BB36FC73C0D1F53EA1E635B8AA46C71D7B1F" HashAlgorithm="SHA1" Size="2496330"/>\</Content>

    Content Access service starts a download job for each update and creates a Content Transfer Manager (CTM) job. A CTM job is created for each update separately, and CAS.log entries resemble the following for each update:

    > Requesting content fbb5724a-aa0f-47f9-908a-47068fd8ad6f.1, size(KB) 0, under context System with priority Medium ContentAccess  
    > Created and initialized a DownloadContentRequest ContentAccess  
    > Target location for content fbb5724a-aa0f-47f9-908a-47068fd8ad6f.1 is C:\Windows\ccmcache\1 ContentAccess  
    > CDownloadManager::RequestDownload fbb5724a-aa0f-47f9-908a-47068fd8ad6f.1.System ContentAccess  
    > Submitted CTM job {E0452CF4-5B04-4A1A-B8EB-10B11B063249} to download Content fbb5724a-aa0f-47f9-908a-47068fd8ad6f.1 under context System ContentAccess  
    > Successfully created download request {856FA4CA-D02A-4E2C-841E-841ED3C7EC01} for content fbb5724a-aa0f-47f9-908a-47068fd8ad6f.1 ContentAccess  
    > Created and submitted a new Content Request for fbb5724a-aa0f-47f9-908a-47068fd8ad6f.1.System ContentAccess

6. Content Transfer Manager starts working on the download job. It first requests the location for the content that must be downloaded. This location request is handled by Location Services, which sends the location request to the management point, obtains the location response, and then hands it back to the Content Transfer Manager. This can be seen in ContentTransferManager.log:

    > Starting CTM job {E0452CF4-5B04-4A1A-B8EB-10B11B063249}. ContentTransferManager  
    > CTM job {E0452CF4-5B04-4A1A-B8EB-10B11B063249} entered phase CCM_DOWNLOADSTATUS_DOWNLOADING_DATA ContentTransferManager  
    > Queued location request '{C56C01F2-2388-4710-BF3B-A526DB40E35F}' for CTM job '{E0452CF4-5B04-4A1A-B8EB-10B11B063249}'. ContentTransferManager  
    > CCTMJob::EvaluateState(JobID={E0452CF4-5B04-4A1A-B8EB-10B11B063249}, State=RequestedLocations) ContentTransferManager

    This is also noted in LocationServices.log:

    > Created filter for LS request {C56C01F2-2388-4710-BF3B-A526DB40E35F}.   LocationServices  
    > ContentLocationReply : \<ContentLocationReply SchemaVersion="1.00">\<ContentInfo PackageFlags="0">\<ContentHashValues/>\</ContentInfo>\<Sites>\<Site>\<MPSite SiteCode="PR1" MasterSiteCode="PR1" SiteLocality="LOCAL" IISPreferedPort="80" IISSSLPreferedPort="443"/>\<LocationRecords>\<LocationRecord>\<URL Name="<http://PR1SITE.CONTOSO.COM/SMS_DP_SMSPKG$/fbb5724a-aa0f-47f9-908a-47068fd8ad6f>" Signature="<http://PR1SITE.CONTOSO.COM/SMS_DP_SMSSIG$/fbb5724a-aa0f-47f9-908a-47068fd8ad6f.1.tar>"/>\<ADSite Name="Default-First-Site-Name"/>\<IPSubnets>\<IPSubnet Address="192.168.10.0"/>\<IPSubnet Address=""/>\</IPSubnets>\<Metric Value=""/>\<Version>7958\</Version>\<Capabilities SchemaVersion="1.0">\<Property Name="SSLState" Value="0"/>\</Capabilities>\<ServerRemoteName>PR1SITE.CONTOSO.COM\</ServerRemoteName>\<DPType>SERVER\</DPType>\<Windows Trust="1"/>\<Locality>LOCAL\</Locality>\</LocationRecord>\</LocationRecords>\</Site>\</Sites>\<RelatedContentIDs/>\</ContentLocationReply>   LocationServices  
    > Distribution Point='<http://PR1SITE.CONTOSO.COM/SMS_DP_SMSPKG$/fbb5724a-aa0f-47f9-908a-47068fd8ad6f>', Locality='LOCAL', DPType='SERVER', Version='7958', Capabilities='\<Capabilities SchemaVersion="1.0">\<Property Name="SSLState" Value="0"/>\</Capabilities>', Signature='<http://PR1SITE.CONTOSO.COM/SMS_DP_SMSSIG$/fbb5724a-aa0f-47f9-908a-47068fd8ad6f.1.tar>', ForestTrust='TRUE',   LocationServices  
    > Calling back with locations for location request {C56C01F2-2388-4710-BF3B-A526DB40E35F}   LocationServices

    Content Transfer Manager receives the distribution point location for the requested content and starts a Data Transfer Service job to initiate the download of the update. We see this in ContentTransferManager.log:

    > CCTMJob::UpdateLocations({E0452CF4-5B04-4A1A-B8EB-10B11B063249})   ContentTransferManager  
    > CTM_NotifyLocationUpdate   ContentTransferManager  
    > Persisted location '<http://PR1SITE.CONTOSO.COM/SMS_DP_SMSPKG$/fbb5724a-aa0f-47f9-908a-47068fd8ad6f>', Order 0, for CTM job {E0452CF4-5B04-4A1A-B8EB-10B11B063249}   ContentTransferManager  
    > Persisted locations for CTM job {E0452CF4-5B04-4A1A-B8EB-10B11B063249}:  
    > (LOCAL) <http://PR1SITE.CONTOSO.COM/SMS_DP_SMSPKG$/fbb5724a-aa0f-47f9-908a-47068fd8ad6f>   ContentTransferManager  
    > CTM job {E0452CF4-5B04-4A1A-B8EB-10B11B063249} (corresponding DTS job {594E9A72-43D1-48D1-A639-D18DF7D286A2}) started download from 'http://PR1SITE.CONTOSO.COM/SMS_DP_SMSPKG$/fbb5724a-aa0f-47f9-908a-47068fd8ad6f' for full content download.   ContentTransferManager  
    > CCTMJob::EvaluateState(JobID={E0452CF4-5B04-4A1A-B8EB-10B11B063249}, State=DownloadingData)    ContentTransferManager  
    > CTM job {E0452CF4-5B04-4A1A-B8EB-10B11B063249} entered phase CCM_DOWNLOADSTATUS_DOWNLOADING_DATA    ContentTransferManager

    In CAS.log:

    > Location update from CTM for content fbb5724a-aa0f-47f9-908a-47068fd8ad6f.1 and request {856FA4CA-D02A-4E2C-841E-841ED3C7EC01} ContentAccess  
    > Download location found 0 - <http://PR1SITE.CONTOSO.COM/SMS_DP_SMSPKG$/fbb5724a-aa0f-47f9-908a-47068fd8ad6f> ContentAccess  
    > Download request only, ignoring location update ContentAccess  
    > Download started for content fbb5724a-aa0f-47f9-908a-47068fd8ad6f.1 ContentAccess

    At this point, Data Transfer Service creates a BITS job to download the file and then monitors the download progress as noted in DataTransferService.log:

    > DTSJob {594E9A72-43D1-48D1-A639-D18DF7D286A2} created to download from 'http://PR1SITE.CONTOSO.COM:80/SMS_DP_SMSPKG$/fbb5724a-aa0f-47f9-908a-47068fd8ad6f' to 'C:\Windows\ccmcache\1'.   DataTransferService  
    > DTSJob {594E9A72-43D1-48D1-A639-D18DF7D286A2} in state 'DownloadingManifest'.   DataTransferService  
    > CDTSJob::ProcessManifestCallback - processing manifest for job '{594E9A72-43D1-48D1-A639-D18DF7D286A2}'.  DataTransferService  
    > DTSJob {594E9A72-43D1-48D1-A639-D18DF7D286A2} in state 'RetrievedManifest'.   DataTransferService  
    > Execute called for DTS job '{594E9A72-43D1-48D1-A639-D18DF7D286A2}'. Current state: 'RetrievedManifest'.   DataTransferService  
    > DTSJob {594E9A72-43D1-48D1-A639-D18DF7D286A2} in state 'PendingDownload'.   DataTransferService  
    > Starting BITS download for DTS job '{594E9A72-43D1-48D1-A639-D18DF7D286A2}'.   DataTransferService  
    > DTSJob {594E9A72-43D1-48D1-A639-D18DF7D286A2} set BITS job to use default credentials.   DataTransferService  
    > Starting BITS job '{38E74FCB-4397-4CA9-94AE-BDD49F550EC9}' for DTS job '{594E9A72-43D1-48D1-A639-D18DF7D286A2}' under user 'S-1-5-18'.   DataTransferService  
    > DTS::SetCustomHeadersOnBITSJob - setting custom headers on DTS job '{594E9A72-43D1-48D1-A639-D18DF7D286A2}':  
    > \<none>   DataTransferService  
    > DTS::AddTransportSecurityOptionsToBITSJob - Removing security info from DTS job '{594E9A72-43D1-48D1-A639-D18DF7D286A2}'.   DataTransferService  
    > DTSJob {594E9A72-43D1-48D1-A639-D18DF7D286A2} in state 'DownloadingData'.   DataTransferService  
    > Job: {594E9A72-43D1-48D1-A639-D18DF7D286A2}, Total Files: 1, Transferred Files: 0, Total Bytes: 199093, Transferred Bytes: 5760   DataTransferService  
    > Job: {594E9A72-43D1-48D1-A639-D18DF7D286A2}, Total Files: 1, Transferred Files: 0, Total Bytes: 199093, Transferred Bytes: 199093   DataTransferService  
    > CDTSJob::JobTransferred : DTS Job ID='{594E9A72-43D1-48D1-A639-D18DF7D286A2}' BITS Job ID='{38E74FCB-4397-4CA9-94AE-BDD49F550EC9}'   DataTransferService  
    > Job: {594E9A72-43D1-48D1-A639-D18DF7D286A2}, Total Files: 1, Transferred Files: 1, Total Bytes: 199093, Transferred Bytes: 199093   DataTransferService  
    > DTSJob {594E9A72-43D1-48D1-A639-D18DF7D286A2} in state 'RetrievedData'.   DataTransferService  
    > DTSJob {594E9A72-43D1-48D1-A639-D18DF7D286A2} successfully completed download.   DataTransferService  
    > BITS job '{38E74FCB-4397-4CA9-94AE-BDD49F550EC9}' is not found. The BITS job may have completed already.   DataTransferService  
    > CBITSDownloadMonitor(DTSJobID={594E9A72-43D1-48D1-A639-D18DF7D286A2}, BITSJobID={38E74FCB-4397-4CA9-94AE-BDD49F550EC9}) ignoring cancelled object.   DataTransferService  
    > DTSJob {594E9A72-43D1-48D1-A639-D18DF7D286A2} in state 'NotifiedComplete'.   DataTransferService  
    > DTS job {594E9A72-43D1-48D1-A639-D18DF7D286A2} has completed:  
    > Status : SUCCESS,  
    > Start time : 02/09/2014 19:15:05,  
    > Completion time : 02/09/2014 19:15:12,  
    > Elapsed time : 7 seconds   DataTransferService

7. After the download is complete, CTM and Content Access service are notified, and they mark the download jobs as completed. Content Access service performs a hash verification of the downloaded content to verify the integrity of the downloaded file. This process occurs for each file, although the following example involves a single update being downloaded. Here's what we see in ContentTransferManager.log:

    > CCTMJob::EvaluateState(JobID={E0452CF4-5B04-4A1A-B8EB-10B11B063249}, State=Success)   ContentTransferManager  
    > CCTMJob::EvaluateState(JobID={E0452CF4-5B04-4A1A-B8EB-10B11B063249}, State=Complete)   ContentTransferManager

    In CAS.log:

    > Download completed for content fbb5724a-aa0f-47f9-908a-47068fd8ad6f.1 under context System   ContentAccess  
    > The hash we are verifying is SDMPackage:\<Content ContentId="fbb5724a-aa0f-47f9-908a-47068fd8ad6f" Version="1">\<FileContent Name="windows6.1-kb2705219-v2-x64.cab" Hash="8E8E0175D46B5A8D52C4856FA3D282FAA12ACD63" HashAlgorithm="SHA1" Size="199093"/>\</Content>  ContentAccess  
    > CContentAccessService::NotifyDownloadComplete Start Content Hashing   ContentAccess  
    > Hashing file c:\windows\ccmcache\1\windows6.1-kb2705219-v2-x64.cab   ContentAccess  
    > Hash matches ContentAccess 2/9/2014 7:15:12 PM 3532 (0x0DCC)  
    > Hash verification succeeded for content fbb5724a-aa0f-47f9-908a-47068fd8ad6f.1 downloaded under context System ContentAccess

    Then Updates Deployment Agent raises a state message to update the current enforcement state and then starts the installation of the update. We see the following in UpdatesDeployment.log:

    > Raised assignment ({B040D195-8FA8-48D3-953F-17E878DAB23D}) state message successfully. TopicType = Enforce, StateId = 8, StateName = ASSIGNMENT_ENFORCE_ADVANCE_DOWNLOAD_SUCCESS   UpdatesDeploymentAgent  
    > Starting install for assignment ({B040D195-8FA8-48D3-953F-17E878DAB23D})   UpdatesDeploymentAgent  
    > ApplyCIs - JobId = {CEE4AA3A-DE7B-4D9F-8949-E421BBBF2993}   UpdatesDeploymentAgent  
    > Update (Site_D3A5F7EA-25D4-4C6B-B47C-C74997522A76/SUM_3cbcf577-5139-49b8-afe8-620af5c52f95) Progress: Status = ciStateWaitInstall, PercentComplete = 0, DownloadSize = 0, Result = 0x0   UpdatesDeploymentAgent  
    > Update (Site_D3A5F7EA-25D4-4C6B-B47C-C74997522A76/SUM_ada7cf51-66b0-4a00-b37b-68d569d6ff8b) Progress: Status = ciStateWaitInstall, PercentComplete = 0, DownloadSize = 0, Result = 0x0   UpdatesDeploymentAgent  
    > Update (Site_D3A5F7EA-25D4-4C6B-B47C-C74997522A76/SUM_e06056e3-0199-4c68-8ac3-bdddff356a0a) Progress: Status = ciStateWaitInstall, PercentComplete = 0, DownloadSize = 0, Result = 0x0   UpdatesDeploymentAgent

    We also see this in UpdatesHandler.log:

    > Job {CEE4AA3A-DE7B-4D9F-8949-E421BBBF2993} is starting execution   UpdatesHandler  
    > CDeploymentJob::InstallUpdatesInBatch - Batch or non-batch install is not in progress for the job ({CEE4AA3A-DE7B-4D9F-8949-E421BBBF2993}). So allowing install..   UpdatesHandler  
    > Update (3cbcf577-5139-49b8-afe8-620af5c52f95) added to the installation batch   UpdatesHandler  
    > Update (ada7cf51-66b0-4a00-b37b-68d569d6ff8b) added to the installation batch   UpdatesHandler  
    > Update (e06056e3-0199-4c68-8ac3-bdddff356a0a) added to the installation batch   UpdatesHandler  
    > Got execute info for (3) updates   UpdatesHandler  
    > Updates installation started as batch   UpdatesHandler

8. Windows Update Agent Handler then copies the downloaded binaries to the Windows Update Agent cache (C:\Windows\SoftwareDistribution\Download) directory and instructs Windows Update Agent to start the installation process. This can be seen in WUAHandler.log:

    > Adding file to list for CopyToCache(): C:\Windows\ccmcache\1\windows6.1-kb2705219-v2-x64.cab   WUAHandler  
    > CopyToCache() for update (fbb5724a-aa0f-47f9-908a-47068fd8ad6f) completed successfully   WUAHandler  
    > Adding file to list for CopyToCache(): C:\Windows\ccmcache\2\windows6.1-kb2712808-x64.cab   WUAHandler  
    > CopyToCache() for update (3e9b1132-9ccd-439d-b32a-5cefd19735d1) completed successfully   WUAHandler  
    > Adding file to list for CopyToCache(): C:\Windows\ccmcache\3\windows6.1-kb2698365-x64.cab   WUAHandler  
    > CopyToCache() for update (d2a9ee23-9cab-4843-b040-e2da1cc167e9) completed successfully   WUAHandler  
    > Update(s) downloaded to WUA file cache, starting installation.   WUAHandler  
    > Async installation of updates started.   WUAHandler  
    > Update 1 (3cbcf577-5139-49b8-afe8-620af5c52f95) finished installing (0x00000000), Reboot Required? Yes   WUAHandler  
    > Update 2 (ada7cf51-66b0-4a00-b37b-68d569d6ff8b) finished installing (0x00000000), Reboot Required? Yes   WUAHandler  
    > Update 3 (e06056e3-0199-4c68-8ac3-bdddff356a0a) finished installing (0x00000000), Reboot Required? Yes   WUAHandler  
    > Async install completed.   WUAHandler  
    > Installation of updates completed.   WUAHandler

    We also see the following in WindowsUpdate.log:

    > 2014-02-09 19:15:26:130 800 ed0 Agent ** START ** Agent: Installing updates [CallerId = CcmExec]  
    > 2014-02-09 19:15:26:130 800 ed0 Agent * Updates to install = 3  
    > 2014-02-09 19:15:26:254 1048 84c Handler Starting install of CBS update FBB5724A-AA0F-47F9-908A-47068FD8AD6F  
    > 2014-02-09 19:15:29:218 1048 84c Handler Completed install of CBS update with type=3, requiresReboot=1, installerError=0, hr=0x0  
    > 2014-02-09 19:15:29:265 1048 84c Handler Starting install of CBS update 3E9B1132-9CCD-439D-B32A-5CEFD19735D1  
    > 2014-02-09 19:15:30:435 1048 84c Handler Completed install of CBS update with type=3, requiresReboot=1, installerError=0, hr=0x0  
    > 2014-02-09 19:15:30:451 1048 84c Handler Starting install of CBS update D2A9EE23-9CAB-4843-B040-E2DA1CC167E9  
    > 2014-02-09 19:15:39:296 1048 84c Handler Completed install of CBS update with type=3, requiresReboot=1, installerError=0, hr=0x0  
    > 2014-02-09 19:15:39:327 788 9f8 COMAPI - Reboot required = Yes  
    > 2014-02-09 19:15:39:327 788 9f8 COMAPI -- END -- COMAPI: Install [ClientId = CcmExec]

9. After the updates are installed, Updates Deployment Agent checks whether any updates require a reboot, and then it notifies the user if client settings are configured to allow such notifications. This is shown in UpdatesDeployment.log:

    > No installations in pipeline, notify reboot. NotifyUI = True   UpdatesDeploymentAgent  
    > Notify reboot with deadline = Sunday, Feb 09, 2014. - 19:15:39, Ignore reboot Window = False, NotifyUI = True UpdatesDeploymentAgent  
    > Raised assignment ({B040D195-8FA8-48D3-953F-17E878DAB23D}) state message successfully. TopicType = Enforce, StateId = 5, StateName = ASSIGNMENT_ENFORCE_PENDING_REBOOT   UpdatesDeploymentAgent

10. After the computer restarts, a post-reboot detection scan is started for the deployment to verify that updates are installed and to raise state messages for the update and deployment to indicate that updates are installed and that enforcement was successful. This is noted in UpdatesDeployment.log:

    > CTargetedUpdatesManager::DetectRebootPendingUpdates - Total Pending reboot updates = 3   UpdatesDeploymentAgent  
    > Initiated detect for pending reboot updates after system restart - JobId = {53F4851F-7E63-4C7E-952D-78345039FFFC}   UpdatesDeploymentAgent  
    > CUpdatesJob({53F4851F-7E63-4C7E-952D-78345039FFFC}): Job completion received.   UpdatesDeploymentAgent  
    > CUpdatesJob({53F4851F-7E63-4C7E-952D-78345039FFFC}): Detect after reboot job completed with result = 0x0   UpdatesDeploymentAgent  
    > Raised update (Site_D3A5F7EA-25D4-4C6B-B47C-C74997522A76/SUM_e06056e3-0199-4c68-8ac3-bdddff356a0a) enforcement state message successfully. StateId = 10, StateName = CI_ENFORCEMENT_SUCCESSFULL   UpdatesDeploymentAgent  
    > Raised update (Site_D3A5F7EA-25D4-4C6B-B47C-C74997522A76/SUM_ada7cf51-66b0-4a00-b37b-68d569d6ff8b) enforcement state message successfully. StateId = 10, StateName = CI_ENFORCEMENT_SUCCESSFULL   UpdatesDeploymentAgent  
    > Raised update (Site_D3A5F7EA-25D4-4C6B-B47C-C74997522A76/SUM_3cbcf577-5139-49b8-afe8-620af5c52f95) enforcement state message successfully. StateId = 10, StateName = CI_ENFORCEMENT_SUCCESSFULL   UpdatesDeploymentAgent  
    > Raised assignment ({B040D195-8FA8-48D3-953F-17E878DAB23D}) state message successfully. TopicType = Compliance, Signature = 5e176837, IsCompliant = True   UpdatesDeploymentAgent  
    > Raised assignment ({B040D195-8FA8-48D3-953F-17E878DAB23D}) state message successfully. TopicType = Enforce, StateId = 4, StateName = ASSIGNMENT_ENFORCE_SUCCESS   UpdatesDeploymentAgent

    At this point, the software updates deployment has been downloaded and successfully installed on the client, and the process is complete.
