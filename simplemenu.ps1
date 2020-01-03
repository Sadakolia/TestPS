
Clear-Host
$Fpath = $null
$MainCSV = Read-Host "Please Enter complete Path of Main CSV File" -ErrorAction Stop
If(!($MainCSV)){Write-Host "Main CSV File Path is Empty"}
If($MainCSV){
If (Test-Path $MainCSV){
    $ICSV = Import-Csv $MainCSV
    $CSVC = $ICSV.Count

Function Extract_Folderpath{
$MCSVE = $MainCSV.Split('\')[-1]
$MCSV = $MainCSV.Split('\')
$MCSV = $MCSV | ?{$PSItem -ne $MCSVE}
$EFPath = $MCSV -join '\'
return $EFPath
}

#Extract_Folderpath
$PPath =  Extract_Folderpath
Write-Host "Current Folder Path :: " $Fpath

function Show-Menu{
     param (
           [string]$Title = 'Split CSV Function'
     )
     cls
     Write-Host ""
     Write-Host "######################## $Title ########################" -ForegroundColor DarkGray
     Write-Host ""
     Write-Host "CSV Total Recordset :: $CSVC" -ForegroundColor DarkYellow
     Write-Host "Current CSV Export Folder Path :: $PPath"  
     Write-Host ""
     Write-Host ""
     Write-Host "Please Press Number to select the Options"
     Write-Host "=========================================" -ForegroundColor DarkCyan
     Write-Host "1) "-ForegroundColor Green -NoNewline; Write-Host "Split CSV per Record Items"
     Write-Host "    # Enter the Number of Record Items." -ForegroundColor DarkCyan
     Write-Host ""
     Write-Host "2) " -ForegroundColor Green -NoNewline; Write-Host "Split CSV with Number of Batches"
     Write-Host "    # Enter the Number of Batches." -ForegroundColor DarkCyan
     Write-Host ""
     Write-Host "3) " -ForegroundColor Green -NoNewline; Write-Host "Split CSV with Alphabets"
     Write-Host "    # Enter the Alphabets to Split the CSV" -ForegroundColor DarkCyan
     #Write-Host "    # If Folder Path does not exists then Script will create New Folder" -ForegroundColor DarkCyan
     Write-Host ""
     Write-Host "4) " -ForegroundColor Green -NoNewline; Write-Host "Enter Folder path to Export CSV"
     #Write-Host "    # If Folder path is Empty the CSV will be Exported to Source CSV Folder Path." -ForegroundColor DarkCyan

     Write-Host ""
     Write-Host "Press 'Q' to Quit." -ForegroundColor Red
     Write-Host ""
}

do{
     Show-Menu
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
           '1' {
                #cls
                Try{
                [int]$RecordSet = Read-Host "Please Enter the Number of RecordSet to Split the CSV" 
                
                If ($RecordSet -eq 0 -or $RecordSet -eq $null){Write-Host "Please enter Number Greater then Zero"
                    Exit}
                If ($RecordSet -gt $CSVC){Write-Host "Total Number of Split Recordset Exceeded the Total CSV RecordSet"
                    Exit}
                }catch{
                Write-host "Error : Please Enter Only Numbers" -ForegroundColor Red
                exit
                }

     IF($RecordSet){
        #$SplitNum = $num
        $CSVArray = @()
        $Batch = [Math]::Ceiling($ICSV.Count / $RecordSet)
        For($i=0;$I -lt $Batch;$i++){
        $SR = ($i * $RecordSet)
        $ER = (($i+1) * $RecordSet) -1
        If ($ER -ge $ICSV.Count){$ER = $ICSV.Count}
        $CSVArray+=,@($ICSV[$SR..$ER])
        }
    }
Write-Host "Number of CSV Files created will be : " $CSVArray.count
If(!($Fpath)){$FPath = $PPath}

Write-Host "Current Folder Path :: " $Fpath

0..(($CSVArray.count)-1)|%{
$CD = $_ + 1
$CSVArray[$_] | Export-Csv -Path $FPath\$($CD)_DATARecordset.csv -NoTypeInformation -Force }
exit
           } 
           '2' {
                Try{
                [int]$Batch = Read-Host "Please Enter the Number of Batches to Split the CSV" 
                
                If ($Batch -eq 0 -or $Batch -eq $null){Write-Host "Please enter Number Greater then Zero"
                    Exit}
                If ($Batch -gt $CSVC){Write-Host "Total Number of Batch Exceeded the Total CSV RecordSet"
                    Exit}
                }catch{
                Write-host "Error : Please Enter Only Numbers" -ForegroundColor Red
                exit
                }
        IF($Batch){
            $CSVArray = @()
            $Number = [Math]::Ceiling($ICSV.Count / $Batch)
            For($i=0;$I -lt $Batch;$i++){
            $SR = ($i * $Number)
            $ER = (($i+1) * $Number) -1
            If ($ER -ge $ICSV.Count){$ER = $ICSV.Count}
            $CSVArray+=,@($ICSV[$SR..$ER])
            }
        }
Write-Host "Number of CSV Files created will be : " $CSVArray.count
If(!($Fpath)){$FPath = $PPath}


Write-Host "Current Folder Path :: " $Fpath

0..(($CSVArray.count)-1)|%{
$CD = $_ + 1
$CSVArray[$_] | Export-Csv -Path $FPath\$($CD)_DATABatch.csv -NoTypeInformation -Force }
exit
           } 
           '3' {
                <#cls
                 #Write-Host 'You chose option  ' + $Omenu[2] -ForegroundColor  Cyan
                Try{
                $Fpath = Read-Host "Please Enter Folder Path to Export Split CSV Files" -ErrorAction Stop
                If (!(Test-Path $Fpath)){Write-Host "Folder Path does not exists"
                pause
                Show-Menu
                }else{Write-Host "Below Folder Path Added Successfully"
                Write-Host $Fpath}
                Set-Variable -Scope script -Name ppath -Value ($Fpath)
                pause
                Show-Menu
                }Catch{Write-Host "Please Enter Correct Format for Folder Path" -ForegroundColor Red}
                Show-Menu
                #>
################################################Alphabets Logs######################################################################

[array]$AB = @('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z')
$SRR = $null
$ERR = $null
$SR = $null
$ER = $null

$DT = @()

$inputRange = Read-Host "Pleas Enter Range of Alphabets" 
$inputRange = $inputRange.Replace(" ","")
$Range = $inputRange.Split('-')
$SRR = $Range[0]
$ERR = $Range[1]

$inputSR = $SRR
Switch($inputSR){
a {$SR = 0}
b {$SR = 1}
c {$SR = 2}
d {$SR = 3}
e {$SR = 4}
f {$SR = 5}
g {$SR = 6}
h {$SR = 7}
i {$SR = 8}
j {$SR = 9}
k {$SR = 10}
l {$SR = 11}
m {$SR = 12}
n {$SR = 13}
o {$SR = 14}
p {$SR = 15}
q {$SR = 16}
r {$SR = 17}
s {$SR = 18}
t {$SR = 19}
u {$SR = 20}
v {$SR = 21}
w {$SR = 22}
x {$SR = 23}
y {$SR = 24}
z {$SR = 25}

}

$inputER = $ERR
Switch($inputER){
a {$ER = 0}
b {$ER = 1}
c {$ER = 2}
d {$ER = 3}
e {$ER = 4}
f {$ER = 5}
g {$ER = 6}
h {$ER = 7}
i {$ER = 8}
j {$ER = 9}
k {$ER = 10}
l {$ER = 11}
m {$ER = 12}
n {$ER = 13}
o {$ER = 14}
p {$ER = 15}
q {$ER = 16}
r {$ER = 17}
s {$ER = 18}
t {$ER = 19}
u {$ER = 20}
v {$ER = 21}
w {$ER = 22}
x {$ER = 23}
y {$ER = 24}
z {$ER = 25}
}

$Para = ($ICSV | gm -MemberType NoteProperty).Name
$Para = $Para | Select-Object | Sort-Object 

$PData = @()

$Para | %{
$PData += $PSItem
$PDataC = $PData.count
Write-Host $PDataC") " $PSItem -ForegroundColor Green
}

[int]$Col = Read-Host "Please press the Number to select the Column Name to Split CSV Alphabeticaly"

$r = 1..($Para.Count)

if($Col -in $r){

$n = $Col - 1

$CCol = $PData[$n]

} else {write-host "Selected Number out of Range" -ForegroundColor Red}

Write-Host $CCol -ForegroundColor Yellow

#if (!($Para |?{$PSItem -eq $Col})){Write-Host "Incorrect Column selected" -ForegroundColor Red; exit}



if(!($ER)){$ER = $SR}


$SR..$ER | %{
$CDA = $AB[$PSItem]
$ICSV|%{
$CN = $PSItem
$CT = $CN |?{$_.($CCol) -like ($($CDA)+'*')}
$DT+=$CT
}
}
#$DT | Select-Object displayname
if(!($ERR)){$ERR = $SRR}

$RR = $srr.ToUpper() + "-" + $ERR.ToUpper()

"`n"

Write-Host "Total Items Count :: $($ICSV.Count)"
"`n"

Write-Host "Count for User Input Alphabet Range :: $RR :: $($DT.Count)" -ForegroundColor Cyan
If(!($Fpath)){$FPath = $PPath}


Write-Host "Current Folder Path :: " $Fpath


$DT | Export-Csv -Path $FPath\$($RR)_Alphabatical_data.csv -NoTypeInformation -Force
exit



######################################################################################################################
           } 
           '4' {
                #cls
                 #Write-Host 'You chose option  ' + $Omenu[2] -ForegroundColor  Cyan
                Try{
                $Fpath = Read-Host "Please Enter Folder Path to Export Split CSV Files" -ErrorAction Stop
                If (!(Test-Path $Fpath)){Write-Host "Folder Path does not exists"
                pause
                Show-Menu
                }else{Write-Host "Below Folder Path Added Successfully"
                Write-Host $Fpath}
                Set-Variable -Scope script -Name ppath -Value ($Fpath)
                pause
                Show-Menu
                }Catch{Write-Host "Please Enter Correct Format for Folder Path" -ForegroundColor Red}
                
                Show-Menu

           } 
           'q' {
                return
           }
     }
     pause
}
until ($input -eq 'q')
}else {Write-Host "Please enter Correct Path for CSV File"}
}

