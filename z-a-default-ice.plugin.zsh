# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et
#
# Copyright (c) 2019 Sebastian Gniazdowski
# Copyright (c) 2021 Z-Shell Community
#
# According to the Zsh Plugin Standard:
# https://z.digitalclouds.dev/community/zsh_plugin_standard#zero-handling
0="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"
0="${${(M)0:#/*}:-$PWD/$0}"

# https://z.digitalclouds.dev/community/zsh_plugin_standard#funtions-directory
if [[ $PMSPEC != *f* ]] {
    fpath+=( "${0:h}/functions" )
}

# Standard hash for plugins:
# https://z.digitalclouds.dev/community/zsh_plugin_standard#standard-plugins-hash
typeset -gA Plugins
Plugins[DEFAULT_ICE_DIR]="${0:h}"

# https://z.digitalclouds.dev/community/zsh_plugin_standard#the-proposed-function-name-prefixes
autoload -Uz →za-default-ice-preinit-handler \
→za-default-ice-main-cmd-help-handler \
→za-default-ice-main-cmd \
.za-default-ice-show-default-ices \
.za-default-ice-stats

# An empty stub to fill the help handler fields
→za-default-ice-null-handler() { :; }

# The unscoping-support hook.
@zi-register-annex "z-a-default-ice" hook:preinit-3 \
  →za-default-ice-preinit-handler \
  →za-default-ice-null-handler

# The subcommand `meta'.
@zi-register-annex "z-a-default-ice" subcommand:default-ice \
  →za-default-ice-main-cmd \
  →za-default-ice-main-cmd-help-handler

(( Plugins[DEFAULT_ICE_stats:existing-ices] = 0 ))
(( Plugins[DEFAULT_ICE_stats:executions] = 0 ))
(( Plugins[DEFAULT_ICE_stats:applied-ices] = 0 ))
(( Plugins[DEFAULT_ICE_stats:type-snippet] = 0 ))
(( Plugins[DEFAULT_ICE_stats:type-plugin] = 0 ))
