while [[ 1 ]] ; do fswatch . --exclude=_build | make html; sleep 1; done
