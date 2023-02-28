param(
    [string]$computer,
    [string]$source,
	[string]$destination
)

Invoke-Command -ComputerName $computer -ScriptBlock {
    $src = $args[0]
    $dest = $args[1]
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Start-BitsTransfer -Source $src -Destination $dest
} -ArgumentList $source,$destination

