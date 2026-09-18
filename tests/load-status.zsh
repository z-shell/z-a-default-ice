#!/usr/bin/env zsh
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et
#
# The annex entry file must end with status 0 after registering its hooks and
# initializing its statistics (#4).

builtin emulate -R zsh
setopt pipe_fail

fail() {
  builtin print -u2 -r -- "not ok - $1"
  exit 1
}

typeset plugin_file="${ZI_TEST_CHECKOUT:-${0:A:h:h}}/z-a-default-ice.plugin.zsh"
[[ -r $plugin_file ]] || fail "plugin file not found: $plugin_file"

typeset out
out="$( zsh -f -c '
  typeset -a registrations
  @zi-register-annex() { registrations+=( "$2" ); }
  builtin source "$1"
  integer rc=$?
  builtin print -r -- "status=$rc registrations=${(j:,:)registrations}"
  local key
  for key in existing-ices executions applied-ices type-snippet type-plugin; do
    builtin print -r -- "stat:$key=${Plugins[DEFAULT_ICE_stats:$key]-missing}"
  done
' _ "$plugin_file" 2>&1 )" || fail "probe shell failed: $out"

typeset -a lines
lines=( "${(@f)out}" )
[[ ${lines[1]} == "status=0 registrations=hook:preinit-3,subcommand:default-ice" ]] ||
  fail "expected status 0 with both registrations, got '${lines[1]}'"
typeset line
for line in "${lines[@]:1}"; do
  [[ $line == stat:*=0 ]] || fail "statistics must start at 0, got '$line'"
done
(( $#lines == 6 )) || fail "expected five statistics, got $(( $#lines - 1 ))"

builtin print -r -- "ok - the entry file registers its hooks, zeroes its statistics, and returns status 0"
