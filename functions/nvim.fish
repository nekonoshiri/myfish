function nvim
  if set -q VIM; and command -sq nvr
    nvr -s $argv
  else if command -sq nvim
    command nvim $argv
  else
    echo 'nvim: Could not find nvim'
    return 1
  end
end
