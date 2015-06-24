# lita-status

[![Build Status](https://travis-ci.org/visioncritical/lita-status.png?branch=master)](https://travis-ci.org/visioncritical/lita-status)

## Installation

Add lita-status to your Lita instance's Gemfile:

``` ruby
gem "lita-status", :git => "https://github.com/visioncritical/lita-status"
```

## Usage

```
litabot status set STATUS_MESSAGE - Sets your status
litabot status on behalf set USER PASSWORD STATUS_MESSAGE - Allows a bot to set your status
litabot status get [USER] - Get a user's status or your own if a user is not specified
litabot statuses - Returns all statuses
litabot status remove - Removes your status
litabot status remove USER PASSWORD - Allows a bot to remove your status
litabot status password set PASSWORD - Sets a password (WARNING: stored in plain text inside Redis)
litabot status password remove - Removes your password
```

```
Some User [6:18 PM] 
litabot status set Looking at Cat gifs

Litabot [6:18 PM] 
Some User has a new status.

Other User [7:25 PM] 
litabot statuses

Litabot [7:25 PM] 
Some User: Looking at Cat gifs
```

## License

The MIT License (MIT)

Copyright (c) 2015 Vision Critical

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.