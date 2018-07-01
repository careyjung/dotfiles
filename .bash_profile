# Add '~/bin' and coreutils gnu-bin to '$PATH'
export PATH="$HOME/bin:/usr/local/opt/coreutils/libexec/gnubin:$PATH"

export MANPATH="/usr/local/MacGPG2/share/man:/usr/local/opt/coreutils/libexec/gnuman${MANPATH+:$MANPATH}"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# python virtualenv setup
unset VIRTUALENVWRAPPER_HOOK_DIR
export WORKON_HOME=$HOME/Documents/virtualenvs
export PROJECT_HOME=$HOME/Documents/projects
export VIRTUALENVWRAPPER_WORKON_CD=1
source /usr/local/bin/virtualenvwrapper.sh
