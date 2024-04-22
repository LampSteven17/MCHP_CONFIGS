#PS1 - Powershell Launch MITRE Caldera Human Plugin 

$pathy = Read-Host "Please enter path to human.py:"

$datey = Get-Date -Format "MM-dd-yyyy_HH-mm"
$filey = $datey + "_mtx_mchp.txt"


Get-Date -Format "MM-dd-yyyy_HH-mm" >> $filey
"STARTING RECORDING SCRIPT - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - " >> $filey

while ($true){ 

        Get-Date -Format "MM-dd-yyyy_HH-mm" >> $filey
        "STARTING MCHP PLUGIN - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - " >> $filey
        python3 $pathy/human.py --gtbstart='22:00:00' --gtbend='04:00:00' --sleepmin=4 --sleepmax=10 >> $filey

        Stop-Process -Name "chrome" -Force >> $filey
        Stop-Process -Name "mspaint" -Force >> $filey
        Stop-Process -Name "soffice" -Force >> $filey

        Get-ChildItem C:\Users\win11\Downloads\* | Remove-Item -recurse -force

        Clear-RecycleBin -force

}