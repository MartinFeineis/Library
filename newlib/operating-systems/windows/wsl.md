## Enable Virtualization
```powershell
$s = Get-WmiObject -class hp_biossettinginterface -Namespace "root\hp\instrumentedbios"
$s.SetBIOSSetting('Virtualization Technology (VTx)','Enable')
```