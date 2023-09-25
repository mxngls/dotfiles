function path_add(){  
    if [ -d "$1" ] ; then  
        local D=":${PATH}:";   
        [ "${D/:$1:/:}" = "$D" ] && PATH="$PATH:$1";  
        PATH="${PATH/#:/}";  
        export PATH="${PATH/%:/}";  
    fi  
}

function path_remove(){  
    local D=":${PATH}:";  
    [ "${D/:$1:/:}" != "$D" ] && PATH="${D/:$1:/:}";  
    PATH="${PATH/#:/}";  
    export PATH="${PATH/%:/}";  
}

# Homebrew
path_add "/opt/homebrew/bin"
path_add "/opt/homebrew/sbin"

# Standard OSX path
path_add "/usr/bin"
path_add "/bin"
path_add "/usr/sbin"
path_add "/sbin"

# Local
path_add "/usr/local/bin"
path_add "/usr/local/sbin"
