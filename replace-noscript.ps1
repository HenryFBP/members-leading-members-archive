Get-ChildItem -Recurse "My Web Sites/*.*" |
foreach-object { 
    $a = $_.fullname; ( get-content $a ) |
    foreach-object { 
        $_ -replace "master81", "master";
        $_ -replace "foobar", "woobar";
        $_ -replace "a", "b";
    }  | 
    set-content $a 
}
