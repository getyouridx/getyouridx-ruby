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

require 'net/http'
require 'rexml/document'

# The IDXException class represents exceptions raised.
# @category   IDX
# @package    IDX
# @copyright  Copyright (c) GetYourIDX.com. (http://www.getyouridx.com)
# @license    GNU General Public License
class IDXException<Exception;
end

# The IDXFilter interface represents classes used to specify IDX data result filters.
# @category   IDX
# @package    IDX
# @copyright  Copyright (c) GetYourIDX.com. (http://www.getyouridx.com)
# @license    GNU General Public License
class IDXFilter;
end

# The IDXFilter_Limit class specifies a filter to limit the result.
# @category   IDX
# @package    IDX
# @copyright  Copyright (c) GetYourIDX.com. (http://www.getyouridx.com)
# @license    GNU General Public License
class IDXFilter_Limit<IDXFilter;
    attr_accessor :limit
    def initialize(limit)
        @limit = limit
    end
    def to_s()
        "&limit=" + @limit
    end
end

# The IDXFilter_Format class specifies a filter to format the result.
# @category   IDX
# @package    IDX
# @copyright  Copyright (c) GetYourIDX.com. (http://www.getyouridx.com)
# @license    GNU General Public License
class IDXFilter_Format<IDXFilter;
    attr_accessor :format
    def initialize(format)
        @format = format
    end
    def to_s()
        "&format=" + @format
    end
end

# The IDXFilter_Range class specifies a filter based a range.
# @category   IDX
# @package    IDX
# @copyright  Copyright (c) GetYourIDX.com. (http://www.getyouridx.com)
# @license    GNU General Public License
class IDXFilter_Range<IDXFilter;
    attr_accessor :field, :min, :max
    def initialize(field, min, max)
        @field = field
        @min = min
        @max = max
    end
    def to_s()
        "&fge_" + @field + "=" + @min + "&fle_" + @field + "=" + @max
    end
end

# The IDXFilter_Offset class specifies a filter to specify the paging offset.
# @category   IDX
# @package    IDX
# @copyright  Copyright (c) GetYourIDX.com. (http://www.getyouridx.com)
# @license    GNU General Public License
class IDXFilter_Offset<IDXFilter;
    attr_accessor :offset
    def initialize(offset)
        @offset = offset
    end
    def to_s()
        "&offset=" + @offset
    end
end

# The IDXFilter_Sort class specifies a filter on sort the query.
# @category   IDX
# @package    IDX
# @copyright  Copyright (c) GetYourIDX.com. (http://www.getyouridx.com)
# @license    GNU General Public License
class IDXFilter_Sort<IDXFilter;
    attr_accessor :field, :direction
    def initialize(field, direction)
        @field = field
    end
    def to_s()
        "&sort=" + @field + ":" + @direction
    end
end

# The IDXFilter_LessThan class specifies a filter to query a field with a LessThan operator.
# @category   IDX
# @package    IDX
# @copyright  Copyright (c) GetYourIDX.com. (http://www.getyouridx.com)
# @license    GNU General Public License
class IDXFilter_LessThan<IDXFilter;
    attr_accessor :field, :value
    def initialize(field, value)
        @field = field
        @value = value
    end
    def to_s()
        "&fle_" + @field + "=" + @value
    end
end

# The IDXFilter_GreaterThan class specifies a filter to query a field with a GreaterThan operator.
# @category   IDX
# @package    IDX
# @copyright  Copyright (c) GetYourIDX.com. (http://www.getyouridx.com)
# @license    GNU General Public License
class IDXFilter_GreaterThan<IDXFilter;
    attr_accessor :field, :value
    def initialize(field, value)
        @field = field
        @value = value
    end
    def to_s()
        "&fge_" + @field + "=" + @value
    end
end

# The IDXFilter_Equals class specifies a filter to query a field with a Equals operator.
# @category   IDX
# @package    IDX
# @copyright  Copyright (c) GetYourIDX.com. (http://www.getyouridx.com)
# @license    GNU General Public License
class IDXFilter_Equals<IDXFilter;
    attr_accessor :field, :value
    def initialize(field, value)
        @field = field
        @value = value
    end
    def to_s()
        "&feq_" + @field + "=" + @value
    end
end

# The IDXFilter_In class specifies a filter to query a field where the value is equal to one of the passed array items.
# @category   IDX
# @package    IDX
# @copyright  Copyright (c) GetYourIDX.com. (http://www.getyouridx.com)
# @license    GNU General Public License
class IDXFilter_In<IDXFilter;
    attr_accessor :field, :value
    def initialize(field, value)
        @field = field
        @value = value
    end
    def to_s()
        "&fin_" + @field + "=" + @value.join(",")
    end
end

# The IDXSearch class allows requesting data from the GetYourIDX Service based on a number of filters.
# @category   IDX
# @package    IDX
# @copyright  Copyright (c) GetYourIDX.com. (http://www.getyouridx.com)
# @license    GNU General Public License
class IDXSearch;
    attr_accessor :apikey, :service_url, :filters
    def initialize(apikey)
        @service_url = "http://www.getyouridx.com/api/property/"
        @apikey = apikey
        @filters = Array.new()
    end
    def add_filter(filter)
        @filters << filter
    end
    def result()
        url = @service_url + build_querystring
        xml_data = Net::HTTP.get_response(URI.parse(url)).body
        REXML::Document.new(xml_data)
    end
    def build_querystring()
        querystring = "?apikey=" + @apikey;
        @filters.each do |i|
            querystring = querystring + i.to_s
        end
        puts querystring
        querystring
    end
end
