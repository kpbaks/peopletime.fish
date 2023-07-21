set -l scriptdir (path dirname (status filename))
set -l file $scriptdir/../functions/peopletime.fish
test -f $file; or exit
source $file


set -l ms 1
set -l s (math "1000 * $ms")
set -l m (math "60 * $s")
set -l h (math "60 * $m")
set -l d (math "24 * $h")
set -l y (math "365 * $d")

@test millisecond (peopletime 1) = 1ms
@test second (peopletime $s) = 1s
@test minute (peopletime $m) = 1m
@test hour (peopletime $h) = 1h
@test day (peopletime $d) = 1d
# @test week (peopletime (math "1000 * 60 * 60 * 24 * 7")) = 1w
# @test month (peopletime (math "1000 * 60 * 60 * 24 * 30")) = 1mo
@test year (peopletime $y) = 1y

@test "1s 1ms" \
    (peopletime (math "$s + $ms")) = "1s 1ms"
@test "7s 50ms" \
    (peopletime (math "7 * $s + 50 * $ms")) = "7s 50ms"
@test "1m 1s" (peopletime \
(math "$m + $s")) = "1m 1s"
@test "1m 1s 1ms" \
    (peopletime (math "$m + $s + $ms")) = "1m 1s 1ms"
@test "1h 1m" \
    (peopletime (math "$h + $m")) = "1h 1m"
@test "1h 1m 1s" \
    (peopletime (math "$h + $m + $s")) = "1h 1m 1s"
@test "1h 1m 1s 1ms" \
    (peopletime (math "$h + $m + $s + $ms")) = "1h 1m 1s 1ms"
@test "1d 1h" \
    (peopletime (math "$d + $h")) = "1d 1h"
@test "1d 1h 1m" \
    (peopletime (math "$d + $h + $m")) = "1d 1h 1m"
@test "1d 1h 1m 1s" \
    (peopletime (math "$d + $h + $m + $s")) = "1d 1h 1m 1s"
@test "1d 1h 1m 1s 1ms" \
    (peopletime (math "$d + $h + $m + $s + $ms")) = "1d 1h 1m 1s 1ms"
@test "1y 1d" \
    (peopletime (math "$y + $d")) = "1y 1d"
@test "1y 1d 1h" \
    (peopletime (math "$y + $d + $h")) = "1y 1d 1h"
@test "1y 1d 1h 1m" \
    (peopletime (math "$y + $d + $h + $m")) = "1y 1d 1h 1m"
@test "1y 1d 1h 1m 1s" \
    (peopletime (math "$y + $d + $h + $m + $s")) = "1y 1d 1h 1m 1s"
@test "1y 1d 1h 1m 1s 1ms" \
    (peopletime (math "$y + $d + $h + $m + $s + $ms")) = "1y 1d 1h 1m 1s 1ms"

# @test "2023y 55d 12h 37m 0s 969ms" (peopletime (math "2023 * $y + 55 * $d + 12 * $h + 37 * $m + 969 * $ms")) = "2023y 55d 12h 37m 0s 969ms"
@test pie (peopletime 11655900) = "3h 14m 15s 900ms"

@test "1 second 1 millisecond" \
    (peopletime --long (math "$s + $ms")) = "1 second 1 millisecond"
@test "1 second 999 milliseconds" \
    (peopletime --long (math "$s + 999 * $ms")) = "1 second 999 milliseconds"
@test "59 seconds 999 milliseconds" \
    (peopletime --long (math "59 * $s + 999 * $ms")) = "59 seconds 999 milliseconds"
@test "1 minute 1 second" \
    (peopletime --long (math "$m + $s")) = "1 minute 1 second"
@test "1 minute 1 second 1 millisecond" \
    (peopletime --long (math "$m + $s + $ms")) = "1 minute 1 second 1 millisecond"
@test "59 minutes 59 seconds 999 milliseconds" \
    (peopletime --long (math "59 * $m + 59 * $s + 999 * $ms")) = "59 minutes 59 seconds 999 milliseconds"
@test "1 hour 1 minute" \
    (peopletime --long (math "$h + $m")) = "1 hour 1 minute"
@test "1 hour 1 minute 1 second" \
    (peopletime --long (math "$h + $m + $s")) = "1 hour 1 minute 1 second"
@test "1 hour 1 minute 1 second 1 millisecond" \
    (peopletime --long (math "$h + $m + $s + $ms")) = "1 hour 1 minute 1 second 1 millisecond"
@test "23 hours 59 minutes 59 seconds 999 milliseconds" \
    (peopletime --long (math "23 * $h + 59 * $m + 59 * $s + 999 * $ms")) = "23 hours 59 minutes 59 seconds 999 milliseconds"
@test "1 day 1 hour" \
    (peopletime --long (math "$d + $h")) = "1 day 1 hour"
@test "1 day 1 hour 1 minute" \
    (peopletime --long (math "$d + $h + $m")) = "1 day 1 hour 1 minute"
@test "1 day 1 hour 1 minute 1 second" \
    (peopletime --long (math "$d + $h + $m + $s")) = "1 day 1 hour 1 minute 1 second"
@test "1 day 1 hour 1 minute 1 second 1 millisecond" \
    (peopletime --long (math "$d + $h + $m + $s + $ms")) = "1 day 1 hour 1 minute 1 second 1 millisecond"
@test "364 days 23 hours 59 minutes 59 seconds 999 milliseconds" \
    (peopletime --long (math "364 * $d + 23 * $h + 59 * $m + 59 * $s + 999 * $ms")) = "364 days 23 hours 59 minutes 59 seconds 999 milliseconds"



@test "1 year 1 day" \
    (peopletime --long (math "$y + $d")) = "1 year 1 day"
@test "1 year 1 day 1 hour" \
    (peopletime --long (math "$y + $d + $h")) = "1 year 1 day 1 hour"
@test "1 year 1 day 1 hour 1 minute" \
    (peopletime --long (math "$y + $d + $h + $m")) = "1 year 1 day 1 hour 1 minute"
@test "1 year 1 day 1 hour 1 minute 1 second" \
    (peopletime --long (math "$y + $d + $h + $m + $s")) = "1 year 1 day 1 hour 1 minute 1 second"
@test "1 year 1 day 1 hour 1 minute 1 second 1 millisecond" \
    (peopletime --long (math "$y + $d + $h + $m + $s + $ms")) = "1 year 1 day 1 hour 1 minute 1 second 1 millisecond"
@test "999 years 364 days 23 hours 59 minutes 59 seconds 999 milliseconds" (peopletime --long (math "999 * $y + 364 * $d + 23 * $h + 59 * $m + 59 * $s + 999 * $ms")) = "999 years 364 days 23 hours 59 minutes 59 seconds 999 milliseconds"




# @test "scale=1 seconds" (peopletime 60) = 0.1s
# @test "seconds" (peopletime 1000) = 1s
# @test "minutes" (peopletime 60000) = 1m
# @test "hours" (peopletime 3600000) = 1h
# @test "hours seconds" (peopletime 3601000) = "1h 1s"
# @test "hours minutes" (peopletime 3660000) = "1h 1m"
# @test "hours minutes seconds" (peopletime 3661000) = "1h 1m 1s"
# @test "pie" (peopletime 11655900) = "3h 14m 15.9s"
