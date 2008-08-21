#
#--
# Ronin - A Ruby platform designed for information security and data
# exploration tasks.
#
# Copyright (c) 2006-2008 Hal Brodigan (postmodern.mod3 at gmail.com)
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
#++
#

require 'ronin/network/extensions/imap'

module Ronin
  module Network
    module IMAP
      # Default imap port
      DEFAULT_PORT = 143

      #
      # Returns the default Ronin IMAP port.
      #
      def IMAP.default_port
        @@imap_default_port ||= DEFAULT_PORT
      end

      #
      # Sets the default Ronin IMAP port to the specified _port_.
      #
      def IMAP.default_port=(port)
        @@imap_default_port = port
      end
    end
  end
end
