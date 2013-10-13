# NAME

Lola - The Local-Language Environment Manager

# SYNOPSIS

    $ lola set py=2.5.6         # Use Python 2.5.6 for this shell session
    $ lola set p5=5.14.0 .      # Use Perl 5.14.0 under this directory
    $ lola set rb=1.9 ~         # Use Ruby 1.9 when run under $HOME
    $ lola help                 # Get lola command help
    $ lola ??                   # Show info for all languages
    $ lola p5                   # Set Perl5 as default language for commands
    $ lola ?                    # Show info for current language (Perl5)
    $ lola install 5.18.1       # Install Perl 5.18.1

# DESCRIPTION

Lola is a generic "Lo"cal "la"nguage environment manager. It lets you:

* Install Bash, Node, Perl(5 & 6), Python(2 & 3), Ruby and many more
* Install programming languages locally (per user, under $HOME, no sudo)
* Install multiple runtimes (versions) of each programming language
* Switch between language runtimes easily
* Use specific language runtimes, per project (per directory)
* Install packages (gems, modules, libraries) per language/runtime
* Install pkgsets (named sets of packages)
* Switch to specific pkgsets, per project
* Install plugins. Pluggable language and feature support
* Run a single command in a specific environment

In other words, for a given directory (and all directories below it) use
specific runtimes of the programming languages you need, and make specific
packages available to each programming language.

Lola is written for developers, so it not only supports multiple
languages, but also multiple sets of installed packages (libraries, modules,
gems, etc). So, for example, you can test your Ruby code not only against
multiple `ruby` binaries, but also against certain sets of installed gems.
Lola has special versions of each language's package installer tool, so that
packages can be easily installed into your current environment.

If your project uses more than one language, Lola is the perfect tool for
setting up your test environments. It keeps its settings in directories called
`.lola/`. Each of these contains the current language settings, and the
available package installations, for code run in or below that directory. You
can have many of these directories as you want.

Lola can easily script out test scenarios:

    for v in 1.8 1.9 2.0; do
        for p in A B C; do
            lola run rb=$v@$p ruby test.rb
        done
    done

# PREREQUISITES

Bash 3.2::
    Lola is written entirely in Bash, and uses `/bin/bash` (since it manages
    local Bash versions too). Modern Bash is 4.2+ but MacOSX still clings to
    3.2 so we use that. (Works fine under other shells like `zsh`).

build-essentials::
    Whatever system tools the various languages require to compile and install
    things. (gcc, make, etc).

curl or wget::
    For fetching things from the web.

rsync:
    For syncing files.

git::
    Used to install Lola and Lola plugins. Also used to read/write config
    files.

# INSTALLATION

Installing Lola is just getting the Lola source code, putting it somewhere,
and then telling your shell where it is. For example:

    git clone --recursive git@github.com:acmeism/lola ~/src/lola

Add a line like this to your shell startup file (Like ~/.bashrc for Bash):

    . ~/src/lola/bin/lola-init

All your languages and packages get installed in the directory in the LOLA_ROOT
variable. The default is LOLA_ROOT=~/.lola but you can override it, by using a
startup line like this:

    LOLA_ROOT=/path/lola/root . ~/src/lola/bin/lola-init

Warning: Once you start installing languages, you can't easily move the
LOLA_ROOT directory, so choose it wisely. See CONFIGURATION below.

# PLUGIN INSTALLATION

Most of the functionality of Lola comes from Lola plugins. There are a bunch
of plugins that come preinstalled. You can easily find and install new ones
too. Plugins can be enabled, disabled and removed too.

    lola plugin find        # List all known plugins repo urls
    lola plugin add <plugin-git-repo-url>

See PLUGIN COMMANDS below.

# UPGRADING

You can upgrade to the latest versions of Lola and plugins with this command:

    lola upgrade

This is effectively the same as:

    (
        cd $LOLA_SRC
        git pull --recurse-submodules origin master
        lola update
    )

# CONFIGURATION

A Lola setup is based on a few environment variables. The `lola-init` script
used above, sets default values for these (if they are not already set):

`LOLA_SRC`::
    The source code directory for Lola. If you cloned Lola from GitHub, set
    this variable to the path of the `lola` git repo.

`LOLA_ROOT`::
    The directory where all the language specific components live. Since
    languages get built and installed here, it is very likely that if you move
    this directory later, things will not work.

# COMMANDS

Lola strives to have simple, intuitive command usage. Tab completion is fully
suported. Common command terms have alias symbols. You can even use the
`lola-shell` for interactive usage. Or, you can script lola commands with
explicit arguments for readability.

## COMMAND OPTIONS AND ARGUMENTS

The following options and common arguments apply to many commands:

`-q`:: Command output should be more quiet.

`-v`:: Command output should be more verbose.

`<lid>`::
    Language ID. Every supported language has an id (generally 2-4 lowercase
    chars), like `p5` for Perl. There is a default lid which gets set by
    certain commands, and you can always override the value for commands that
    need a lid.

`<runtime>`::
    This is a tag referring to a specific runtime installation of a specific
    programming language.

`<pkgset>`::
    A named set of installed/available packages.

## COMMON COMMANDS

`lola`::
    With no arguments, Lola will run `lola shell` by default (configurable).
    The shell will display useful startup info. Press <ctrl>-d to exit.

`lola -? | -h`::
    Show short help.

`lola help`::
    Show the Lola documentation (manpage).

`lola <lid>`::
    Same as `lola lang <lid>; lola show <lid>`.

`lola lang <lid>`::
    Set the default language-id for commands to use.

`lola show [<section-id> ...]`::
    Show everything about the current Lola environment. Optionally, you can
    name specific sections to report on.

`lola install <runtime>=[<lid>]`::
    Install (fetch code and build locally) a specific runtime of a programming
    language. Remember to use tab completion to see the available options.

`lola set <lid>=<runtime>[@<pkgset>] [<dir-path>]`::
    Use a specific language (and optionally a specific package set). If
    `<dir-path>` is specified, save the settings in that directory, else
    modify the current shell.

## PACKAGE SET COMMANDS

You can create, manage and use named sets of installed packages.

`lola pkg add [<runtime>@]<set-name>`::
    Create a new package set for a specific language installation.

## LESS COMMON COMMANDS

`lola upgrade [ (lola | plugin-name) ...]`::
    Upgrade Lola components. You can do everything or just specific
    components.

`lola rebuild`::
    Make everything in Lola up-to-date internally. Checks your configuration,
    and rebuilds anything necessary, including the shim files.

## PLUGIN COMMANDS

`lola plugin`::
    List the Lola plugins in use.

`lola plugin find`::
    List the names, descriptions and urls of all known Lola plugins.

`lola plugin add <lola-plugin-git-repo-url>`::
    Add a Lola plugin.

`lola enable/disable <plugin-name>`::
    Enable or disable a given plugin.

`lola remove <plugin-name>`::
    Remove a given plugin altogether.

## CONFIG COMMANDS

`lola config`::
    Show the current Lola configuration.

`lola config key`::
    Show the current setting of a config key.

`lola config key value`::
    Set a config key to a value.

## PRIOR ART

Lola is heavily inspired by many local language installers that came before it,
including [rbenv], [PerlBrew] and [NVM]. These tools all have their strengths
and weaknesses.

Lola attempts to improve on all of these, and offer the same consistent set of
features to all languages at once. Using the simple plugin system, new
languages can easily be added.
