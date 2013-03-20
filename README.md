Mandula
=======

Description
-----------

Mandula is a simple video sharing site. It lets users log in with their Twitter account and upload new videos. The core of the architecture is a RabbitMQ messaging server that lets the app and the converters communicate.

Architecture
------------

1. We have a Rails app that serves JSON to a single-page Backbone.js app in the browser.
2. Backbone handles all of the GUI parts of this project
3. The RabbitMQ Server handles all the messaging between the moving parts
4. We have 3 different kinds of consumers:
 - Converter: converts videos from the uploaded format to mp4/aac
 - Mailer: sends the video owner an email after the conversion finished
 - Marker: marks the video as finished in the database

![Architecture](https://raw.github.com/wukerplank/Mandula/master/doc/mandula_architecture.png)

Installation
------------

If you want to run this app you will need to have Ruby (>=1.8.7) and RubyGems installed. To convert videos you will also need ffmpeg.

You can either download a ZIP package or clone the whole repository:

    git clone https://github.com/wukerplank/Mandula.git

Go to the cloned folder and install all the gems

    bundle

In order to connect to your RabbitMQ server you will have to set some environment variables like:

    export RABBIT_MQ_USER="guest"
    export RABBIT_MQ_PASSWORD="guest"
    export RABBIT_MQ_HOST="localhost"
    export RABBIT_MQ_PORT="5672"

After that you can start the app like this:

    rails s

You might also want to start the workers (each in their own console)

    rake mark

    rake mail

And finally the video converter. Before you can start the converter you'll have to set an environment variable with your ffmpeg path:

    export FFMPEG_PATH="/opt/local/bin/ffmpeg"
    
    rake convert

Now all the parts are in place and the app should be working. If you want to deploy the app you can also set variables with your Twitter credentials:

    export TWITTER_KEY="XXXXXXXXXXX"
    export TWITTER_SECRET="XXXXXXXXXXXXX"


Copyright
---------

Copyright (C) 2013 Christoph Edthofer & Lukas Mayerhofer

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.