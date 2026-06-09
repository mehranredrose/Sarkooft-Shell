# Sarkooft-Shell

A brutal Bash/Zsh script that roasts your terminal typos in beautifully formatted, RTL-compliant Persian.

This is a Persian fork of the legendary [bash-insulter](https://github.com/hkbakke/bash-insulter).

---

## Features

* **Authentic Roasts:** Contains a collection of classic Persian slangs and burns tailored for your command-line failures.
* **Smart RTL Support:** Uses a clever `rev` implementation so Persian text renders perfectly right-to-left without flipping your English `$USER` name or breaking terminal formatting.
* **Double-Source Protection:** Prevents infinite recursive loops if your shell configuration is sourced multiple times.
* **Merciful Logic:** Only triggers about 50% of the time to keep you on your toes without making you completely lose your mind.

---

## Installation & Usage

Getting roasted by your own machine is incredibly simple.

### 1. Clone or Download

Copy the script code into a file named `.sarkooft.sh` in your home directory, or just append it directly to your shell configuration.

### 2. Add to your Shell Config

Open your `~/.bashrc` or `~/.zshrc` file:

```bash
# Open with your favorite editor
nano ~/.bashrc  # or nano ~/.zshrc

```

Add the following line at the very end of the file:

```bash
[[ -f ~/.sarkooft.sh ]] && source ~/.sarkooft.sh

```

### 3. Apply Changes

Restart your terminal or manually source the configuration:

```bash
source ~/.bashrc  # or source ~/.zshrc

```

Now, go ahead and type a non-existent command like `gti status` or `sl` to see it in action!
