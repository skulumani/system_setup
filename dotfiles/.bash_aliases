export KEYID=0x20D0685093466FC7

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

function cs () {
    cd "$@" && ls 
    }
alias jabref='java -jar $HOME/bin/JabRef/JabRef.jar'
# create and move to new directory
mcd () {
    mkdir -p $1
    cd $1
}

# alias to swap escape and capslock
alias swap_caps_escape='setxkbmap -option "caps:escape"'

nonascii() { LANG=C grep --color=always '[^ -~]\+'; }

# From https://github.com/xvoland/Extract/blob/master/extract.sh
function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    return 1
 else
    for n in $@
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

# Send a message using Signal-cli to a number
signal-send () {
    if [ -z "$1" ]; then
        echo "Usage: signal-send +16215551234 "message" "
    else
        signal-cli -u +16305579049 send -m "$2" "$1"
    fi
}

signal-receive () {
    signal-cli -u +16305579049 receive
}

# Allow for Sublime and rsub to work correctly
if [ -z "$SSH_CLIENT" ]; then
	export EDITOR="subl"
else
	export EDITOR="rsub"
fi

epstopdf_dir () {
    # run epstopdf on files in desired directory
    if [ -z "$1" ]; then
        echo "Usage: epstopdf_dir ~/path/to/dir "
    else
        echo "Running epstopdf on files in "$1" "    
        for file in "$1"/*.eps
        do
            echo "Converting "$file" "
            epstopdf $file
        done
    fi
}

# combine many pdfs together into on
# gs -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages -dCompressFonts=true -r150 -sOutputFile=output.pdf input.pdf
# Instructions are here https://stackoverflow.com/questions/2507766/merge-convert-multiple-pdf-files-into-one-pdf
pdfmerge () {
    if [ -z "$1" ]; then
        echo "Usage: pdfmerge output_file.pdf input_1.pdf input_2.pdf and so on"
    else
        gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -dCompatibilityLevel=1.4 -sOutputFile="$@" ;
    fi
}

pdfshrink () {
    if [ -z "$1" ]; then
        echo "Usage: pdfshrink output_file.pdf input_file.pdf"
    else
        gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$@" ;
    fi
}

getmousepos () {
    watch -t -n 0.0001 xdotool getmouselocation 
}

screenrecord () {
    ffmpeg -video_size 400x300 -framerate 25 -f x11grab -i :0.0+520,380 output.mp4
}
## Add completions and alias for todo.txt
source $HOME/bin/todo/todo_completion
export TODOTXT_DEFAULT_ACTION=ls
alias t='$HOME/bin/todo/todo.sh -d $HOME/bin/todo/todo.cfg -t'
alias todo='$HOME/bin/todo/todo.sh -d $HOME/bin/todo/todo.cfg -t'
