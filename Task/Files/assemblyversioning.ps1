param (
	[Parameter(Mandatory=$True)]
	[string]$RootDir,
	[Parameter(Mandatory=$True)]
	[string]$FileNamePattern,
	[Parameter(Mandatory=$True)]
	[string]$Major,
	[Parameter(Mandatory=$True)]
	[string]$Minor
)

Write-Verbose 'Entering assemblyversioning.ps1'

### First, mount the assembly version ###

#Calculate today's julian date

function Get-JulianDate {
	#Calculate today's julian date
	$Year = get-date -format yy
	$JulianYear = $Year.Substring(1)
	$DayOfYear = (Get-Date).DayofYear
	$JulianDate = $JulianYear + "{0:D3}" -f $DayOfYear
	$JulianDate
	return
}

$build = Get-JulianDate

$buildNumberFromVso = $($env:BUILD_BUILDNUMBER)

$revision = $buildNumberFromVso.Split(".")[1]

# The Assembly Version

$assemblyVersion = "$Major.$Minor.$build.$revision"

Write-Host "The version this build will generate is $assemblyVersion"

$assemblyVersionString = "AssemblyVersion(""$assemblyVersion"")"
$assemblyFileVersionString = "AssemblyFileVersion(""$assemblyVersion"")"

### Encontrar os arquivos assemblyinfo

$assemblyInfoFiles = Get-ChildItem -Path $RootDir -Filter $FileNamePattern -Recurse
$fileCount = $assemblyInfoFiles.Count

Write-Host ""
Write-Host "Started writing the $FileNamePattern files..."
Write-Host ""

foreach($file in $assemblyInfoFiles){
	$fullFilePath = Join-Path $file.Directory $file.Name

	Write-Host "Editing $fullFilePath"

	$content = Get-Content -path $fullFilePath

	$newContent = $content -replace 'AssemblyVersion[\(][\"]\d+.\d+.\d+.\d+[\"][\)]',$assemblyVersionString
	$newContent = $newContent -replace 'AssemblyFileVersion[\(][\"]\d+.\d+.\d+.\d+[\"][\)]',$assemblyFileVersionString

	$newContent | Out-File $fullFilePath
}

Write-Host ""
Write-Host "Finished editing $fileCount AssemblyInfo files."