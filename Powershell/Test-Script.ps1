$ser = Get-Service -Name BITS

if($ser)
{
    Write-Host "Yeah!, I'm there"
}