class oracle_prereqs::packages {

  package { ["binutils-devel",
             "elfutils-libelf",
             "glibc",
             "glibc-common",
             "libaio",
             "libgcc",
             "libstdc++",
             "make",
             "gcc",
             "gcc-c++",
             "libaio-devel",
             "libstdc++-devel",
             "unixODBC",
             "unixODBC-devel",
             "sysstat"]: ensure => installed
  }

}