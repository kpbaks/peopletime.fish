function peopletime --description "Turn milliseconds into a human-readable string"
    set -l options (fish_opt --short=h --long=help)
    set -a options (fish_opt --short=l --long=long)
    if not argparse $options -- $argv
        return 1
    end

    if set --query _flag_help
        set -l usage "$(set_color --bold)Turn milliseconds into a human-readable string$(set_color normal)

$(set_color yellow)Usage:$(set_color normal) $(set_color blue)$(status current-command)$(set_color normal) [options]

$(set_color yellow)Arguments:$(set_color normal)

$(set_color yellow)Options:$(set_color normal)
	$(set_color green)-h$(set_color normal), $(set_color green)--help$(set_color normal)      Show this help message and exit
$(set_color green)	-l$(set_color normal), $(set_color green)--long$(set_color normal)      Show time units in long format. 'days' instead of 'd' etc."

        echo $usage
        return 0
    end

    set -l ms $argv[1]

    if not string match --quiet --regex '^[0-9]+$' $ms
        printf "%sinvalid argument:%s argument must be a positive integer, but is %s%s%s\n\n" (set_color red) (set_color normal) (set_color yellow) $ms (set_color normal)

        eval "$(status current-function) --help"
        return 1
    end

    set -l str

    # Format the duration in dynamic units
    # duration is in ms
    set -l t (math --scale=0 $ms / 1000)

    # NOTE: <kpbaks 2023-07-19 11:12:58> --scale=0 is used to round the result
    set -l years (math --scale=0 $t / 60 / 60 / 24 / 7 / 4 / 12)
    if test $years -gt 0
        if not set --query _flag_long
            set --append str $years"y"
        else
            if test $years -eq 1
                set --append str "1 year"
            else
                set --append str "$years years"
            end
        end
        set t (math "$t - $years * 60 * 60 * 24 * 365")
    end
    # set -l months (math --scale=0 $t / 60 / 60 / 24 / 7 / 4)
    # if test $months -gt 0
    #     if not set --query _flag_long
    #         set --append str $months"m"
    #     else
    #         if test $months -eq 1
    #             set --append str "1 month"
    #         else
    #             set --append str "$months months"
    #         end
    #     end
    #     set t (math "$t - $months * 60 * 60 * 24 * 7 * 4")
    # end
    #
    # set -l weeks (math --scale=0 $t / 60 / 60 / 24 / 7)
    # if test $weeks -gt 0
    #     if not set --query _flag_long
    #         set --append str "$weeks w"
    #     else
    #         if test $weeks -eq 1
    #             set --append str "1 week"
    #         else
    #             set --append str "$weeks weeks"
    #         end
    #     end
    #     set t (math "$t - $weeks * 60 * 60 * 24 * 7")
    #
    # end

    set -l days (math --scale=0 $t / 60 / 60 / 24)
    if test $days -gt 0
        if not set --query _flag_long
            set --append str $days"d"
        else
            if test $days -eq 1
                set --append str "1 day"
            else
                set --append str "$days days"
            end
        end
        set t (math "$t - $days * 60 * 60 * 24")
    end

    set -l hours (math --scale=0 $t / 60 / 60 % 24)
    if test $hours -gt 0
        if not set --query _flag_long
            set --append str $hours"h"
        else
            if test $hours -eq 1
                set --append str "1 hour"
            else
                set --append str "$hours hours"
            end
        end
        set t (math "$t - $hours * 60 * 60")
    end

    set -l minutes (math --scale=0 $t / 60 % 60)
    if test $minutes -gt 0
        if not set --query _flag_long
            set --append str $minutes"m"
        else
            if test $minutes -eq 1
                set --append str "1 minute"
            else
                set --append str "$minutes minutes"
            end
        end
        set t (math "$t - $minutes * 60")
    end

    set -l seconds (math --scale=0 $t % 60)
    if test $seconds -gt 0
        if not set --query _flag_long
            set --append str $seconds"s"
        else
            if test $seconds -eq 1
                set --append str "1 second"
            else
                set --append str "$seconds seconds"
            end
        end
        set t (math $t - $seconds)
    end

    set -l milliseconds (math --scale=0 $ms % 1000)
    if test $milliseconds -gt 0
        if not set --query _flag_long
            set --append str $milliseconds"ms"
        else
            if test $milliseconds -eq 1
                set --append str "1 millisecond"
            else
                set --append str "$milliseconds milliseconds"
            end
        end
    end



    string join -- ' ' $str

    # set -l secs (math --scale=0 $ms / 1000)
    # set -l mins (math --scale=0 $secs / 60)
    # set -l hours (math --scale=0 $mins / 60)
    # set -l days (math --scale=0 $hours / 24)
    # set -l weeks (math --scale=0 $days / 7)
    # set -l months (math --scale=0 $weeks / 4)
    # set -l years (math --scale=0 $months / 12)
    #
    # set -l out ""
    #
    #
    #
    # test $years -gt 0; and set -a out "$years y"
    # test $months -gt 0; and set -a out "$months m"
    # test $weeks -gt 0; and set -a out "$weeks w"
    # test $days -gt 0; and set -a out "$days d"
    # test $hours -gt 0; and set -a out "$hours h"
    # test $mins -gt 0; and set -a out "$mins m"
    # test $secs -gt 0; and set -a out "$secs s"
    # test $ms -gt 0; and set -a out "$ms ms"
    #
    #
    # echo $out

end
