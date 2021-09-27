Get-ChildItem -Recurse "My Web Sites/*.*" |
foreach-object { 
    
    $a = $_.fullname; 
    $ext = (Get-ChildItem $a).Extension
    
    Write-Output "processing $a";
    Write-Output "ext = $ext"
    
    # if folder, skip
    if(Test-Path -Path $a -PathType Container) {
        Write-Output "It's a folder, skipping...";
        return;
    } 

    #if contains 'images.squarespace-cdn.com' in path, skip
    if($a -contains 'images.squarespace-cdn.com') {
        Write-Output "contains images.squarespace-cdn.com, skipping...";
        return;
    }

    # if not html file, skip
    if(!($ext -eq ".html")) {
        Write-Output "'$ext' -- It's not an HTML file, skipping..."
        return;
    } else {
        Write-Output "HTML :O"
    }

    # Write-Output "it's a file!";
    # Start-Sleep 1;

    ( get-content $a ) |
    foreach-object { 
        $_.replace("<noscript><img", "<img").replace("</noscript>", "");
    }  | set-content $a 
    
    
    
}
