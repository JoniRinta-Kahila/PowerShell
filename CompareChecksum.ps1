# simpple PowerShell hash comparer script.
# Takes three parameters.
## -Hash <Pre-shared hash>
## -HashFunction <MD2 | MD4 | SHA1 | SHA256 | SHA384 | SHA512>
## -HashFile <Path to the file to calculate the checksum>
### Author https://github.com/JoniRinta-Kahila

[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $HashFunction,
    $HashFile,
    $Hash
)

function Compare-Hash {
    $CalculateHash = @(certutil -hashfile $HashFile $HashFunction);
    $Arr = $CalculateHash.Split([Environment]::NewLine);
    $CalculatedHash = $Arr[1];
    $HashCalculateCompleted = $Arr[2] -eq "CertUtil: -hashfile command completed successfully.";
    
    if($HashCalculateCompleted){
        return $CalculatedHash -eq $Hash;
    }

    return false;
}

if(Compare-Hash){
    echo "Hash OK!"
} else {
    echo "Warning: File Corrupted!"
}