function Connect-RDPSession {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,ValueFromPipeline=$true,Position=0)]
        [string]
        $ComputerName,
        [ValidateSet('FullScreen','1600x900','800x600')]
        [string]
        $Size = '1600x900'
    )
    
    begin {
        
    }
    
    process {
        $sizearg = switch ($Size){
            'FullScreen' { "/f"  }
            '1600x900'   { "/w:1600 /h:900"  }
            '800x600'    { "/w:800 /h:600" }
        }
        $mstscargs = "/v:$ComputerName $sizearg"

        start-process mstsc.exe -ArgumentList $mstscargs

    }
    
    end {
        
    }
}