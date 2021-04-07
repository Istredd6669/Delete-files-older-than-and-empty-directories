# $dayLimit -  (-1) means files older than 1 day
$dayLimit = (Get-Date).AddDays(-1)

# $path - path to the main folder where the script will be run
$path = "C:\Users\u24z81\Desktop\TEST POWERSHELL"

# Set to true to test the script
$whatIf = $true

#------------------------------------------------------------------------------------------------------------------------------#
# Find all files in "C:\Users\u24z81\Desktop\TEST POWERSHELL" older than $dayLimit
Function Delete-OldFiles($path)
{
Write-Host "Removing old file '${path}'"
Get-ChildItem –Path $path -Force -Recurse | Where-Object {$_.LastWriteTime -lt $dayLimit} | Remove-Item -Recurse -Force -WhatIf:$whatIf 
}
#------------------------------------------------------------------------------------------------------------------------------#
# Run the script
Delete-OldFiles -path "C:\Users\u24z81\Desktop\TEST POWERSHELL"

# Remove hidden files, like thumbs.db
$removeHiddenFiles = $false

# Get hidden files or not. Depending on removeHiddenFiles setting
$getHiddelFiles = !$removeHiddenFiles

# Set to true to test the script
#$whatIf = $true

#------------------------------------------------------------------------------------------------------------------------------#
# Remove empty directories 
Function Delete-EmptyFolder($path)
{
    # Go through each subfolder, 
    Foreach ($subFolder in Get-ChildItem -Force -Literal $path -Directory) 
    {
        # Call the function recursively
        Delete-EmptyFolder -path $subFolder.FullName
    }

    # Get all child items
    $subItems = Get-ChildItem -Force:$getHiddelFiles -LiteralPath $path

    # If there are no items, then we can delete the folder 
    If ($subItems -eq $null) 
    {
        Write-Host "Removing empty folder '${path}'"
        Remove-Item -Force -Recurse:$removeHiddenFiles -LiteralPath $Path -WhatIf:$whatIf
    }
}
#------------------------------------------------------------------------------------------------------------------------------#
# Run the script
Delete-EmptyFolder -path "C:\Users\u24z81\Desktop\TEST POWERSHELL"