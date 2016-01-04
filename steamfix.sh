find /home/`whoami`/.local/share/Steam -name "libgcc_s*" -o -name "libstdc++" -exec rm -f {} \;
