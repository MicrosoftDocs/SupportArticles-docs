User: DEPLOYSERVER\User1
Client IP: 192.168.0.203
Content-Type: application/msdeploy
Version: 8.0.0.0
MSDeploy.VersionMin: 7.1.600.0
MSDeploy.VersionMax: 7.1.1070.1
MSDeploy.Method: Sync
MSDeploy.RequestId: 50de0746-f10d-4640-9b3d-4ba773520e38
MSDeploy.RequestCulture: en-US
MSDeploy.RequestUICulture: en-US
Skip: objectName="^configProtectedData$"
Provider: auto, Path: 
Tracing deployment agent exception. Request ID '50de0746-f10d-4640-9b3d-4ba773520e38'. Request Timestamp: '5/12/2011 9:18:12 AM'. Error Details:
Microsoft.Web.Deployment.DeploymentDetailedUnauthorizedAccessException: Unable to perform the operation ("Create Directory")
for the specified directory ("C:\inetpub\wwwroot\bin"). This can occur if the server administrator has not authorized this
operation for the user credentials you are using.
---> Microsoft.Web.Deployment.DeploymentException: The error code was 0x80070005. ---> System.UnauthorizedAccessException:
Access to the path 'C:\inetpub\wwwroot\bin' is denied.
   at Microsoft.Web.Deployment.Win32Native.RaiseIOExceptionFromErrorCode(Win32ErrorCode errorCode, String maybeFullPath)
   at Microsoft.Web.Deployment.DirectoryEx.CreateDirectory(String path)
   at Microsoft.Web.Deployment.DirPathProvider.CreateDirectory(String fullPath, DeploymentObject source)
   at Microsoft.Web.Deployment.DirPathProvider.Add(DeploymentObject source, Boolean whatIf)
   --- End of inner exception stack trace ---
   --- End of inner exception stack trace ---