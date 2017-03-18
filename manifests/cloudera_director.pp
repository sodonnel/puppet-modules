node /^standalone.*/ {
  # These variables must be declared in facter.
  # When running through vagrant, they are set in Facter automatically.
  # If not running via vagrant they need to be set manually.
  # $director_version  = '2.3.0'

  class{ 'cdh51java':     } ->
  class{ 'cloudera_director_repo':
    director_version => $director_version
  }                         ->
  class{ 'cloudera_director': }
}

