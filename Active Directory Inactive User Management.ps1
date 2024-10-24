$allUsers = Get-ADUser -Filter * -Properties Description, Enabled

foreach ($user in $allUsers) {
    if ($user.Enabled -eq $False) {
        if ($user.Description -notlike "Inactive Account*") {
            $newDescription = "Inactive Account $($user.Description)"
            Set-ADUser -Identity $user -Description $newDescription
        }
    } else {
        if ($user.Description -like "*Inactive Account*") {
            $currentDescription = $user.Description
            $newDescription = $currentDescription.Replace("Inactive Account", "  ")
            Set-ADUser -Identity $user -Description $newDescription
        }
    }
}