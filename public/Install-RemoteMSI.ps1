function Install-RemoteMSI {

    [CmdletBinding()]
    Param (
        $ComputerName,
        [Parameter(Mandatory=$true,
            ValueFromPipelineByPropertyName=$true,
            Position=1)]
        [String]
        $Path,
        [String]
        $MSIParameters = "/qn",
        [Switch]
        $MSILogging,
        [System.Management.Automation.PSCredential]
        $Credential
    )

    ## Setup Variables
    $root = (get-item $path).directoryName

    ## Setup Scriptblock for remote MSI install
    $scriptblock = {
        $root = $using:root
        $path = $using:path

        ## Mount network drive using creds
        Write-Host "[ $env:COMPUTERNAME ] - Connecting to $root" -ForegroundColor Yellow
        New-PSDrive -Name companyWINOPSINSTALL -PSProvider FileSystem -Root $root -Credential $using:Credential

        ## Determine installer file
        Write-Host "[ $env:COMPUTERNAME ] - Installing MSI path:: $($path)" -ForegroundColor Yellow

        try {
            Write-Host "[ $env:COMPUTERNAME ] - Installing $type parameters:: $($using:MSIParameters)" -ForegroundColor Yellow
            $msiargs = "/i " + $path + " " + $using:MSIParameters
            if ($using:MSILogging) {
                if (!(Test-Path -path C:\temp\)){
                    New-Item -Path C:\ -Name Temp -ItemType Directory -Force
                }
                $msiargs = $msiargs + " /l*v C:\temp\msi.log"
                Write-Host "[ $env:COMPUTERNAME ] - Logging MSI Install to C:\temp\msi.log" -ForegroundColor Yellow
            }
            Write-Host "[ $env:COMPUTERNAME ] - Executing:: msiexec.exe $msiargs" -ForegroundColor Yellow
            $exit = (Start-Process msiexec.exe -ArgumentList $msiargs -Wait -ErrorAction Stop -PassThru).ExitCode
            if ($exit -eq 0){
                Write-Host "[ $env:COMPUTERNAME ] - INSTALL Executed EXIT Code :: $exit" -ForegroundColor Green
            }
            else {
                Write-Host "[ $env:COMPUTERNAME ] - Error Installing EXIT CODE :: $exit" -ForegroundColor RED
            }
        }
        catch {
            Write-Error "[ $env:COMPUTERNAME ] - FAILED MSI Install"
        }

    }#end ScriptBlock

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
