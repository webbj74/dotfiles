##
# Output a message
#
function scriptMessage
{
    echo -e "\n\033[1m[$$]${SCRIPT_NAME}: \033[1;34m${@}\033[0m"
}

##
# Output a message
#
function scriptDebug
{
    if [ ${SCRIPT_DEBUG} -eq 1 ]; then
        echo -e "\n\033[1m[$$]${SCRIPT_NAME}: \033[1;34m${@}\033[0m"
    fi
}

##
# Output an error message
#
function scriptError
{
    echo -e "\n\033[1m[$$]${SCRIPT_NAME}: \033[1;31m${@}\033[0m"
}

##
# Output a fatal error message and exit
#
function scriptFatal
{
    echo -e "\n\033[1m[$$]${SCRIPT_NAME}: \033[0;31mFATAL: ${@}\033[0m"

    if [ $SCRIPT_NOTIFY_ON_FATAL -eq 1 ]; then
        echo -e "[$$]${SCRIPT_NAME}: FATAL: ${@}" | mail -s "Fatal error in ${SCRIPT_NAME}" "${SCRIPT_EMAIL}"
    fi
    scriptFinal
    exit
}

##
# Output a fatal error message and exit
#
function scriptFatalNonLocking
{
    echo -e "\n\033[1m[$$]${SCRIPT_NAME}: \033[0;31mFATAL: ${@}\033[0m"

    if [ $SCRIPT_NOTIFY_ON_FATAL -eq 1 ]; then
        echo -e "[$$]${SCRIPT_NAME}: FATAL: ${@}\n\nRemoving lockfile: ${SCRIPT_LOCKFILE}" | mail -s "Fatal error in ${SCRIPT_NAME}" "${SCRIPT_EMAIL}"
    fi
    scriptFinal
    lockRelease
    exit
}

##
# Setup common script variables
#
function script_init {
    # COMMON GLOBALS

    # Start time in seconds
    SCRIPT_START=$(date -u +%s)

    SCRIPT_ROOT="$(cd "$(dirname ${SCRIPT_LIB})"; pwd)"
    SCRIPT_BIN="${SCRIPT_ROOT}/bin"
    SCRIPT_ETC="${SCRIPT_ROOT}/etc"

    # Command-line options
    SCRIPT_DEBUG=0
    SCRIPT_INTERACTIVE=0
    while getopts ":id" opt; do
        case "$opt" in
        d) SCRIPT_DEBUG=1
            ;;
        i) SCRIPT_INTERACTIVE=1
            ;;
        esac
    done

    # Temp directory
    SCRIPT_TEMP="$(mktemp -d)"
    SCRIPT_NOTIFY_ON_FATAL=1

    return 0
}

##
# Message to indicate the script is starting
#
function scriptStart
{
    echo -e "\n\033[1m[$$]#.\033[0m"
    echo -e "\033[1m[$$]####.\033[0m"
    echo -e "\033[1m[$$]#######  ${SCRIPT_NAME} - $(date -u +%FT%T%z)\033[0m"
    echo -e "\033[1m[$$]####'\033[0m"
    echo -e "\033[1m[$$]#'\033[0m"
    return 0
}

##
# Output the total runtime of the script
#
function scriptFinal
{
    local now=$(date -u +%s)
    local runtime=$(expr ${now} - ${SCRIPT_START})
    echo -e "\n\033[1m[$$]#######\033[0m"
    echo -e "\033[1m[$$]#######  ${SCRIPT_NAME} - ${runtime} seconds\033[0m"
    echo -e "\033[1m[$$]#######\033[0m"
    echo -e "\033[1m[$$]#######\033[0m"
    return 0
}

##
# Try to prevent multiple invocations
#
function lockAcquire()
{
    scriptMessage "Trying to acquire a script lock"
    SCRIPT_LOCKFILE="$SCRIPT_TEMP/${SCRIPT_NAME}-$(hostname -s)-lock"
    if mkdir "${SCRIPT_LOCKFILE}"; then
        scriptMessage "Acquired a script lock; updating perms for emergency removal"
        chown ${USER}:${SCRIPT_GROUP} "${SCRIPT_LOCKFILE}" && chmod g+ws "${SCRIPT_LOCKFILE}"
    else
        scriptFatal "Failed to acquire a script lock (${SCRIPT_LOCKFILE} already exists)."
    fi
}

##
# Try to prevent multiple invocations
#
function lockRelease()
{
    scriptMessage "Trying to remove a script lock (${SCRIPT_LOCKFILE})."
    rmdir "${SCRIPT_LOCKFILE}"
}



script_init || exit 1
