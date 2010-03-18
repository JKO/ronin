#
# Ronin - A Ruby platform for exploit development and security research.
#
# Copyright (c) 2006-2010 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#

require 'ronin/platform/overlay_cache'
require 'ronin/platform/extension_cache'

require 'uri'
require 'extlib'

module Ronin
  module Platform
    #
    # @return [OverlayCache]
    #   The current overlay cache. If no overlay cache is present, the
    #   default overlay will be loaded.
    #
    def Platform.overlays
      @@ronin_overlay_cache ||= OverlayCache.new
    end

    #
    # Adds a new overlay to the overlay cache.
    #
    # @param [Hash] options
    #   Additional options.
    #
    # @option options [String] :path
    #   A pre-existing path to the overlay.
    #
    # @option options [Symbol] :scm
    #   The SCM used by the overlay, may be either `:git`, `:mercurial`,
    #   `:sub_version` or `:rsync`.
    #
    # @option options [String, URI::HTTP, URI::HTTPS] uri
    #   The URI of the overlay.
    #
    # @yield [overlay]
    #   If a block is given, it will be passed the overlay after it has
    #   been added to the cache.
    #
    # @yieldparam [Overlay] overlay
    #   The newly added overlay.
    #
    # @return [Overlay]
    #   The newly added overlay.
    #
    # @raise [ArgumentError]
    #   The `:path` option was not specified.
    #
    # @raise [OverlayNotFound]
    #   The `:path` option did not represent a valid directory.
    #
    def Platform.add!(options={},&block)
      Platform.overlays.add!(Overlay.create!(options),&block)
    end

    #
    # Installs an overlay into the `Config::CACHE_DIR` and adds it
    # to the overlay cache.
    #
    # @param [Hash] options
    #   Additional options.
    #
    # @option options [Addressable::URI, String] :uri
    #   The URI to the overlay.
    #
    # @option options [Symbol] :scm
    #   The SCM used by the overlay. May be either `:git`, `:mercurial`,
    #   `:sub_version` or `:rsync`.
    #
    # @yield [overlay]
    #   If a block is given, it will be passed the overlay, after it has
    #   been installed.
    #
    # @yieldparam [Overlay] overlay
    #   The newly installed overlay.
    #
    # @return [Overlay]
    #   The newly installed overlay.
    #
    # @raise [ArgumentError]
    #   The `:uri` option must be specified.
    #
    def Platform.install!(options={},&block)
      Platform.overlays.add!(Overlay.install(options),&block)
    end

    #
    # Updates all previously installed overlays within the overlay cache.
    #
    # @yield []
    #   If a block is given, it will be called after all overlays have been
    #   updated within the cache.
    #
    # @return [nil]
    #
    def Platform.update!(&block)
      Platform.overlays.update!()

      block.call() if block
      return nil
    end

    #
    # Removes an overlay from the overlay cache, but leaves the contents
    # of the overlay intact.
    #
    # @param [String] name
    #   The name of the overlay to remove.
    #
    # @yield [overlay]
    #   If a block is given, it will be passed the overlay after it has
    #   been removed.
    #
    # @yieldparam [Overlay] overlay
    #   The removed overlay.
    #
    # @return [nil]
    #
    # @raise [OverlayNotFound]
    #   The overlay with the specified name could not be found in the
    #   overlay cache.
    #
    def Platform.remove!(name,&block)
      Platform.overlays.remove!(name,&block)
      return nil
    end

    #
    # Uninstalls an overlay from the overlay cache, and deletes the
    # contents of the overlay.
    #
    # @param [String] name
    #   The name of the overlay to uninstall.
    #
    # @yield []
    #   If a block is given, it will be called after the overlay has been
    #   uninstalled.
    #
    # @return [nil]
    #
    # @raise [OverlayNotFound]
    #   The overlay with the specified name could not be found in the
    #   overlay cache.
    #
    def Platform.uninstall!(name,&block)
      Platform.overlays.uninstall!(name)

      block.call() if block
      return nil
    end

    #
    # @return [Array]
    #   The names of all extensions within the overlays in the overlay
    #   cache.
    #
    def Platform.extension_names
      Platform.overlays.extensions
    end

    #
    # Searches for the extension with the specified name, in all
    # overlays within the overlay cache.
    #
    # @param [String] name
    #   The name of the extension to search for.
    #
    # @return [Boolean]
    #   Specifies whether the overlay cache contains the extension with
    #   the matching name.
    #
    def Platform.has_extension?(name)
      Platform.overlays.has_extension?(name)
    end

    #
    # The extension cache.
    #
    # @return [ExtensionCache]
    #   The extension cache of all currently loaded extensions.
    #
    # @example
    #   Platform.extensions['shellcode']
    #   # => #<Ronin::Platform::Extension: ...>
    #
    def Platform.extensions
      @@ronin_extension_cache ||= ExtensionCache.new
    end

    #
    # Loads an extension into the extension cache, if it has yet to be
    # loaded.
    #
    # @param [String] name
    #   The name of the desired extension.
    #
    # @yield [ext]
    #   If a block is given, it will be passed the extension with the
    #   matching name.
    #
    # @yieldparam [Extension] ext
    #   The desired extension.
    #
    # @return [Extension]
    #   The desired extension.
    #
    # @raise [ExtensionNotFound]
    #   The extension with the specified name could not be found in any
    #   of the overlays or in the extension cache.
    #
    def Platform.extension(name,&block)
      ext = Platform.extensions[name]

      block.call(ext) if block
      return ext
    end

    #
    # Reloads the overlay cache and the extension cache.
    #
    # @return [Boolean]
    #   Specifies whether the reload was successful or not.
    #
    def Platform.reload!
      Platform.overlays.reload! && Platform.extensions.reload!
    end

    protected

    #
    # Provides transparent access to Platform.extension via constants.
    #
    # @param [String] name
    #   The constant name to map to an extension in the extension cache.
    #
    # @return [Extension]
    #   The extension that maps to the constant name.
    #
    # @raise [NameError]
    #   No extension could be found in the extension cache, that maps to the
    #   constant name.
    #
    # @example
    #   Ronin::Shellcode
    #   # => #<Ronin::Platform::Extension: @name="shellcode" ...>
    #
    def Platform.const_missing(name)
      name = name.to_s
      ext_name = name.snake_case

      if Platform.has_extension?(ext_name)
        return Platform.extension(ext_name)
      end

      return super(name)
    end

    #
    # Provides transparent access to Platform.extension via methods.
    #
    # @param [Symbol, String] name
    #   The name of the extension to search for within the extension cache.
    #
    # @yield [ext]
    #   If a block is given, it will be passed the extension which has the
    #   matching name.
    #
    # @yieldparam [Extension] ext
    #   The matching extension.
    #
    # @return [Extension]
    #   The matching extension.
    #
    # @raise [NoMethodError]
    #   No extension could be found in the extension cache with the
    #   matching name.
    #
    # @example
    #   shellcode
    #   # => #<Ronin::Platform::Extension: ...>
    #
    # @example
    #   shellcode do |ext|
    #     puts ext.exposed_methods
    #   end
    #
    def Platform.method_missing(name,*args,&block)
      if args.length == 0
        ext_name = name.id2name

        # return an extension if available
        if Platform.has_extension?(ext_name)
          return Platform.extension(ext_name,&block)
        end
      end

      return super(name,*args,&block)
    end
  end
end
