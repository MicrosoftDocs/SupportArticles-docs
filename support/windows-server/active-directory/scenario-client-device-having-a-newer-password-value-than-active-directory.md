# Client device having a newer password value than Active Directory

If Active Directory value for pwdLastSet attribute has an older value than Cupdtime in affected device, this could be caused for these common reasons:
 
•	Active Directory replication issues.
•	A Domain Controller recovered from a backup.
•	Authoritative restore of the computer object in Active Directory
 
All these common reasons will need to be resolved from Active Directory end, as the issue cannot be resolved on client device end. Remember data should be consistent across all Domain Controllers. Recommendation would be to check Active Directory replication status, Domain Controllers health and network communication. You can check More information section for further reference.
 
Resolution to Scenario 2:
Once the issue has been resolved at the Active Directory end, reset computer Secure Channel by running one of the following commands using domain admin credentials:
 
•	In cmd: nltest /sc_reset:domain_name or in PowerShell: Test-ComputerSecureChannel -Repair -Credential *
•	Reboot device.
