function Get-SCCMCacheContents {

	<#
	.Synopsis
	   Obtain a list of files in C:\windows\ccmcache
	.DESCRIPTION
	   Obtain a list of files in C:\windows\ccmcache. Helpful for checking on the SCCM cache status for patching
	.SERVICENOW_REF
		N/A
	.EXAMPLE
       Get a list of cached files in Out-GridView for easy sorting: 
       PS> Get-SCCMCacheContents dfwpaap00660 -Credential $admincred | ogv
       (View output in Grid View)
	#>

		Param (
            [Parameter(Mandatory=$true,
                           Position=0)]
            $ComputerName,
            [System.Management.Automation.PSCredential]
            $Credential
        )
        
    $scriptblock = {
        $os = (Get-CimInstance win32_operatingsystem).Caption
        $cachecontent = Get-ChildItem -Path "C:\Windows\ccmcache\" -Recurse
        $returntable = @()
        foreach ($cache in $cachecontent){
            $object = [pscustomobject] @{
                ComputerName = $env:computername
                OperatingSystem = $os
                FileName = $cache.FullName
                CreationTime = $cache.CreationTime

            }#end object
            $returntable += $object
        }#end forech $cache
    
        return $returntable

    }# end script block
    
    #Execute Scriptblock on Computername(s) with set parameters.
	$params = @{
		ScriptBlock = $scriptblock
	}
	if ($ComputerName){
		$params['ComputerName'] = $ComputerName
	}
	if ($Credential){
		$params['Credential'] = $Credential
	}
	Invoke-Command @params
    
    
}
