User: DEPLOYSERVER\User1
Client IP: 192.168.0.203
Content-Type: application/msdeploy
Version: 8.0.0.0
MSDeploy.VersionMin: 7.1.600.0
MSDeploy.VersionMax: 7.1.1070.1
MSDeploy.Method: Sync
MSDeploy.RequestId: 63b2f3d1-1817-444f-8280-9fa4f6f85d53
MSDeploy.RequestCulture: en-US
MSDeploy.RequestUICulture: en-US
Skip: objectName="^configProtectedData$"
Provider: auto, Path: 
Tracing deployment agent exception. Request ID '63b2f3d1-1817-444f-8280-9fa4f6f85d53'. Request Timestamp: '5/12/2011 9:31:41 AM'. Error Details:
System.UnauthorizedAccessException: Attempted to perform an unauthorized operation.
   at System.Security.AccessControl.Win32.SetSecurityInfo(ResourceType type, String name, SafeHandle handle, SecurityInfos securityInformation, SecurityIdentifier owner, SecurityIdentifier group, GenericAcl sacl, GenericAcl dacl)
   at System.Security.AccessControl.NativeObjectSecurity.Persist(String name, SafeHandle handle, AccessControlSections includeSections, Object exceptionContext)
   at System.Security.AccessControl.NativeObjectSecurity.Persist(String name, AccessControlSections includeSections, Object exceptionContext)
   at Microsoft.Web.Deployment.FileSystemSecurityEx.Persist(String path)
   at Microsoft.Web.Deployment.SetAclProvider.Add(DeploymentObject source, Boolean whatIf)
   at Microsoft.Web.Deployment.DeploymentObject.Update(DeploymentObject source, DeploymentSyncContext syncContext)
   at Microsoft.Web.Deployment.DeploymentSyncContext.HandleUpdate(DeploymentObject destObject, DeploymentObject sourceObject)
   at Microsoft.Web.Deployment.DeploymentSyncContext.SyncChildrenOrder(DeploymentObject dest, DeploymentObject source)
   at Microsoft.Web.Deployment.DeploymentSyncContext.ProcessSync(DeploymentObject destinationObject, DeploymentObject sourceObject)