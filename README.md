# Ronin

* [ronin.rubyforge.org](http://ronin.rubyforge.org)
* [github.com/ronin-ruby/ronin](http://github.com/ronin-ruby/ronin)
* [github.com/ronin-ruby/ronin/issues](http://github.com/ronin-ruby/ronin/issues)
* [groups.google.com/group/ronin-ruby](http://groups.google.com/group/ronin-ruby)
* irc.freenode.net #ronin

## Description

Ronin is a Ruby platform for exploit development and security research.
Ronin allows for the rapid development and distribution of code, exploits
or payloads over many common Source-Code-Management (SCM) systems.

### Ruby

Ronin's Ruby environment allows security researchers to leverage Ruby with
ease. The Ruby environment contains a multitude of convenience methods
for working with data in Ruby, a Ruby Object Database, a customized Ruby
Console and an extendable command-line interface.

### Extend

Ronin's more specialized features are provided by additional Ronin
libraries, which users can choose to install. These libraries can allow
one to write and run Exploits and Payloads, scan for PHP vulnerabilities,
perform Google Dorks  or run 3rd party scanners.

### Publish

Ronin allows users to publish and share code, exploits, payloads or other
data via Overlays. Overlays are directories of code and data that can be
hosted on any SVN, Hg, Git or Rsync server. Ronin makes it easy to create,
install or update Overlays.

## Features

* Supports installing/updating/uninstalling of Overlays.
  * Supports accessing Overlays from various media types:
    * [Subversion (SVN)](http://subversion.tigris.org/)
    * [Mercurial (Hg)](http://mercurial.selenic.com/)
    * [Git](http://git-scm.com/)
    * Rsync
* Allows for the loading of Extensions from one or more Overlays.
* Provides Object Database using [DataMapper](http://datamapper.org)
  with:
  * {Ronin::Author}
  * {Ronin::License}
  * {Ronin::Arch}
  * {Ronin::OS}
  * {Ronin::Software}
  * {Ronin::Vendor}
  * {Ronin::Address}
    * {Ronin::MACAddress}
    * {Ronin::IPAddress}
    * {Ronin::HostName}
  * {Ronin::Port}
    * {Ronin::TCPPort}
    * {Ronin::UDPPort}
  * {Ronin::Service}
  * {Ronin::OpenPort}
  * {Ronin::OSGuess}
  * {Ronin::UserName}
  * {Ronin::URL}
  * {Ronin::EmailAddress}
  * {Ronin::Credential}
  * {Ronin::ServiceCredential}
  * {Ronin::Organization}
  * {Ronin::Campaign}
  * {Ronin::Target}
* Caches and mirrors Objects stored in Overlays using DataMapper.
* Convenience methods provided by
  [ronin-support](http://github.com/ronin-ruby/ronin-support#readme).
* Provides a customized Ruby Console with:
  * Tab-completion enabled.
  * Auto-indentation enabled.
  * Pretty-Print loaded.
  * `print_info`, `print_error`, `print_warning` and `print_debug`
    output helper methods with color-output.
* Provides an extendable command-line interface based on
  [Thor](http://github.com/wycats/thor#readme).

## Synopsis

Install an Overlay:

    $ ronin install svn://example.com/path/to/overlay

List installed Overlays:

    $ ronin list

Update all installed Overlays:

    $ ronin update

Update a specific Overlay:

    $ ronin update overlay-name

Uninstall an Overlay:

    $ ronin uninstall overlay-name

List available Databases:

    $ ronin database

Add a new Database:

    $ ronin database --add team --uri mysql://user:pass@vpn.example.com/db

Remove a Database:

    $ ronin database --remove team

Start the Ronin console:

    $ ronin

View available commands:

    $ ronin help

## Requirements

* [ActiveSupport](http://rubygems.org/gems/activesupport) >= 3.0.0
* [DataMapper](http://datamapper.org/):
  * [dm-do-adapter](http://github.com/datamapper/dm-do-adapter) ~> 1.0.0
  * [dm-sqlite-adapter](http://github.com/datamapper/dm-sqlite-adapter)
    ~> 1.0.0
    * [libsqlite3](http://sqlite.org/)
  * [dm-core](http://github.com/datamapper/dm-core) ~> 1.0.0
  * [dm-types](http://github.com/datamapper/dm-types) ~> 1.0.0
  * [dm-migrations](http://github.com/datamapper/dm-migrations) ~> 1.0.0
  * [dm-validations](http://github.com/datamapper/dm-validations) ~> 1.0.0
  * [dm-aggregates](http://github.com/datamapper/dm-aggregates) ~> 1.0.0
  * [dm-timestamps](http://github.com/datamapper/dm-timestamps) ~> 1.0.0
  * [dm-tags](http://github.com/datamapper/dm-tags) ~> 1.0.0
* [dm-is-predefined](http://github.com/postmodern/dm-is-predefined/)
  ~> 0.3.0
* [nokogiri](http://nokogiri.rubyforge.org/) ~> 1.4.1
  * [libxml2](http://xmlsoft.org/)
  * [libxslt1](http://xmlsoft.org/XSLT/)
* [open_namespace](http://github.com/postmodern/open_namespace) ~> 0.3.0
* [parameters](http://github.com/postmodern/parameters) ~> 0.2.2
* [data_paths](http://github.com/postmodern/data_paths) ~> 0.2.1
* [contextify](http://github.com/postmodern/contextify/) ~> 0.1.6
* [pullr](http://github.com/postmodern/pullr/) ~> 0.1.2
* [thor](http://github.com/wycats/thor/) ~> 0.14.0
* [ronin-support](http://github.com/ronin-ruby/ronin-support/) ~> 0.1.0

## Install

    $ sudo gem install ronin

## Additional Libraries

### Ronin ASM

[Ronin ASM](http://github.com/ronin-ruby/ronin-asm#readme) is a
Ruby library for Ronin that provides dynamic Assembly (ASM) generation of
programs or shellcode.

### Ronin Dorks

[Ronin Dorks](http://github.com/ronin-ruby/ronin-dorks#readme) is a
Ruby library for Ronin that provides support for various Google (tm) Dorks
functionality.

### Ronin Exploits

[Ronin Exploits](http://github.com/ronin-ruby/ronin-exploits#readme) is a
Ruby library for Ronin that provides exploitation and payload crafting
functionality.

### Ronin Gen

[Ronin Gen](http://github.com/ronin-ruby/ronin-gen#readme) is a Ruby library
for Ronin that provides various generators.

### Ronin SQL

[Ronin SQL](http://github.com/ronin-ruby/ronin-sql#readme) is a Ruby library
for Ronin that provids support for SQL related security tasks, such as
scanning for and exploiting SQL injections.

### Ronin PHP

[Ronin PHP](http://github.com/ronin-ruby/ronin-php#readme) is a Ruby library
for Ronin that provides support for PHP related security tasks, such as
finding and exploiting Local File Inclusion (LFI) and
Remote File Inclusion (RFI).

### Ronin Web

[Ronin Web](http://github.com/ronin-ruby/ronin-web#readme) is a Ruby library
for Ronin that provides support for web scraping and spidering
functionality.

## License

Ronin - A Ruby platform for exploit development and security research.

Copyright (c) 2006-2010 Hal Brodigan (postmodern.mod3 at gmail.com)

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
