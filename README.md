# gentle-bronto-redesign
What makes this band website cool?

## Rails 4

## Facebook integration
The site pings the Facebook Graph API for the Gentle Brontosaurus page posts if today's date is more recent than the most recent FB post cached in the database, and retrieves any new ones. 
Posts that mention Facebook events trigger a load of the corresponding event.
This means that by using Facebook in a very natural way, this site is automatically kept up to date.

## Bootstrap and custom styling
I tried out UI elements from Materialize, Bootstrap 4, and settled on the current version of Bootstrap.

## SVG social media icons

## Custom UI elements
### Side-scrolling news feed with even columns
The news feed loads the entire history's worth of posts in one JSON-based HTTP request. The other option being to load them as they come into view, I felt that one slightly larger request would be more mobile-friendly than a separate request for every half dozen posts.
The columns of results are supposed to be roughly even in length (they "break" after about 300 px). To do this, the HTML for each post is rendered, and the posts are grouped into pages according to how they add up length-wise. Then the first two pages are shown. This seems like a quite normal idea that I didn't find explored in depth elsewhere.

### Music player with side-by-side tracklist
### Act I: the Embedded Player
Our story begins with a simple wish: to have the album cover and tracklist side by side, to minimize scrolling and conserve screen space on moderately wide displays. None of the standard embedded players for Bandcamp or Soundcloud offer this as an option.
My first approach was to have the album cover as an image with an art-less embedded player next to it. But the two elements didn't scale the same way, making it look mediocre. 
### Act II: the SDK
Soundcloud offers an API, including an endpoint for streaming tracks off the site. This offered the possibility of writing and styling a custom player. There's even a Codecademy tutorial that walks through this.
To make any API call to Soundcloud, you need to authenticate. I couldn't think of a way to call SC.connect from my client-side Javascript without exposing my client ID (API key) either in the code itself, or in the response to an HTTP request. Some people are careful with their client ID, some are not. I'd rather be one of the former.
There were also instructions on Soundcloud's API page for getting a streaming URL via Ruby. I thought I might be able to authenticate on the Rails server, and then have the client Javascript do the actual streaming. 
There were some issues with that. Authenticating the server didn't authenticate the client, bringing me back to the insecure client ID problem. Tracks can also have a "secret token", but only if they're non-public tracks, and it doesn't replace sending the client ID with the streaming request.
Also, when I sent a get request in Ruby to the stream_url attribute of the track, I didn't get back anything with a "location" attribute, like the instructions led me to expect. I got raw MP3 data. That might be good for pirating, and it looks like there are some sites exploiting the same thing in Python. But it defeats the purpose of streaming. Changing the allow_redirects/follow_redirects flag doesn't seem to make any difference.
Checking out the Javascript SDK source code, I saw that in SC.stream, the URL called is domain+"/tracks"+ID+"/streams". Whereas the track.stream_url attribute I'd been using was domain+"/tracks"+ID+"/stream". Tacking an "s" onto the end of the path, the response now, instead of being an MP3 file, included the URL of an MP3 file. Still no attribute called "location".
### Act III: Acceptance
The solution I settled on is to authenticate on the Rails side, and do a GET request to the /tracks/ID/streams path to get the temporary MP3 location for each track on the album. I use those to render HTML5 audio tags, which I can use Javascript to start/pause/stop based on user interactions with the visible elements of the DOM.
### Take-aways
Soundcloud's stream_url attribute is incorrect, and their /stream or /streams endpoints don't respond correctly to JSON flags. Their API documentation is also inaccurate. And if they expect developers to use the Javascript SDK while keeping their client ID secure, there needs to be a viable way to do that.

### Cards for upcoming events
I liked the idea of "cards" with background images, but in Bootstrap 4 it didn't look nice for me, so I cobbled together something like it on my own.

## Smooth scrolling to anchors
This was a short bit of jQuery code I found on CSS Tricks and modified a bit to taste.

## Background is from subtlepatterns.com