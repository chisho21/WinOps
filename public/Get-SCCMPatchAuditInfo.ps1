function Get-SCCMPatchAuditInfo {

    Param (
        $ComputerName,
        $KBs,
        [System.Management.Automation.PSCredential]
        $Credential
    )
        

    
    $scriptblock = {

        $kbs = $using:kbs
        
        $keypaths = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*","HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
        $data = foreach ($path in $keypaths){Get-ItemProperty $path | 
                        Select-Object @{N='Name';E={$_.DisplayName}}, @{N='Version';E={$_.DisplayVersion}}, Publisher, InstallDate} 
        $data = $data | Where-Object {$_.name}
        $Manufacturer = (Get-CimInstance win32_computersystem).manufacturer
        $sccm = (Get-CimInstance -Namespace root\ccm -Class SMS_Client).ClientVersion
        $scom = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\setup").AgentVersion 
        $lastbootup = (Get-CimInstance -ClassName win32_OperatingSystem).lastbootuptime
        $os = (Get-CimInstance win32_operatingsystem).Caption
        $hotfixes = Get-Hotfix
        $MSRT = (Get-Item "C:\Windows\System32\MRT.exe").versioninfo.ProductVersion
        #$list = $data | Where-Object {$programs -match $_.Name} | select name,version
        
        $object = [pscustomobject] @{
            ComputerName = $env:computername
            IsPhysical = if ($manufacturer -like "VMWare*"){""}else{"$true"}
            OperatingSystem = $os
            LastReboot = $lastbootup
            MSRT = $MSRT
            Chrome = ($data | Where-Object {$_.Name -like "Google Chrome*"}).Version -join ";"
            Firefox = ($data | Where-Object {$_.Name -like "Mozilla firefox*"}).Version -join ";"
            FireEye = ($data | Where-Object {$_.Name -like "FireEye Endpoint Agent*"}).Version -join ";"
            VMTools = ($data | Where-Object {$_.Name -like "VMware Tools*"}).Version -join ";"
            Symantec = ($data | Where-Object {$_.Name -like "Symantec Endpoint Protection*"}).Version -join ";"
            Splunk = ($data | Where-Object {$_.Name -like "UniversalForwarder*"}).Version -join ";"
            Imperva = ($data | Where-Object {$_.Name -like "Imperva SecureSphere Remote Agent*"}).Version  -join ";"
            Avamar = ($data | Where-Object {$_.Name -like "*Avamar*"}).Version -join ";"
            JavaJRE = ($data | Where-Object {$_.Name -like "Java 8*"}).Version -join ";"
            JavaJDK = ($data | Where-Object {$_.Name -like "Java SE Development Kit 8*"}).Version -join ";"
            FlashActivex = ($data |  Where-Object {$_.Name -like "*Flash*ActiveX*"}).Version -join ";"
            FlashNPAPI = ($data | Where-Object {$_.Name -like "*Flash*NPAPI*"}).Version -join ";"
            FlashPPAPI = ($data | Where-Object {$_.Name -like "*Flash*PPAPI*"}).Version -join ";"
            SCCM = $sccm
            SCOM = $scom
        }
        
        foreach ($kb in $kbs){
            #$baseline | Add-Member NoteProperty -Name "Enabled" -Value $true
            $value = if ($hotfixes.hotfixid -contains $kb){$true}else{""}
            $object | Add-Member NoteProperty -Name "$kb" -Value $value
        
        }
        
        
        return $object
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
