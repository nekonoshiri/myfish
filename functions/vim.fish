function vim
  if command -sq nvim
    # call nvim.fish
    nvim $argv
  else if command -sq vim
    command vim $argv
  else if command -sq vi
    command vi $argv
  else
    echo 'vi/vim: Could not find vi/vim'
    return 1
  end
end
