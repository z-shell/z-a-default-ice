# Copyright (c) 2019 Sebastian Gniazdowski
# Copyright (c) 2021 Z-Shell ZI Contributors
#
# According to the Zsh Plugin Standard:
# https://github.com/z-shell/zi/wiki/Zsh-Plugin-Standard#1-standardized-0-handling

0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

# Standard hash for plugins:
# https://github.com/z-shell/zi/wiki/Zsh-Plugin-Standard#standard-plugins-hash
typeset -gA Plugins
Plugins[DEFAULT_ICE_DIR]="${0:h}"

autoload -Uz za-default-ice-preinit-handler \
za-default-ice-main-cmd-help-handler \
za-default-ice-main-cmd \
za-default-ice-show-default-ices \
za-default-ice-stats

# An empty stub to fill the help handler fields
za-default-ice-help-null-handler() { :; }

# The unscoping-support hook.
@zi-register-annex "z-a-default-ice" hook:preinit-3 \
za-default-ice-preinit-handler \
za-default-ice-help-null-handler

# The subcommand `meta'.
@zi-register-annex "z-a-default-ice" \
subcommand:default-ice \
za-default-ice-main-cmd \
za-default-ice-main-cmd-help-handler

(( Plugins[DEFAULT_ICE_stats:existing-ices] = 0 ))
(( Plugins[DEFAULT_ICE_stats:executions] = 0 ))
(( Plugins[DEFAULT_ICE_stats:applied-ices] = 0 ))
(( Plugins[DEFAULT_ICE_stats:type-snippet] = 0 ))
(( Plugins[DEFAULT_ICE_stats:type-plugin] = 0 ))
