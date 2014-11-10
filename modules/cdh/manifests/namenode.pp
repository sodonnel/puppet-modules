class cdh::namenode(
  $namenodehostname = namenode,
  $hostentries      = {},
)
{

  class { 'cdh::hosts':
    entries => $hostentries
  }
  
  class {'cdh::config':
    namenodehostname => $namenodehostname
  }

  contain cdh::namenode::install
  contain cdh::namenode::format
  contain cdh::namenode::tmpdir
  contain cdh::namenode::service

  Class['cdh::hosts']                ->
  Class['cdh::namenode::install']    ->
  Class['cdh::config']               ->
  Class['cdh::namenode::format']     ->
  Class['cdh::namenode::service']    ->
  Class['cdh::namenode::tmpdir']

}
