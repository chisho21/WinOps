function Install-SQLCertificate {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,Position=0)]
        [string[]]
        $ComputerName,
        [Parameter(Mandatory=$true,Position=1)]
        [string]
        $SQLInstance,
        [Parameter(Mandatory=$true,Position=2)]
        [string]
        $PfxLocalPath,
        [Parameter(Mandatory=$true,Position=3)]
        [securestring]
        $PfxPassword,
        [string]
        $RemoteFolder = "C:\Windows\Temp",
        [pscredential]
        $Credential
    )
    
    $scriptblock = {
        $filename = $using:filename
        $pfxremotepath = Join-path $using:RemoteFolder $filename
        $certstatus = $null
            # 1. Place Cert in store
        ## Add to the store, allow export of cert also get thumbprint value to variable
        $thumbprint = (Import-PfxCertificate -CertStoreLocation Cert:\LocalMachine\My -Exportable -Password $using:PfxPassword -FilePath $pfxremotepath).Thumbprint

        
        ## Get Service Account base on $SQLInstance name
        $serviceaccount = (Get-CimInstance win32_service | Where-Object {$_.Name -like "MSSQL`$$using:SQLInstance"}).StartName

        ## give permissions to the SQL Service account
            ## parts stolen from https://xenappblog.com/2017/automaticcompany-install-sql-server-and-enable-ssl-encryption-with-domain-ca/
        $permissionType = 'Read'
        try {
            #Clear Existing Variables
            $cert = ''
            $keyFullPath = ''
            Write-Host "[ $env:ComputerName ] - Finding Certificate with thumbprint: $thumbprint" -ForegroundColor Green
            #Get Certificate
            $cert = Get-ChildItem -Path cert:\LocalMachine\My | Where-Object {$_.Thumbprint -eq ($thumbprint -replace '\s','')}
            If ($cert -and $cert.PrivateKey.CspKeyContainerInfo.UniqueKeyContainerName) 
            {
                
                # Get Location of the machine related keys
                $keyPath = $env:ProgramData + "\Microsoft\Crypto\RSA\MachineKeys\"; 
                $keyName = $cert.PrivateKey.CspKeyContainerInfo.UniqueKeyContainerName;
                $keyFullPath = $keyPath + $keyName;
                Write-Host "[ $env:ComputerName ] - Found Certificate..." -ForegroundColor Green
                Write-Host "[ $env:ComputerName ] - Granting access to $serviceAccount..." -ForegroundColor Green
                #Grant Full Control to account listed in $serviceAccount
                $acl = (Get-Item $keyFullPath).GetAccessControl('Access') #Get Current Access
                $buildAcl = New-Object  System.Security.AccessControl.FileSystemAccessRule($serviceAccount,$permissionType,"Allow") #Build Access Rule
                $acl.SetAccessRule($buildAcl) #Add Access Rule
                Set-Acl $keyFullPath $acl #Save Access Rules
                Write-Host "[ $env:ComputerName ] - Access granted to $serviceAccount..." -ForegroundColor Green
                $certstatus = "Installed"
            }
            Else {
                Write-Host "[ $env:ComputerName ] - Unable to find Certificate that matches thumbprint $thumbprint or the private key is missing..." -ForegroundColor Red
            }
        }
        catch {
            Write-Host "[ $env:ComputerName ] - Unable to grant access to $serviceAccount..." -ForegroundColor Yellow
            throw $_;
        }
        if ($certstatus -eq "Installed"){
            # 2. Apply new cert to SQL
            ## Get Root SQL Path
            try {
                $root = (Get-ChildItem -Path "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\MS*$using:SQLInstance" -ErrorAction Stop).name -replace "HKEY_LOCAL_MACHINE","HKLM:"
                if ($root){
                    $keypath = Join-Path $root "\MSSQLServer\SuperSocketNetLib" -ErrorAction Stop
                    Write-Host "[ $env:ComputerName ] - Setting Registry $keypath Name: Certificate Value: $thumbprint"
                    Set-ItemProperty -Path $keyPath -Name "Certificate" -Type String -Value "$thumbprint" -ErrorAction Stop -Force
                    
                    Write-Host "[ $env:ComputerName ] - Setting Registry $keypath Name: ForceEncryption Value: 1"
                    Set-ItemProperty -Path $keyPath -Name "ForceEncryption" -Type DWord -Value "1" -ErrorAction Stop -Force
                }
                else {
                    Write-Host "[ $env:ComputerName ] - Unable to make registry changes - Couldn't determine path to update thumbprint." -ForegroundColor Red
                }
            }
            catch {
                Write-Host "[ $env:ComputerName ] - Unable to make registry changes..." -ForegroundColor Red
                throw $_;
            }

        }
        else {
            Write-Host "[ $env:ComputerName ] - Can't apply registry settings until certificate is installed." -ForegroundColor Yellow
        }
        

    }#end scriptblock

    foreach ($Computer in $ComputerName){
        Write-Host "[ $computer ] - Connecting to remote server."
        $session = New-PSSession $Computer -Credential $Credential
        
        $filename = (Get-Item $PfxLocalPath).Name
        Write-Host "[ $computer ] - Copying $file name to $RemoteFolder"
        Copy-Item -Path $PfxLocalPath -Destination $RemoteFolder -ToSession $session

        Invoke-Command -Session $session -ScriptBlock $scriptblock

        $session | Remove-PSSession
    }

}
