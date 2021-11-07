function Get-SChannelInfo {

    [CmdletBinding()]
    Param (
        [string[]]
        $ComputerName,
        [ValidateSet("ALL","Cipher","Protocol","Hash","KeyExchange")]
        $Type = "ALL",
        [switch]
        $EnabledOnly,
        [switch]
        $DisabledOnly,
        [System.Management.Automation.PSCredential]
        $Credential
        
    )
    $scriptblock = {
 
        $settings = @()
        $settings += [pscustomobject]@{ Name = "RC2 128/128"; Type = "Cipher"; Path = "Ciphers\RC2 128/128" }
        $settings += [pscustomobject]@{ Name = "RC2 56/128"; Type = "Cipher"; Path = "Ciphers\RC2 56/128" }
        $settings += [pscustomobject]@{ Name = "RC2 40/128"; Type = "Cipher"; Path = "Ciphers\RC2 40/128" }
        $settings += [pscustomobject]@{ Name = "RC4 128/128"; Type = "Cipher"; Path = "Ciphers\RC4 128/128" }
        $settings += [pscustomobject]@{ Name = "RC4 64/128"; Type = "Cipher"; Path = "Ciphers\RC4 64/128" }
        $settings += [pscustomobject]@{ Name = "RC4 56/128"; Type = "Cipher"; Path = "Ciphers\RC4 56/128" }
        $settings += [pscustomobject]@{ Name = "DES 56/56"; Type = "Cipher"; Path = "Ciphers\DES 56/56" }
        $settings += [pscustomobject]@{ Name = "Triple DES 168"; Type = "Cipher"; Path = "Ciphers\Triple DES 168" }
        $settings += [pscustomobject]@{ Name = "AES 128/128"; Type = "Cipher"; Path = "Ciphers\AES 128/128" }
        $settings += [pscustomobject]@{ Name = "AES 256/256"; Type = "Cipher"; Path = "Ciphers\AES 256/256" }
        $settings += [pscustomobject]@{ Name = "SSL 2.0"; Type = "ClientProtocol"; Path = "Protocols\SSL 2.0\Client" }
        $settings += [pscustomobject]@{ Name = "SSL 3.0"; Type = "ClientProtocol"; Path = "Protocols\SSL 3.0\Client" }
        $settings += [pscustomobject]@{ Name = "TLS 1.0"; Type = "ClientProtocol"; Path = "Protocols\TLS 1.0\Client" }
        $settings += [pscustomobject]@{ Name = "TLS 1.1"; Type = "ClientProtocol"; Path = "Protocols\TLS 1.1\Client" }
        $settings += [pscustomobject]@{ Name = "TLS 1.2"; Type = "ClientProtocol"; Path = "Protocols\TLS 1.2\Client" }
        $settings += [pscustomobject]@{ Name = "SSL 2.0"; Type = "ServerProtocol"; Path = "Protocols\SSL 2.0\Server" }
        $settings += [pscustomobject]@{ Name = "SSL 3.0"; Type = "ServerProtocol"; Path = "Protocols\SSL 3.0\Server" }
        $settings += [pscustomobject]@{ Name = "TLS 1.0"; Type = "ServerProtocol"; Path = "Protocols\TLS 1.0\Server" }
        $settings += [pscustomobject]@{ Name = "TLS 1.1"; Type = "ServerProtocol"; Path = "Protocols\TLS 1.1\Server" }
        $settings += [pscustomobject]@{ Name = "TLS 1.2"; Type = "ServerProtocol"; Path = "Protocols\TLS 1.2\Server" }
        $settings += [pscustomobject]@{ Name = "MD5"; Type = "Hash"; Path = "Hashes\MD5" }
        $settings += [pscustomobject]@{ Name = "SHA"; Type = "Hash"; Path = "Hashes\SHA" }
        $settings += [pscustomobject]@{ Name = "SHA 256"; Type = "Hash"; Path = "Hashes\SHA 256" }
        $settings += [pscustomobject]@{ Name = "SHA 384"; Type = "Hash"; Path = "Hashes\SHA 384" }
        $settings += [pscustomobject]@{ Name = "SHA 512"; Type = "Hash"; Path = "Hashes\SHA 512" }
        $settings += [pscustomobject]@{ Name = "Diffie-Hellman"; Type = "KeyExchange"; Path = "KeyExchangeAlgorithms\Diffie-Hellman"}
        $settings += [pscustomobject]@{ Name = "PKCS"; Type = "KeyExchange"; Path = "KeyExchangeAlgorithms\PKCS" }
        $settings += [pscustomobject]@{ Name = "ECDH"; Type = "KeyExchange"; Path = "KeyExchangeAlgorithms\ECDH" }

        # Result table
        $table = @()
        $root = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL'
        #loop thru each setting
        foreach ($setting in $settings){
            #write-Host "Working on $($setting.name)"
            $test = $null
            #$path = Join-Path $root "Protocols"
            $keypath = Join-path $root $setting.path
            if (Test-Path $keypath){
                $test = Get-ItemProperty $keypath -ErrorAction SilentlyContinue
            }
                
            if ($test){
                $enabled = switch ($test.enabled){
                    0 {$false}
                    1 {$true}
                    default{$true}
                }

                $count ++
                $individual = [pscustomobject] @{
                    ComputerName = $env:COMPUTERNAME
                    CipherName = $setting.name
                    Type = $setting.type
                    Enabled = $enabled
                    KeyPresent = $true
                    Path = $keypath
                }
                $table += $individual
            }#end if GOOD
            else {
                $individual = [pscustomobject] @{
                    ComputerName = $env:COMPUTERNAME
                    CipherName = $setting.name
                    Type = $setting.type
                    Enabled = $true
                    KeyPresent = $false
                    Path = $keypath
                }
                $table += $individual
            }#end else
        }#end foreach

        ## Filter table if flags set
        if ($using:type -ne "All"){
            $table = $table | where-object {$_.type -like "*$using:type*"}
        }

        if ($using:EnabledOnly){
            $table = $table | where-object {$_.Enabled -eq $true}
        }

        if ($using:DisabledOnly){
            $table = $table | where-object {$_.Enabled -eq $false}
        }
        
        return $table

    }#end scriptblock
         
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
