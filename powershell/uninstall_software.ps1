$app = Get-WmiObject -Class Win32_Product | Where-Object {
$_.Name -match “Oracle VM VirtualBox 5.1.14”
}

$app.Uninstall()
