=begin

Copyright 2009  GetYourIDX (email : info@getyouridx.com)

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


Created on Nov 11, 2009
@author: Paul Trippett (paul@getyourview.com)
@copyright: 2009 GetYourView LLC
@organization: GetYourView LLC

=end

require 'getyouridx'
idx_search = IDXSearch.new('YOUR_API_KEY')
idx_search.add_filter(IDXFilter_In.new('mls_id', ['MLS_SHORT_CODE']))
puts idx_search.result
