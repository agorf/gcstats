require 'gcstats/caches'
require 'gcstats/template'
require 'zip/zip'
require 'sinatra'

module GCStats
  module Server
    get '/' do
      %{\
    <html>
      <head>
        <title>gcstats</title>
        <style type="text/css">body { font-family: sans-serif; }</style>
      </head>
      <body>
        <form enctype="multipart/form-data" action="/generate_stats" method="post">
          <label for="pq">Pocket Query (.zip or .gpx):</label>
          <input type="file" id="pq" name="pq" />
          <input type="submit" value="Generate Stats" />
        </form>
        <a href="http://github.com/agorf/gcstats"><img
          style="position: absolute; top: 0; right: 0; border: 0;"
          src="http://s3.amazonaws.com/github/ribbons/forkme_right_green_007200.png"
          alt="Fork me on GitHub" /></a>
      </body>
    </html>
    }
    end

    post '/generate_stats' do
      begin
        start_ts = Time.new # for render_time helper

        pq = params['pq']

        if pq[:type] == 'application/zip'
          data = nil

          Zip::ZipFile.foreach(pq[:tempfile].path) {|entry|
            if File.extname(entry.name) == '.gpx'
              data = entry.get_input_stream.read
              break
            end
          }
        else
          data = pq[:tempfile].read
        end

        libdir = File.dirname(__FILE__)

        rhtml = open(File.join(libdir, 'gcstats.rhtml')).read
        caches = GCStats::Caches.from_xml(data)
        data = {:caches => caches, :start_ts => start_ts}
        html = GCStats::Template.new(rhtml, data).result
        html.sub!('/* %css% */', "\n" + File.read(File.join(libdir, 'gcstats.css')))
        html.sub!('/* %js% */', "\n" + File.read(File.join(libdir, 'gcstats.js')))

        return html
      rescue
        halt 500, '<h1>Internal Server Error</h1>'
      end
    end

    not_found do
      '<h1>Not Found</h1>'
    end
  end
end
