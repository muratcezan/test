$logFile = "C:\Test\RDP_Ping.txt"
$lastConnection = $null
$timeCounter = 0
$previousLineCount = 4

function Write-ToLogFile {
    param($message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp $message" | Out-File -Append -FilePath $logFile
}

while($true){
    $lineCount = (netstat -an | Select-String ":3389").Count

    # Eğer lineCount bir önceki değerden farklıysa, 'DISCONNECTED' mesajı yazdır
    if ($lineCount -ne $previousLineCount) {
        Write-ToLogFile "DISCONNECTED IP = $($lastConnection) Duration Time = $($timeCounter)"
        $lastConnection = $null
        $timeCounter = 0
        $previousLineCount = $lineCount
        continue
    }

    netstat -an | Select-String ":3389" | ForEach-Object {
        $columns = ($_ -split '\s+')
        $status = $columns[4]

        if ($status -eq "ESTABLISHED") {
            if ($lastConnection -eq $columns[2]) {
                continue
            }
            elseif ($lastConnection -eq $null) {
                $lastConnection = $columns[2]
                $timeCounter = 0
                Write-ToLogFile "CONNECTED IP = $($columns[2])"
            }
            else {
                Write-ToLogFile "DISCONNECTED IP = $($lastConnection) Duration Time = $($timeCounter)"
                $timeCounter = 0
                $lastConnection = $columns[2]
                Write-ToLogFile "CONNECTED $($columns[2])"
            }
        }
    }
    $timeCounter = $timeCounter + 2
    Start-Sleep -Seconds 2
}
