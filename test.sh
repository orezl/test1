#export PATH=$PATH:/Users/rahulkhanna/Documents/my-stuff/Executions
export PYTHONPATH='/Users/rahulkhanna/Documents/Github/Repo/bin'

help(){
    cat << EOF
HELP:-
SET:
    export CT_GITHUB_TOKEN=token to the environment
RUN:
    ${0} -c COMMAND -a ACTION -f scriptPath [-r|--repo GITHUB REPOSITORY] [-p|--prune] [-h||--help]
EOF
}

set_python(){
    which python3
    if [  $? -eq 0 ]; then shopt -s expand_aliases; alias python=python3;fi;
}

action=''
command=''
scriptPath=''
github_repository='all'
prune=0

while getopts hpa:c:r:f: opt; do
  case "$opt" in
    a) action="$OPTARG";;
    c) command="$OPTARG";;
    f) scriptPath="$OPTARG";;
    r) github_repository="$OPTARG";;
    p) prune=1;;
    h) help; exit 0;;
    ?) echo "WRONG OPTION"; exit 1;;
  esac
done

echo 'Input Action: '$action
echo 'Input Command: '$command
echo 'Script file for execution: '$scriptPath
echo 'Github Repository to check: '$github_repository
echo 'Prune action: '$prune

if [[ "$action" =~ ^-[a-z]$ || "$command" =~ ^-[a-z]$ || "$scriptPath" =~ ^-[a-z]$ || "$github_repository" =~ ^-[a-z]$ ]]; then echo "Invalid Input. Please check"; help; exit 1;fi
if [[ -z "$action" || -z "$command" ]]; then echo "\$action or \$command is empty. Either -a or -c option is paased with empty value or is missing in argument list"; exit 1;fi
if [ -z "$command" ]; then echo "\$command is empty. Either -c option is paased with empty value or is missing in argument list"; exit 1;fi
if [ -z "$scriptPath" ]; then echo "\$scriptPath is empty. Either -f option is paased with empty value or is missing in argument list"; exit 1;fi
if [ -z "$github_repository" ]; then echo "\$github_repository is empty. Either -r option is paased with empty value or is missing in argument list"; exit 1;fi

set_python
python $scriptPath/python.py $command $action --github_repository $github_repository --prune $prune 
