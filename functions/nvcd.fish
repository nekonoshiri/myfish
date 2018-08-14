function nvcd
  if not command -sq nvr
    echo 'nvcd: Could not find nvr'
    return 1
  end

  if test -n "$argv"
    # concat list by ""
    set path (realpath "$argv")
  else
    set path (pwd)
  end
  if not test -d $path
    echo "nvcd: The directory '$path' does not exist"
    return 1
  end
  nvr -c "cd `='$path'`"
end
