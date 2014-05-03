# Jekyll Module to create monthly archive pages
#
# Shigeya Suzuki, November 2013
# Copyright notice (MIT License) attached at the end of this file
#

#
# This code is based on the following works:
#   https://gist.github.com/ilkka/707909
#   https://gist.github.com/ilkka/707020
#   https://gist.github.com/nlindley/6409459
#

#
# Archive will be written as #{archive_path}/#{year}/#{month}/index.html
# archive_path can be configured in 'path' key in 'monthly_archive' of
# site configuration file. 'path' is default null.
#

module Jekyll

  # Generator class invoked from Jekyll
  class MonthlyArchiveGenerator < Generator
    def generate(site)

      posts_group_by_year_and_month(site).each do |ym, list|
        site.pages << MonthlyArchivePage.new(site, archive_base(site),
                                             ym[0], ym[1], list)
      end

      posts_group_by_year(site).each do |year, list|
        site.pages << YearlyArchivePage.new(site, archive_base(site), year, list)
      end

    end

    def posts_group_by_year_and_month(site)
      site.posts.each.group_by { |post| [post.date.year, post.date.month] }
    end

    def posts_group_by_year(site)
      site.posts.each.group_by { |post| [post.date.year] }
    end

    def archive_base(site)
      site.config['monthly_archive'] && site.config['monthly_archive']['path'] || ''
    end
  end

  # Actual page instances
  class MonthlyArchivePage < Page

    ATTRIBUTES_FOR_LIQUID = %w[
      year,
      month,
      date,
      content
    ]

    def initialize(site, dir, year, month, posts)      
      # construct list of archive cf. [yyyy, mm]      
      # accessed through site.archive, which is 2D array 
      m = month.to_s
      if month < 10
        m = "0#{month}"
      end
      site.config['archive'] << [year, m]
      site.config['archive'] = site.config['archive'].uniq

      @site = site
      @dir = dir
      @name = 'monthly_archive.html' # added
      @year = year
      @month = month
      @archive_dir_name = '%04d/%02d' % [year, month]
      @date = Date.new(@year, @month)
      @layout =  site.config['monthly_archive'] && site.config['monthly_archive']['layout'] || 'monthly_archive'
      self.ext = '.html'
      self.basename = 'index'
      self.content  = <<-EOS
      {% for post in page.posts %}
        <h3><a href="{{post.url}}">{{post.title}}</a></h3>
        <p class="author">
         <span class="date">{{ post.date }}</span>
        </p>
        <hr />
        {% endfor %}
      EOS
      self.data = {
          'layout' => @layout,
          'type' => 'archive',
          'title' => "Monthly archive for #{@year}/#{@month}",
          'posts' => posts
      }

    end

    def render(layouts, site_payload)
      payload = {
          'page' => self.to_liquid,
          'paginator' => pager.to_liquid
      }.deep_merge(site_payload)
      do_layout(payload, layouts)
    end

    def to_liquid(attr = nil)
      self.data.deep_merge({
                               'content' => self.content,
                               'date' => @date,
                               'month' => @month,
                               'year' => @year
                           })
    end

    def destination(dest)
      File.join('/', dest, @dir, @archive_dir_name, 'index.html')
    end

  end

  # Yearly index archive page instance
  #
  #
  class YearlyArchivePage < Page

    ATTRIBUTES_FOR_LIQUID = %w[
      year,
      date,
      content
    ]

    def initialize(site, dir, year, posts)          

      @site = site
      @dir = dir
      @name = 'yearly_archive.html'
      @year = year
      @archive_dir_name = '%04d/' % year
      @layout =  site.config['yearly_archive'] && site.config['yearly_archive']['layout'] || 'yearly_archive'
      self.ext = '.html'
      self.basename = 'index'
      self.content  = <<-EOS
      {% for post in page.posts %}
        <h3><a href="{{post.url}}">{{post.title}}</a></h3>
        <p class="author">
         <span class="date">{{ post.date }}</span>
        </p>
        <hr />
        {% endfor %}
      EOS
      self.data = {
          'layout' => @layout,
          'type'   => 'archive',
          'title'  => "Yearly archive for #{@year}",
          'posts'  => posts
      }

    end

    def render(layouts, site_payload)
      payload = {
          'page' => self.to_liquid,
          'paginator' => pager.to_liquid
      }.deep_merge(site_payload)
      do_layout(payload, layouts)
    end

    def to_liquid(attr = nil)
      self.data.deep_merge({
                               'content' => self.content,
                               'year'    => @year
                           })
    end

    def destination(dest)
      File.join('/', dest, @dir, @archive_dir_name, 'index.html')
    end

  end
end

# The MIT License (MIT)
#
# Copyright (c) 2013 Shigeya Suzuki
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
