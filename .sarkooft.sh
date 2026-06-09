# ==============================================================================
# Project: Sarkooft-Shell
# Description: A Persian fork of hkbakke/bash-insulter. Roasts your terminal 
#              typos in RTL-compliant Persian while keeping English usernames intact.
# ==============================================================================

print_message () {
    # Local array containing the Persian roasts. 
    # Use 'USER_PLACEHOLDER' where you want the un-reversed English username to appear.
    local messages=(
        "تلاشت قابل تحسین بود! :("
        "این چیه نوشتی آخه؟!!!! :|"
        "اینکاره نیستی مشتی"
        "میدونی که تاثیرات چسیه"
        "اینم بده چت جی پی تی بنویسه عین قبلیا"
        "سیرداغ"
        "نوب سگ !"
        "گند زدی!"
        "خخخخخخخ"
        "مطمئنی بلدی بنویسی ؟"
        "شت!!"
        "پس واسه همینه کسی باهات حال نمیکنه !"
        "این همه زور زدی اینو نوشتی ؟"
        "بنظرم تو جای نوشتن, بخون!"
        "میدونی که باید انگلیسی بنویسی؟"
        "نیگا !"
        "واسه همین املا رو همیشه تک ماده میکردی پس!!!"
        "اسکار تایپیست سال میرسه به... USER_PLACEHOLDER!"
        "قبل از تایپ کردن یه کم فکر کن!!!"
        "واقعا ری استارت کردی نسل نویسنده ها رو!"
    )

    # Override or append custom messages if global arrays are set in your environment
    [[ -n ${CMD_NOT_FOUND_MSGS} ]] && messages=( "${CMD_NOT_FOUND_MSGS[@]}" )
    [[ -n ${CMD_NOT_FOUND_MSGS_APPEND} ]] && messages+=( "${CMD_NOT_FOUND_MSGS_APPEND[@]}" )

    # Execute only ~50% of the time so the user doesn't lose their mind
    if (( RANDOM % 2 == 0 )); then
        # Pick a random roast from the array
        local raw_msg="${messages[RANDOM % ${#messages[@]}]}"
        
        # RTL Fix Phase 1: Reverse the entire string blindly via 'rev' 
        # (This correctly orders Persian text for basic terminals)
        local rev_msg
        rev_msg=$(echo -n "$raw_msg" | rev)
        
        # RTL Fix Phase 2: 'rev' turned 'USER_PLACEHOLDER' into 'REDLOHECALP_RESU'.
        # We swap that ugly reversed token for the normal, left-to-right $USER variable.
        local final_msg="${rev_msg/REDLOHECALP_RESU/$USER}"

        # Print the final result in Bold and Red (\n creates clean spacing)
        printf "\n  $(tput bold; tput setaf 1)${final_msg}$(tput sgr0)\n\n"
    fi
}

# Helper function to check if a shell function already exists
_function_exists () {
    declare -f "$1" > /dev/null 2>&1
    return $?
}

# The core wrapper that triggers our roast and returns the standard error code
_wrap_cmd_not_found() {
    print_message
    return 127 # Standard POSIX "Command not found" exit code
}

# ==============================================================================
# Shell Hook Engine (Supports Bash & Zsh)
# Safely backs up existing handlers to prevent recursion if sourced multiple times.
# ==============================================================================

if [ -n "$BASH_VERSION" ]; then
    # Bash uses 'command_not_found_handle'
    if _function_exists command_not_found_handle; then
        if ! _function_exists orig_command_not_found_handle; then
            eval "orig_command_not_found_handle() { $(declare -f command_not_found_handle); }"
        fi
    else
        orig_command_not_found_handle() { echo "$0: $1: command not found"; }
    fi

    command_not_found_handle() { 
        _wrap_cmd_not_found
        orig_command_not_found_handle "$@"
    }

elif [ -n "$ZSH_VERSION" ]; then
    # Zsh uses 'command_not_found_handler'
    if _function_exists command_not_found_handler; then
        if ! _function_exists orig_command_not_found_handler; then
            eval "orig_command_not_found_handler() { $(declare -f command_not_found_handler); }"
        fi
    else
        orig_command_not_found_handler() { echo "zsh: command not found: $1"; }
    fi

    command_not_found_handler() { 
        _wrap_cmd_not_found
        orig_command_not_found_handler "$@"
    }
fi
