# gcstats #

A Ruby program that generates simple and clean statistics of your [Geocaching][gc] activity in HTML format ([sample][agorf]).

Also available online as a web app: <http://gcstats.heroku.com/>

[gc]: http://www.geocaching.com/
[agorf]: http://agorf.github.com/gcstats/agorf.html

## Install ##

From [RubyGems.org](http://rubygems.org/gems/gcstats):

    gem install gcstats

## Use ##

Visit the [Pocket Queries][pq] page and click the _Add to Queue_ button (under _My Finds_). After a while, you will receive an email informing you that your Pocket Query file is available for download. Visit the [Pocket Queries][pq] page again and download the file under the _Pocket Queries Ready for Download_ tab. Alternatively, you can use [pqdl][] to download your Pocket Query file from the command line.

Assuming your Pocket Query file is _1234567.zip_, issue:

    gcstats 1234567.zip mystats.html

This will write your statistics to _mystats.html_.

**Note:** You need to be a [Premium Member][pm] at [Geocaching.com][gc] to use [Pocket Queries][pq].

[pq]: http://www.geocaching.com/pocket/
[pqdl]: https://github.com/nano/pqdl
[pm]: https://www.geocaching.com/membership/

## License ##

(The MIT License)

Copyright (c) 2010-2011 Aggelos Orfanakos

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Author ##

[Aggelos Orfanakos](http://agorf.gr/), with contributions from [Thomas Cyron](http://thcyron.de/).
