<h1 align="center">
  <a href="https://github.com/z-shell/zi">
    <img src="https://github.com/z-shell/zi/raw/main/docs/images/logo.svg" alt="Logo" width="80" height="80" />
  </a>
❮ ZI ❯ Annex - default-ice
</h1>

## 💡 Wiki 

- [default-ice](https://z.digitalclouds.dev/docs/ecosystem/annexes/default-ice)
- [annexes](https://z.digitalclouds.dev/docs/ecosystem/annexes)

## Introduction

An annex (i.e.: an extension) that allows setting **default ices** for the next `zi` command.
It adds a new subcommand: **default-ice** which has the following synopsis:

```
—— default-ice --help/-h --clear/-c --show/-s --get/-g --quiet/-q --stats/-t
—— default-ice ice1'value1' ice2'value2' ⋯

 Description:
 --help/-h	→      this message
 --show/-s	→      show the currently set default ices
 --clear/-c	→      reset the default ices
 --get/-g	→      return the current ices in Reply hash
 --quiet/-q	→      hide all messages
 --stats/-t	→      show some statistics
```

# Usage with [ZI](https://github.com/z-shell/zi)

```zsh
zi default-ice lucid from"gh-r"

# Will download from gh-r and also use the lucid ice by default.
zi wait for
  sbin        junegunn/fzf-bin \
  sbin"**/pk" peco/peco
```

Currently the `wait''` ice cannot be made default by using this new subcommand.

# Install

Simply load like a regular plugin, i.e.:

```zsh
zi light z-shell/z-a-default-ice
```
