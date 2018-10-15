$app = Get-WmiObject -Class Win32_Product -Filter "name like '%SoftwareName%'" 

$app.Uninstall()
