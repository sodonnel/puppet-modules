# Ruby Dependencies

These are all defined in the gemfile and can be installed as usual

    $ bundle install

# Spec Setup

rspec-puppet expects to find all the puppet manifests in the fixtures directory, spec/fixtures/modules/<current module name>. To facilitate this, the current module manifests directory is symlinked from spec/fixtures/modules/<current module name>/manifests to the actual source code.

This works fine, except if the module has other dependencies - in this case, you need to define the dependencies in the Puppetfile at the root of the module.

When you run `rake spec`, the Puppetfile is read, and any dependent modules are installed into the spec/fixtures/modules directory.

The contents of spec/fixtures is excluded from source control using the .gitignore. Therefore, if you make a fresh clone of the repo, you need to run:

    $ rspec-puppet-init

This will recreate the symlinks in the fixtures directory for the current module. Running:

    $ rake spec

Will copy in any depended modules.

